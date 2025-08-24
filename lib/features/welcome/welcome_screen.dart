import 'package:flutter/material.dart';
import 'package:chatbot/features/home/home_view_model.dart';
import 'package:chatbot/widgets/custom_prompt_card.dart';

class WelcomeScreen extends StatelessWidget {
  final HomeViewModel model;

  const WelcomeScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: model.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/bot.png",
            height: 150,
            width: 150,
            fit: BoxFit.contain,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              "Hello mate, I’m ready to help you.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Ask me anything what\'s are on your mind. Am here to assist you!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 230,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: model.cardData.length,
              itemBuilder: (context, index) {
                final card = model.cardData[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CustomPromptCard(
                    icon: card["icon"],
                    title: card["title"],
                    description: card["description"],
                    buttonColor: card["buttonColor"],
                    iconBgColor: card["iconBgColor"],
                    iconColor: card["iconColor"],
                    onGetAnswer: (desc) {
                      model.onGetAnswer(desc);
                    },
                    onEditPrompt: (desc) {
                      model.onGetAnswer(desc);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
