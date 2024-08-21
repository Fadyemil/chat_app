class ChatUserModel {
  String? id;
  String? name;
  String? email;
  String? about;
  String? image;
  String? createdAt;
  String? lastActivated;
  String? puchToken;
  bool? online;
  List? myUsers;

  ChatUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
    required this.image,
    required this.createdAt,
    required this.lastActivated,
    required this.puchToken,
    required this.online,
    required this.myUsers,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      about: json['about'],
      image: json['image'],
      createdAt: json['created_at'],
      lastActivated: json['last_activated'],
      puchToken: json['puch_token'],
      online: json['online'],
      myUsers: json['my_users'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'about': about,
      'image': image,
      'created_at': createdAt,
      'last_activated': lastActivated,
      'puch_token': puchToken,
      'online': online,
      'my_users': myUsers,
    };
  }
}
