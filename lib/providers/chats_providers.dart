import 'package:chat_gpt_flutter/services/api_services.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List chatList = [];
  List get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatInd: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelID}) async {
    chatList.addAll(
        await Apiservice.sendMessage(message: msg, modelId: chosenModelID));
    notifyListeners();
  }
}
