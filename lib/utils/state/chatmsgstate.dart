import 'package:fishapp/entities/chat/message.dart';
import 'package:flutter/foundation.dart';

class ChatMessageState extends ChangeNotifier {
  final List<Message> _messages = List();

  void add(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void removeAll() {
    _messages.clear();
    notifyListeners();
  }

  void appendList(List<Message> messagelist) {
    print("state added msgs " + messagelist.length.toString());
    _messages.addAll(messagelist);
    notifyListeners();
  }

  void replaceList(List<Message> messagelist) {
    _messages.clear();
    _messages.addAll(messagelist);
    notifyListeners();
  }

  num getCount() {
    return _messages.length;
  }

  Message getLatest() {
    return _messages.last;
  }

  List<Message> getMessages() {
    print("STATE: has " + _messages.length.toString() + " msgs");
    return _messages;
  }

  Message getSingleMessage(int index) {
    return _messages[index];
  }
}