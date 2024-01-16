import 'message_model.dart';

class SupportChatModel {
  SupportChatModel({required this.ticketID, List<MessageModel>? messages})
      : _messages = messages ?? [];
  factory SupportChatModel.fromJson(Map<String, dynamic> json) {
    final savedMessages = json['messages'] as List<dynamic>;

    final messages = <MessageModel>[];
    for (final element in savedMessages) {
      if (element is Map<String, dynamic>) {
        final messageModel = MessageModel.fromJson(element);

        messages.add(messageModel);
      }
    }
    return SupportChatModel(
      ticketID: json['ticketID'] as String,
      messages: messages,
    );
  }

  final String ticketID;

  List<MessageModel> _messages;
  Map<String, dynamic> toJson() {
    final message = <Map<String, dynamic>>[];

    for (final element in _messages) {
      message.add(element.toJson());
    }
    return {
      'ticketID': ticketID,
      'messages': message,
    };
  }

  void addTomessages(MessageModel message) {
    _messages.add(message);
  }
}
