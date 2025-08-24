import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              "assets/images/bot.png",
              width: 30,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(width: 5),
          Text("Thinking..."),
        ],
      ),
    );
  }
}
