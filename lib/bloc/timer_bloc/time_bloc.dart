import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/bloc/timer_bloc/time_event.dart';
import 'package:todos_bloc/bloc/timer_bloc/time_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static int _timeDuration = 60;
  TimerBloc() : super(InitialState(_timeDuration));

  StreamSubscription<int>? _timeSubscription;
  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is StartTimer) {
      yield RunningState(event.timeDuaration);
      _timeSubscription?.cancel();
      _timeSubscription =
          changeTimer(event.timeDuaration).listen((timeDuration) {
        return add(RunTimer(timeDuration));
      });
    } else if (event is RunTimer) {
      yield event.timeDuration > 0
          ? RunningState(event.timeDuration)
          : CompletedState();
    } else if (event is PauseTimer) {
      _timeSubscription?.pause();
      yield PauseState(state.timeDuration);
    } else if (event is ResumeTimer) {
      _timeSubscription?.resume();
      yield RunningState(state.timeDuration);
    } else if (event is RestTimer) {
      _timeSubscription?.cancel();
      yield InitialState(_timeDuration);
    } else if (event is SetUpTimer) {
      _timeSubscription?.cancel();
      yield InitialState(event.timeDuration);
    }
  }
}

Stream<int> changeTimer(int time) {
  return Stream.periodic(Duration(seconds: 1), (value) => time - value - 1)
      .take(time);
}
