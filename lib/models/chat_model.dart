class ChatModel {
  final String msg;
  final int chatInd;
  ChatModel({required this.msg, required this.chatInd});
  factory ChatModel.fromJson(Map json) {
    return ChatModel(
      msg: json['msg'],
      chatInd: json['chatInd'],
    );
  }
}
