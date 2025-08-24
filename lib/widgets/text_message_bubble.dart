import 'package:chatbot/widgets/custom_markdown_text.dart';
import 'package:flutter/material.dart';

class TextMessageBubble extends StatelessWidget {
  final String profileImage;
  final String senderName;
  final String message;

  const TextMessageBubble({
    super.key,
    required this.profileImage,
    required this.senderName,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  profileImage,
                  width: 30,
                  height: 30,
                  fit: senderName == "You" ? BoxFit.cover : BoxFit.contain,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                senderName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          CustomMarkdown(data: message),
        ],
      ),
    );
  }
}
