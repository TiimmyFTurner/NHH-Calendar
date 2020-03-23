import 'package:flutter/material.dart';

class Events with ChangeNotifier {
  Map<DateTime, List> _events = {};

  //Map<int, Map> _serverEvents = {};

  Map<DateTime, List> get events {
    getEvents();
    return _events;
  }

  void getEvents() {
    _events.clear();
    for (var i = 0; i < 2; i++) {
      _events[DateTime(2020, 3, 4)] == null
          ? _events[DateTime(2020, 3, 4)] = [
              {'id': 19, 'name': 'Happy Birhtday KanYe West'}
            ]
          : _events[DateTime(2020, 3, 4)]
              .add({'id': 19, 'name': 'Happy Birhtday Nicki Minaj'});
    }
  }
}
