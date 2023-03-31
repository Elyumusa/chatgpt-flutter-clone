import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt_flutter/constants/constants.dart';
import 'package:chat_gpt_flutter/services/asset_manager.dart';
import 'package:chat_gpt_flutter/widgets/text_idget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.chatInd, required this.msg});
  final String msg;
  final int chatInd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatInd == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatInd == 0 ? AssetManager.userImage : AssetManager.botImage,
                  height: 30,
                  width: 30,
                ),
                SizedBox(width: 8),
                Expanded(
                    child: chatInd == 0
                        ? TextWidget(label: msg)
                        : DefaultTextStyle(
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                            child: AnimatedTextKit(
                                isRepeatingAnimation: false,
                                repeatForever: false,
                                displayFullTextOnTap: true,
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TyperAnimatedText(msg.trim())
                                ]))),
                chatInd == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
