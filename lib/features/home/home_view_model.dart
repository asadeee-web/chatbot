import 'package:chatbot/core/services/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeViewModel extends ChangeNotifier {
  final GeminiService geminiService = GeminiService();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';

  List<Map<String, String>> messages = [];

  final List<Map<String, dynamic>> cardData = [
    {
      "icon": Icons.code,
      "title": "Fix Bug From Your Code",
      "description":
          "Fix my bug from below code. I can't find where is the issue. Do it in details and explain me why ha...",
      "buttonColor": const Color(0xFF4C4D9F),
      "iconBgColor": const Color(0xFFE0E7FF),
      "iconColor": const Color(0xFF4C4D9F),
    },
    {
      "icon": Icons.format_paint,
      "title": "Improve UI Design",
      "description":
          "Suggest better UI improvements for my current Flutter design. Keep it modern and simple.",
      "buttonColor": Colors.green,
      "iconBgColor": Colors.lightGreenAccent,
      "iconColor": Colors.green,
    },
    {
      "icon": Icons.warning,
      "title": "Debug Warning/Error",
      "description":
          "Explain why this warning/error is happening and how to fix it step by step.",
      "buttonColor": Colors.red,
      "iconBgColor": Colors.redAccent.shade100,
      "iconColor": Colors.red.shade700,
    },
  ];
  bool isLoading = false;

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  HomeViewModel() {
    initSpeechToText();
    initTextToSpeech();
    focusNodeLister();
  }

  focusNodeLister() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 300), () {
          scrollToBottom();
        });
      }
    });
  }

  Future<void> askGemini() async {
    if (textController.text.isEmpty) return;

    final userMessage = textController.text;

    messages.add({"sender": "user", "message": userMessage});
    isLoading = true;
    notifyListeners();

    textController.clear();

    messages.add({"sender": "bot", "message": ""});
    notifyListeners();

    final response = await geminiService.getResponse(userMessage);

    isLoading = false;
    // Replace placeholder with real response
    messages[messages.length - 1] = {
      "sender": "bot",
      "message": response ?? "Failed to get a response. Please try again.",
    };

    scrollToBottom();
    notifyListeners();
  }

  void onGetAnswer(String prompt) {
    textController.text = prompt;
    askGemini();
    notifyListeners();
  }

  void onEditPrompt(String prompt) {
    textController.text = prompt;
    notifyListeners();
  }

  ////
  ///Voice Assistant
  ///
  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    notifyListeners();
  }

  Future<void> initSpeechToText() async {
    var status = await Permission.microphone.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.microphone.request();
    }

    if (status.isGranted) {
      await speechToText.initialize(
        onStatus: (status) => print('Speech status: $status'),
        onError: (error) => print('Speech error: $error'),
      );
    } else {
      print("Microphone permission not granted");
    }
    notifyListeners();
  }

  bool isListening = false;

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    isListening = true;
    print("start listening");
    notifyListeners();
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    isListening = false;
    print("Listening Stopped");
    notifyListeners();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords = result.recognizedWords;

    textController.text = lastWords;

    textController.selection = TextSelection.fromPosition(
      TextPosition(offset: textController.text.length),
    );

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }
}
