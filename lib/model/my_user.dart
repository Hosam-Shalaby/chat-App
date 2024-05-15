class MyUser {
  static const String collectionName = 'users';
  String? id;
  String? userName;
  String? fullName;
  String? email;
  MyUser({this.id, this.userName, this.fullName, this.email});
  MyUser.fromFireStore(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['username'];
    fullName = json['fullName'];
    email = json['email'];
  }
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'username': userName,
      'fullName': fullName,
      'email': email
    };
  }
}
