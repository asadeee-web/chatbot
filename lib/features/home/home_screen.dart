import 'package:chatbot/features/chat/chat_screen.dart';
import 'package:chatbot/features/home/home_view_model.dart';
import 'package:chatbot/features/welcome/welcome_screen.dart';
import 'package:chatbot/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFEFEFEF),
            appBar: _appBar(context, model),
            body: Column(
              children: [
                Expanded(
                  child: model.messages.isEmpty
                      ? WelcomeScreen(model: model)
                      : ChatScreen(model: model),
                ),
                InputBar(
                  controller: model.textController,
                  focusNode: model.focusNode,
                  isListening: model.isListening,
                  onFocus: () {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      model.scrollToBottom();
                    });
                  },
                  onChanged: (value) => model.uiResfresh(),
                  ontap: () {
                    if (model.isListening) {
                      model.stopListening();
                    } else if (model.textController.text.isEmpty) {
                      model.startListening();
                    } else {
                      model.askGemini();
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context, HomeViewModel model) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: const Text(
        'ChatBot',
        style: TextStyle(color: Color(0xFF333333), fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Color(0xFF666666)),
          onPressed: () {
            model.clearMessagesList();
          },
        ),
      ],
    );
  }
}
