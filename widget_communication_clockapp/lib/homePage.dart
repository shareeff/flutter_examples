import 'package:flutter/material.dart';
import 'package:widget_communication_clockapp/timerController.dart';
import 'package:widget_communication_clockapp/widgetShape.dart';
import 'package:widget_communication_clockapp/showTime.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimerController _timerController;

  @override
  void initState() {
    _timerController = TimerController();
    _timerController.init();
  }

  @override
  void dispose() {
    _timerController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            "Clock App",
            style: TextStyle(
                fontFamily: 'arial',
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 1.4),
          )),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Widget Communication Example",
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: () => _buildModalBottomSheet(
                      context, _timerController.dateTimeStream),
                  child: Center(
                    child: Text("Show Clock",
                        style: TextStyle(
                            fontFamily: 'arial',
                            color: Colors.black,
                            fontSize: 18,
                            letterSpacing: 1.4)),
                  ),
                  color: Colors.lightGreen[800],
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  splashColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _buildModalBottomSheet(BuildContext context, Stream stream) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return ShowTime(
          stream: stream,
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: buildBorderRadius(),
      ),
    );
  }
}
