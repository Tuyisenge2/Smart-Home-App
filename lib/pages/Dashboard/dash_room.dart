import 'package:flutter/material.dart';

class DashRoom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: ElevatedButton(
          child: Text("modal here", style: TextStyle(color: Colors.black)),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        "here is my modal brother",
                        style: TextStyle(color: Colors.black, fontSize: 23),
                      ),
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 400,
                                width: double.infinity,
                                color: Colors.red,
                              );
                            },
                          );
                        },
                        child: Text("second modal"),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
