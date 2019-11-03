import 'dart:async';

class LoadingViewController {
  Duration interval = Duration(seconds: 1);
  Stream<int> stream;

  Stream<int> get loadingModelStream => stream;

  Future init() async {
    stream = Stream<int>.periodic(interval, transform);
    stream = stream.take(59);
  }

  int transform(int value) {
    return value;
  }
}
