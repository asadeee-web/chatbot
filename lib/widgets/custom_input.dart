import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback ontap;
  final VoidCallback? onFocus;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  final bool isListening;

  const InputBar({
    super.key,
    required this.controller,
    required this.ontap,
    this.onFocus,
    required this.focusNode,
    this.onChanged,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                bottom: 10,
                top: 12,
              ),
              margin: const EdgeInsets.only(left: 6, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 30,
                  maxHeight: 150,
                ),
                child: Scrollbar(
                  child: TextField(
                    focusNode: focusNode,
                    controller: controller,
                    onChanged: onChanged,
                    onTap: onFocus,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Ask what\'s on your mind...',
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
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
                  ? const Icon(Icons.stop, color: Colors.white)
                  : controller.text.isEmpty
                  ? const Icon(Icons.mic, color: Colors.white)
                  : const Icon(Icons.send, color: Colors.white),
              onPressed: ontap,
            ),
          ),
        ],
      ),
    );
  }
}
