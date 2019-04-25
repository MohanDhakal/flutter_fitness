class User {
  final String userId;
  final String fullname;
  final String email;

  User(this.userId, this.fullname, this.email) ;

  static User fromJson(Map<String, dynamic> data) {
    return User(data['userId'], data['fullName'], data['email']);
  }
}
