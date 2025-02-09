import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: Container(
        height: 120,
        child: Column(
          children: [
            //get user input
            TextField(),

            //buttons ->save + cancel
          ],
        ),
      ),
    );
  }
}
