
class UserInfo {
  String file;
  String _userName;
  String _password;
  String _emailId;
  String _firstName;
  String _lastName;

  UserInfo(this._userName , this._password,this._emailId,this._lastName, this._firstName);

  UserInfo.map(dynamic obj) {
    this._userName = obj['username'];
    this._password = obj['password'];
    this._emailId = obj['emailid'];
    this._firstName = obj['firstname'];
    this._lastName = obj['lastname'];
    this.file = obj['file'];
  }

  String get username => _userName;
  String get password => _password;
  String get firstname => _firstName;
  String get lastname => _lastName;
  String get email => _emailId;
  String get fileMain => file;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['username'] = _userName;
    map['password'] = _password;
    map['file'] = file;
    map['firstname'] = _firstName;
    map['lastname'] = _lastName;
    map['emailid'] = _emailId;

    return map;
  }

  UserInfo.fromMap(Map<String, dynamic> obj) {
    this._userName = obj['username'];
    this._password = obj['password'];
    this._emailId = obj['emailid'];
    this._firstName = obj['firstname'];
    this._lastName = obj['lastname'];
    this.file = obj['file'];
  }
}