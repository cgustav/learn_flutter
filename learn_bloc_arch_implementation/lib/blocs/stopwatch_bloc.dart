import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:learn_bloc_arch_implementation/bloc/bloc.dart';

/// Eventos
/// ---
/// En este caso, a diferencia de [CounterBloc]
/// [StopWatchBloc] no solo consta de eventos
/// del tipo enum, ya que consta de lógica compleja
/// como en el caso del evento [update] necesita
/// input de datos.
/// Al ser un Bloc más complejo, necesitaremos
/// implementar la librería [Equatable]
///
// // enum StopWatchEvent { start, stop, reset, update }
abstract class StopwatchEvent extends Equatable {
  StopwatchEvent([List props = const []]);

  @override
  List<Object> get props => props;
}

class StartStopWatch extends StopwatchEvent {
  @override
  String toString() => 'StartStopwatch';
}

class StopStopWatch extends StopwatchEvent {
  @override
  String toString() => 'StopStopwatch';
}

class ResetStopWatch extends StopwatchEvent {
  @override
  String toString() => 'ResetStopWatch';
}

class UpdateStopWatch extends StopwatchEvent {
  final Duration time;

  UpdateStopWatch(this.time) : super([time]);

  @override
  String toString() =>
      'UpdateStopwatch {timeInMilliseconds: ${time.inMilliseconds}}';
}

///Estados
///---
///

class StopwatchState extends Equatable {
  final Duration time;
  final bool isInitial;
  final bool isRunning;
  final bool isSpecial;

  StopwatchState({
    @required this.time,
    @required this.isInitial,
    @required this.isRunning,
    @required this.isSpecial,
  });

  factory StopwatchState.initial() {
    return StopwatchState(
      time: Duration(milliseconds: 0),
      isInitial: true,
      isRunning: false,
      isSpecial: false,
    );
  }

  int get minutes => time.inMinutes.remainder(60);
  int get seconds => time.inSeconds.remainder(60);
  int get hundredths => (time.inMilliseconds / 10).floor().remainder(100);

  String get timeFormatted {
    String toTwoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    return '${toTwoDigits(minutes)}:${toTwoDigits(seconds)}.${toTwoDigits(hundredths)}';
  }

  StopwatchState copyWith({
    Duration time,
    bool isInitial,
    bool isRunning,
    bool isSpecial,
  }) {
    return StopwatchState(
      time: time ?? this.time,
      isInitial: isInitial ?? this.isInitial,
      isRunning: isRunning ?? this.isRunning,
      isSpecial: isSpecial ?? this.isSpecial,
    );
  }

  @override
  List<Object> get props => [time, isInitial, isRunning, isSpecial];

  @override
  String toString() =>
      'StopwatchState { timeFormated: $timeFormatted, isInitial: $isInitial, isRunning: $isRunning, isSpecial: $isSpecial }';
}

///BLOC
///---
///

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  int _elapsedTimeInMilliseconds = 0;
  StreamSubscription _streamPeriodSubscription;

  @override
  void dispose() {
    _streamPeriodSubscription?.cancel();
    _streamPeriodSubscription = null;

    super.dispose();
  }

  @override
  StopwatchState get initialState => StopwatchState.initial();

  @override
  Stream<StopwatchState> mapEventToState(StopwatchEvent event) async* {
    //Start StopWatch Event
    //->Update StopWatch every 10 milliseconds State
    if (event is StartStopWatch) {
      if (_streamPeriodSubscription == null)
        _streamPeriodSubscription =
            Stream.periodic(Duration(milliseconds: 10)).listen((_) {
          _elapsedTimeInMilliseconds += 10;
          dispatch(UpdateStopWatch(
              Duration(milliseconds: _elapsedTimeInMilliseconds)));
        });
    }
    //Update Stopwatch Event
    else if (event is UpdateStopWatch) {
      final bool isSpecial = event.time.inMilliseconds % 3000 == 0;

      yield StopwatchState(
        time: event.time,
        isInitial: false,
        isRunning: true,
        isSpecial: isSpecial,
      );
      //Stop Stopwatch Event
      // -> Copy of Stopwatch State with [isRunning] false
    } else if (event is StopStopWatch) {
      _streamPeriodSubscription.cancel();
      _streamPeriodSubscription = null;

      yield currentState.copyWith(isRunning: false);
    }
    //Reset Stopwatch Event
    // -> Stopwatch with [initial] State
    else if (event is ResetStopWatch) {
      _elapsedTimeInMilliseconds = 0;
      if (!currentState.isRunning) yield StopwatchState.initial();
    }
  }
}
