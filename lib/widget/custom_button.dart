import 'package:flutter/material.dart';
import 'package:todos_bloc/bloc/timer_bloc/time_bloc.dart';
import 'package:todos_bloc/bloc/timer_bloc/time_event.dart';
import 'package:todos_bloc/bloc/timer_bloc/time_state.dart';

List<Widget> mapStateToActionButtons({required TimerBloc timerBloc}) {
  final TimerState state = timerBloc.state;
  if (state is InitialState) {
    return [
      Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            timerBloc.add(StartTimer(state.timeDuration));
          },
          child: Icon(
            Icons.play_arrow,
            size: 48,
          ),
        ),
      )
    ];
  } else if (state is RunningState) {
    return [
      Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            timerBloc.add(PauseTimer());
          },
          child: Icon(
            Icons.pause,
            size: 48,
          ),
        ),
      ),
      Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            timerBloc.add(RestTimer());
          },
          child: Icon(
            Icons.replay,
            size: 48,
          ),
        ),
      ),
    ];
  } else if (state is PauseState) {
    return [
      Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            timerBloc.add(ResumeTimer());
          },
          child: Icon(
            Icons.play_arrow,
            size: 48,
          ),
        ),
      ),
      Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            timerBloc.add(RestTimer());
          },
          child: Icon(
            Icons.replay,
            size: 48,
          ),
        ),
      ),
    ];
  } else if (state is CompletedState) {
    return [
      Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            timerBloc.add(RestTimer());
          },
          child: Icon(
            Icons.replay,
            size: 48,
          ),
        ),
      )
    ];
  }
  return [];
}
