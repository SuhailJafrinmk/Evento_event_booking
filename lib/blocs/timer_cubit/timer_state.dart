part of 'timer_cubit.dart';

@immutable
sealed class TimerState {}

final class TimerInitial extends TimerState {}
class TimerRunning extends TimerState{
  final int timeLeft;
  TimerRunning({required this.timeLeft});
}
class TimeOver extends TimerState{}

