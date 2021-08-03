import 'package:equatable/equatable.dart';

class TimerEvent extends Equatable {
  const TimerEvent();
  @override
  List<Object?> get props => [];
}

class StartTimer extends TimerEvent {
  final int timeDuaration;
  StartTimer(this.timeDuaration);
}

class RunTimer extends TimerEvent {
  final int timeDuration;
  RunTimer(this.timeDuration);
}

class SetUpTimer extends TimerEvent {
  final int timeDuration;
  SetUpTimer(this.timeDuration);
}

class PauseTimer extends TimerEvent {}

class ResumeTimer extends TimerEvent {}

class RestTimer extends TimerEvent {}
