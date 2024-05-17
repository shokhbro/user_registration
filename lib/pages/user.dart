class UserService {
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  final List<Map<String, String>> _users = [];

  void register(String email, String password) {
    _users.add({'email': email, 'password': password});
  }

  bool login(String email, String password) {
    return _users
        .any((user) => user['email'] == email && user['password'] == password);
  }
}
