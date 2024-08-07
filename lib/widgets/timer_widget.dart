import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerWidget extends StatefulWidget {
  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {

  Duration _duration = Duration(minutes: 2);

  Timer? _timer;

  int _countdownValue = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration.inSeconds <= 0) {
        _timer?.cancel();
      } else {
        setState(() {
          _countdownValue = _duration.inSeconds;
          _duration = _duration - Duration(seconds: 1);
        });
      }
    });
  }
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Text('${formatDuration(_duration)}');
  }
}
