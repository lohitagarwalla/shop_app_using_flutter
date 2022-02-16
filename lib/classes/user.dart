class User {
  static String name = '';
  static String email = '';
  static String pass = '';

  User({name, email, pass});

  String getname() {
    return name;
  }

  String getemail() {
    return email;
  }

  String getPass() {
    return pass;
  }

  factory User.fromJson(Map<String, String> json) {
    return User(
        name: json['name'], email: json['email'] as String, pass: json['pass']);
  }
}
