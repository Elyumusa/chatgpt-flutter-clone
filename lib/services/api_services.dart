import 'dart:convert';
import 'dart:io';

import 'package:chat_gpt_flutter/constants/api_consts.dart';
import 'package:chat_gpt_flutter/models/chat_model.dart';
import 'package:http/http.dart' as http;

import '../models/models_model.dart';

class Apiservice {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/models"),
          headers: {"Authorization": "Bearer ${apiKey}"});
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      } else {
        List temp = jsonResponse['data'];
        return ModelsModel.modelsFromsnapshot(temp);
      }
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }

  static Future sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(
          Uri.parse(
            "$baseUrl/chat/completions",
          ),
          body: jsonEncode({
            'messages': [
              {
                "role": "user",
                "content": message,
              }
            ],
            "temperature": 0.7,
            "model": modelId
          }),
          headers: {
            "Authorization": "Bearer ${apiKey}",
            "Content-Type": "application/json"
          });
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      } else {
        List chatList = [];
        if (jsonResponse['choices'].length > 0) {
          chatList = jsonResponse['choices'].map((o) {
            return ChatModel(msg: o['message']['content'], chatInd: 1);
          }).toList();
          print("temp: $chatList");
        }
        return chatList;
      }
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }
}
