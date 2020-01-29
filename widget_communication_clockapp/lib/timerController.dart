import 'dart:async';

class TimerController {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  final StreamController<DateTime> _timerController =
      StreamController<DateTime>.broadcast();

  Stream<DateTime> get dateTimeStream => _timerController.stream;

  Future init() async {
    _updateTime();
  }

  void _updateTime() {
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) {
      _dateTime = DateTime.now();
      //print(_dateTime);
      _timerController.sink.add(_dateTime);
    });
  }

  close() {
    _timer?.cancel();
    _timerController?.close();
  }
}
