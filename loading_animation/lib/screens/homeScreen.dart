import 'package:flutter/material.dart';
import 'package:loading_animation/viewModel/loadingViewController.dart';
import 'package:loading_animation/widgets/loadingAnimation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoadingViewController _loadingViewController;

  @override
  void initState() {
    _loadingViewController = LoadingViewController();
    _loadingViewController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "Loading Animation",
          style: TextStyle(
              fontFamily: 'arial',
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 1.4),
        ),
      ),
      body: StreamBuilder(
          stream: _loadingViewController.loadingModelStream,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return doneText();
            }
            return LoadingAnimation();
          }),
    );
  }

  Widget doneText() {
    return Center(
      child: Text(
        "Done",
        style: TextStyle(
            fontFamily: 'Canterbury',
            color: Colors.black,
            fontSize: 40,
            letterSpacing: 1.4),
      ),
    );
  }
}
