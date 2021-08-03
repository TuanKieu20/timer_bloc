import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final int timeDuration;
  TimerState(this.timeDuration);
  @override
  List<Object?> get props => [timeDuration];
}

class InitialState extends TimerState {
  final int timeDuration;
  InitialState(this.timeDuration) : super(timeDuration);
}

class RunningState extends TimerState {
  final int timeDuration;
  RunningState(this.timeDuration) : super(timeDuration);
}

class PauseState extends TimerState {
  final int timeDuration;
  PauseState(this.timeDuration) : super(timeDuration);
}

class CompletedState extends TimerState {
  CompletedState() : super(0);
}
