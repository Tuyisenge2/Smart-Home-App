import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class CloudinaryUtils {
  
  Future<String?> uploadImage(File imageFile) async {
    try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dcxbetrsj/upload');
           final request =
          http.MultipartRequest('POST', url)
            ..fields['upload_preset'] = 'presetUpload'
            ..files.add(
              await http.MultipartFile.fromPath('file',imageFile.path),
            );
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        return jsonMap['secure_url'] ?? jsonMap['url'];
      } else {
        throw Exception('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      print('Cloudinary upload error: $e');
      rethrow;
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
  }


