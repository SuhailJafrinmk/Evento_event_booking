import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial());
  Timer? timer;
  int _remainingTime = 30;

  void startTimer() {
    debugPrint('--------->timer has started-------------------->');
    emit(TimerRunning(timeLeft: _remainingTime));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 1) {
        _remainingTime--;
        emit(TimerRunning(timeLeft: _remainingTime));
      } else {
        emit(TimeOver());
        cancelTimer(); // Stop the timer when time is over
      }
    });
  }

  void cancelTimer() {
    timer?.cancel();
  }

  @override
  Future<void> close() {
    cancelTimer();
    return super.close();
  }
}
