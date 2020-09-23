class User {
  final String _name;
  final String _password;
  final String _email;
  User(this._name, this._email, this._password);
  String getName() {
    return _name;
  }

  String getEmail() {
    return _email;
  }

  String getPassword() {
    return _password;
  }
}
