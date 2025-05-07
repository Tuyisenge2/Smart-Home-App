import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    final authService = context.read<AuthService>();
    await authService.loadToken();
    if (mounted) {
      final router = GoRouter.of(context);
      router.go(authService.isAuthenticated ? '/dashboard' : '/hero');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
