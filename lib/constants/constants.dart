import 'package:chat_gpt_flutter/widgets/text_idget.dart';
import 'package:flutter/material.dart';

Color scaffoldBackgroundColor = const Color(0xFF343541);
Color cardColor = const Color(0xFF444654);
List<String> models = [
  "Model1",
  "Model2",
  "Model3",
  "Model4",
  "Model5",
  "Model6"
];
List<DropdownMenuItem<String>>? get getModelsItem {
  List<DropdownMenuItem<String>> modelItems =
      List<DropdownMenuItem<String>>.generate(
          models.length,
          (index) => DropdownMenuItem(
                  child: TextWidget(
                label: models[index],
                fontsize: 15,
              )));
  return modelItems;
}

final chatMessages = [
  {"msg": "Hello who are you?", "chatInd": 0},
  {
    "msg": "Hello, I am ChatGPT, a large language model developed by OpenAI",
    "chatInd": 1
  },
];
