class MyUser {
  static const String userCollection = 'users';
  String? id;
  String? name;
  String? email;

  MyUser({
    required this.email,
    required this.id,
    required this.name,
  });

  factory MyUser.fromJson(data) {
    return MyUser(
        email: data['email'] as String?,
        id: data['id'] as String?,
        name: data['name'] as String?);
  }

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
