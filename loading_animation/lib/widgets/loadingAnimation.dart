import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  Duration _duration;
  AnimationController _controller;
  Animation<double> _scaleIn;
  Animation<double> _scaleOut;
  Animation<double> _fadeIn;
  Animation<double> _fadeOut;

  final double scalingFactor = 0.5;

  @override
  void initState() {
    super.initState();
    _duration = Duration(seconds: 2);
    _controller = AnimationController(duration: _duration, vsync: this)
      ..repeat(reverse: true);

    double fadeTime = 1.0;
    double scaleTime = 1.0;
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, fadeTime, curve: Curves.easeOut)));
    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, fadeTime, curve: Curves.easeIn)));

    _scaleIn = Tween<double>(begin: scalingFactor, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, scaleTime, curve: Curves.easeOut)));
    _scaleOut = Tween<double>(begin: 1.0, end: scalingFactor).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, fadeTime, curve: Curves.easeIn)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return ScaleTransition(
              scale: !(_scaleIn.value == 1.0) ? _scaleIn : _scaleOut,
              //scale: _scaleIn,
              child: Opacity(
                opacity: //_fadeIn.value,
                    !(_fadeIn.value == 1.0) ? _fadeIn.value : _fadeOut.value,
                child: Text(
                  "Loading...",
                  style: TextStyle(
                      fontFamily: 'Canterbury',
                      color: Colors.black,
                      fontSize: 60,
                      letterSpacing: 1.4),
                ),
              ),
            );
          }),
    );
  }
}
