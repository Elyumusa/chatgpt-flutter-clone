import 'package:chat_gpt_flutter/constants/constants.dart';
import 'package:chat_gpt_flutter/providers/models_provider.dart';
import 'package:chat_gpt_flutter/services/api_services.dart';
import 'package:chat_gpt_flutter/widgets/text_idget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/models_model.dart';

class ModelDropDownWidget extends StatefulWidget {
  const ModelDropDownWidget({super.key});

  @override
  State<ModelDropDownWidget> createState() => _ModelDropDownWidgetState();
}

class _ModelDropDownWidgetState extends State<ModelDropDownWidget> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelsProvider.getCurrentModel;
    return FutureBuilder(
      future: modelsProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ModelsModel> models = snapshot.data!;
          print("object: $models");
          return FittedBox(
            child: DropdownButton(
                value: currentModel,
                dropdownColor: scaffoldBackgroundColor,
                iconEnabledColor: Colors.white,
                items: List<DropdownMenuItem<String>>.generate(
                    models.length,
                    (index) => DropdownMenuItem(
                        value: models[index].id,
                        child: TextWidget(
                          label: models[index].id,
                          fontsize: 15,
                        ))),
                onChanged: (value) {
                  modelsProvider.setCurrentModel(value.toString());
                  setState(() {
                    // currentModel = value.toString();
                  });
                }),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(label: snapshot.error.toString()),
            );
          } else {
            return SizedBox.shrink();
          }
        }
      },
    );
  }
}
/*
 */