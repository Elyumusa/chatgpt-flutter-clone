import 'package:chat_gpt_flutter/widgets/drop_down.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/text_idget.dart';

class Services {
  static Future<void> modalSheet(BuildContext context) async {
    return await showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      backgroundColor: scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                  child: TextWidget(
                label: "Chosen Model",
                fontsize: 16,
              )),
              SizedBox(
                width: 8,
              ),
              Flexible(
                child: ModelDropDownWidget(),
                flex: 2,
              )
            ],
          ),
        );
      },
    );
  }
}
