import 'package:chat/src/models/user.dart';

class Message {
  int _id;
  String _text;
  String _name;
  DateTime _createdAt;
  User _user;

  Message.map(dynamic obj) {
    this._id = obj["id"];
    this._text = obj["text"];
    this._user = new User.map(obj["user"]);
    this._name = obj["name"];
    this._createdAt = DateTime.tryParse(obj["created_at"]);
  }

  int get id => _id;
  String get text => _text;
  String get name => _name;
  DateTime get createdAt => _createdAt;
  User get user => _user;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["text"] = _text;
    map["name"] = _name;
    map["user"] = _user;
    map["created_at"] = _createdAt;

    return map;
  }
}

class ListMessage {
  int _currentPage;
  int _count;
  int _totalPages;
  int _totalCount;
  List<Message> _messages = <Message>[];

  int get currentPage => _currentPage;
  int get count => _count;
  int get totalPages => _totalPages;
  int get totalCount => _totalCount;
  List<Message> get messages => _messages;

  ListMessage.map(dynamic obj) {
    this._currentPage = obj["currentPage"];
    this._count = obj["count"];
    this._totalPages = obj["totalPages"];
    this._totalCount = obj["totalCount"];

    for (final x in obj["messages"]) {
      this._messages.add(new Message.map(x));
    }
  }
}
