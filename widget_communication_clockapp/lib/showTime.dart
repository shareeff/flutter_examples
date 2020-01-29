import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widget_communication_clockapp/widgetShape.dart';

class ShowTime extends StatefulWidget {
  final Stream stream;
  const ShowTime({@required this.stream, Key key})
      : assert(stream != null),
        super(key: key);

  @override
  _ShowTimeState createState() => _ShowTimeState();
}

class _ShowTimeState extends State<ShowTime> {
  StreamSubscription streamSubscription;
  var _dateTime = ValueNotifier<DateTime>(DateTime.now());

  final _textStyle = TextStyle(
      fontFamily: "Canterbury",
      color: Colors.green,
      fontWeight: FontWeight.bold,
      fontSize: 40,
      letterSpacing: 1.4);

  @override
  void initState() {
    super.initState();
    streamSubscription = widget.stream.listen((onData) {
      //print(onData);
      _dateTime.value = onData;
    });
  }

  @override
  void didUpdateWidget(ShowTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stream != oldWidget.stream) {
      streamSubscription.cancel();
      streamSubscription = widget.stream.listen((onData) {
        _dateTime = ValueNotifier<DateTime>(onData);
      });
    }
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height * 0.2;
    return Material(
      color: Colors.amber[400],
      elevation: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: buildBorderRadius(),
      ),
      child: Center(
        child: Container(
          height: screenHeight,
          padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
          child: ValueListenableBuilder<DateTime>(
              valueListenable: _dateTime,
              builder: (context, value, child) {
                final hour = DateFormat('hh').format(value);
                final minute = DateFormat('mm').format(value);
                final second = DateFormat('ss').format(value);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      hour,
                      style: _textStyle,
                    ),
                    Text(":", style: _textStyle),
                    Text(minute, style: _textStyle),
                    Text(":", style: _textStyle),
                    Text(second, style: _textStyle)
                  ],
                );
              }),
        ),
      ),
    );
  }
}
