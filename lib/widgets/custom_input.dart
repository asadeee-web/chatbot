import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback ontap;
  final VoidCallback? onFocus;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  final bool isListening; // ✅ add state

  const InputBar({
    super.key,
    required this.controller,
    required this.ontap,
    this.onFocus,
    required this.focusNode,
    this.onChanged,
    required this.isListening, // ✅ required
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(left: 6, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              onChanged: onChanged,
              onTap: onFocus,
              decoration: const InputDecoration(
                hintText: 'Ask what\'s on mind...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          margin: const EdgeInsets.only(right: 8, bottom: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF6554F4),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: isListening
                ? const Icon(Icons.stop, color: Colors.white) // ⏹ Stop
                : controller.text.isEmpty
                ? const Icon(Icons.mic, color: Colors.white) // 🎤 Mic
                : const Icon(Icons.send, color: Colors.white), // 📩 Send
            onPressed: ontap,
          ),
        ),
      ],
    );
  }
}
