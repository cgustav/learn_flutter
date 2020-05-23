// import 'package:learn_bloc_arch_implementation/bloc/bloc.dart';
// import 'package:learn_bloc_arch_implementation/bloc/transitions.dart';

// import 'package:bloc/bloc.dart';
// import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement, reset }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    // // TODO: implement mapEventToState
    // return null;
    if (event == CounterEvent.increment)
      yield state + 1;
    else if (event == CounterEvent.decrement && state > 0)
      yield state - 1;
    else if (event == CounterEvent.reset) yield 0;
  }

  @override
  void onEvent(CounterEvent event) {
    // print('bloc: ${this.runtimeType}, event: $event');
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    // print('bloc: ${this.runtimeType}, transition: $transition');
  }
}
