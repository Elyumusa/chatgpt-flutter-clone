import 'package:chat_gpt_flutter/models/models_model.dart';
import 'package:chat_gpt_flutter/services/api_services.dart';
import 'package:flutter/material.dart';

class ModelsProvider with ChangeNotifier {
  List<ModelsModel> modelsList = [];
  String currentModel = 'gpt-3.5-turbo';
  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String model) {
    currentModel = model;
    notifyListeners();
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await Apiservice.getModels();
    return modelsList;
  }
}
