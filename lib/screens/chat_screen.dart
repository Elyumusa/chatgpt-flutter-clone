import 'package:chat_gpt_flutter/constants/constants.dart';
import 'package:chat_gpt_flutter/models/chat_model.dart';
import 'package:chat_gpt_flutter/providers/chats_providers.dart';
import 'package:chat_gpt_flutter/services/api_services.dart';
import 'package:chat_gpt_flutter/services/asset_manager.dart';
import 'package:chat_gpt_flutter/services/services.dart';
import 'package:chat_gpt_flutter/widgets/chat_widget.dart';
import 'package:chat_gpt_flutter/widgets/text_idget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController _listscrollController;
  late FocusNode focusNode;
  @override
  void initState() {
    // TODO: implement initState
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    _listscrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _listscrollController.dispose();
    focusNode.dispose();
    textEditingController.dispose();
  }

  List chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  Services.modalSheet(context);
                },
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ))
          ],
          elevation: 2,
          title: const Text("ChatGPT"),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetManager.openailogo),
          )),
      body: SafeArea(
          child: Column(children: [
        Flexible(
          child: ListView.builder(
            controller: _listscrollController,
            itemCount: chatProvider.getChatList.length,
            itemBuilder: (context, index) {
              return ChatWidget(
                msg: chatProvider.getChatList[index].msg.toString(),
                chatInd: int.parse(
                    chatProvider.getChatList[index].chatInd.toString()),
              );
            },
          ),
        ),
        if (isTyping) ...[
          SpinKitThreeBounce(
            color: Colors.white,
            size: 18,
          ),
        ],
        Material(
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  focusNode: focusNode,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration.collapsed(
                      hintText: "How can I help you",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: textEditingController,
                  onSubmitted: (value) async {
                    await send_message(
                        modelsProvider: modelsProvider,
                        chatProvider: chatProvider);
                  },
                )),
                IconButton(
                    onPressed: () async {
                      await send_message(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider);
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        )
      ])),
    );
  }

  void scrolllistToEND() {
    _listscrollController.animateTo(
        _listscrollController.position.maxScrollExtent,
        duration: Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> send_message(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    if (textEditingController.text.isEmpty) {
      return;
    }
    if (isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("You can not request two messages at the same time")));
      return;
    }
    try {
      setState(() {
        isTyping = true;
        //chatList.add(ChatModel(msg: textEditingController.text, chatInd: 0));
        chatProvider.addUserMessage(msg: textEditingController.text);
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
          msg: textEditingController.text,
          chosenModelID: modelsProvider.getCurrentModel);
      /*chatList.addAll(await Apiservice.sendMessage(
          message: textEditingController.text,
          modelId: modelsProvider.getCurrentModel));*/
      // setState(() {});
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextWidget(label: e.toString()),
            backgroundColor: Colors.white,
          );
        },
      );
    } finally {
      setState(() {
        scrolllistToEND();
        isTyping = false;
      });
    }
  }
}
