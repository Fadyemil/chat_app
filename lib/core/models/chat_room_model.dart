class ChatRoomModel {
  String? id;
  String? createdAt;
  List? members;
  String? lastMessage;
  String? latestMessageTime;

  ChatRoomModel({
    required this.id,
    required this.createdAt,
    required this.members,
    required this.lastMessage,
    required this.latestMessageTime,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'] ?? "",
      createdAt: json['created_at'],
      members: json['members'] ?? [],
      lastMessage: json['last_message'] ?? "",
      latestMessageTime: json['latest_message_time'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'last_message': lastMessage,
      'latest_message_time': latestMessageTime,
      'members': members,
    };
  }
}
