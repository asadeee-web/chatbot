import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CustomMarkdown extends StatelessWidget {
  final String data;

  const CustomMarkdown({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: data,
      styleSheet:
          MarkdownStyleSheet(
            h1: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            h2: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            h3: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            p: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
            strong: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            code: const TextStyle(
              backgroundColor: Color(0xFFF5F5F5),
              color: Colors.black87,
              fontFamily: "monospace",
            ),
          ).copyWith(
            h1Padding: const EdgeInsets.only(top: 16, bottom: 8),
            h2Padding: const EdgeInsets.only(top: 14, bottom: 6),
            h3Padding: const EdgeInsets.only(top: 12, bottom: 4),
            pPadding: const EdgeInsets.symmetric(vertical: 6),

            // Divider line after headings
            horizontalRuleDecoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
          ),
    );
  }
}
