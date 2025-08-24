import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/vs2015.dart';

class CustomHighlightView extends StatelessWidget {
  final String code;
  final String language;

  const CustomHighlightView({
    super.key,
    required this.code,
    this.language = "dart",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.only(top: 28, bottom: 12, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 0.5),
      ),
      width: double.infinity,
      child: Stack(
        children: [
          HighlightView(
            code,
            language: language,
            theme: vs2015Theme,
            padding: const EdgeInsets.all(8),
            textStyle: const TextStyle(
              fontFamily: "monospace",
              fontSize: 14,
              height: 1.5,
            ),
          ),

          // Top bar with language & copy button
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.copy, color: Colors.white70, size: 18),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: code));
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Code copied!")));
              },
            ),
          ),
        ],
      ),
    );
  }
}
