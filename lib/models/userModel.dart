class UserModel {
  late String _email;
  late String _password;
  late String _uid;

  UserModel(email, password, [uid = '']) {
    _email = email;
    _password = password;
    _uid = uid;
  }

  set setUid(value) {
    _uid = value;
  }

  get getEmail {
    return _email;
  }

  get getUid {
    return _uid;
  }

  bool isConnected() {
    return _uid != "";
  }
}
