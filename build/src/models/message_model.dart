class MessageModel {
  MessageModel({required this.id, required this.message, DateTime? createdAt})
      : _createdAt = createdAt ?? DateTime.now();

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      message: json['message'] as String,
      createdAt: DateTime.tryParse(
        json['createdAt'] as String,
      ),
    );
  }

  final String id;

  final String message;

  DateTime _createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'createdAt': _createdAt.toIso8601String()
    };
  }
}
