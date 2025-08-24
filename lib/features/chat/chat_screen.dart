import 'package:flutter/material.dart';
import 'package:chatbot/features/home/home_view_model.dart';
import 'package:chatbot/widgets/custom_highlight_view.dart';
import 'package:chatbot/widgets/custom_loader.dart';
import 'package:chatbot/widgets/text_message_bubble.dart';

class ChatScreen extends StatelessWidget {
  final HomeViewModel model;

  const ChatScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      controller: model.scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount: model.messages.length,
      itemBuilder: (context, index) {
        final isLastMessage = index == model.messages.length - 1;
        final msg = model.messages[index];
        final isUser = msg["sender"] == "user";
        final message = msg["message"]!;

        if (!isUser && model.isLoading && isLastMessage) {
          return CustomLoader();
        }

        final regex = RegExp(r"```([\s\S]*?)```");
        final match = regex.firstMatch(message);

        if (match != null) {
          final code = match.group(1)!;
          return Column(
            crossAxisAlignment: isUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              TextMessageBubble(
                profileImage: isUser
                    ? "assets/images/asad.PNG"
                    : "assets/images/bot.png",
                senderName: isUser ? "You" : "Rak-GPT",
                message: message.replaceAll(regex, "").trim(),
              ),
              const SizedBox(height: 6),
              CustomHighlightView(code: code, language: "dart"),
            ],
          );
        }

        return TextMessageBubble(
          profileImage: isUser
              ? "assets/images/asad.PNG"
              : "assets/images/bot.png",
          senderName: isUser ? "You" : "Bot",
          message: message,
        );
      },
    );
  }
}
