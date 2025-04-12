import 'package:flutter/material.dart';

class Bird extends StatefulWidget {
  const Bird({super.key});

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  // double _size = 1.0;

  String Output = '';
  int n = 0;
  bool con = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,

        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  Output = value;
                });
              },
            ),
            Text('$Output'),
            TextButton(
              onPressed:
                  () => setState(() {
                    n = n + 1;
                    con = !con;
                  }),
              child: Text('Add'),
            ),
            Text('sum is $n'),
            con ? Text('was true ') : Text('was false'),
            Positioned.fill(
              left: 21,
              top: 20,
              child: Container(height: 100, width: 50, child: Text('ahaaaa')),
            ),
          ],
        ),
      ),
    );
  }
}
