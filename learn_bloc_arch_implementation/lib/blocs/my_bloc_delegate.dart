import 'package:learn_bloc_arch_implementation/bloc/bloc_delegate.dart';
import 'package:learn_bloc_arch_implementation/bloc/transitions.dart';
import 'package:learn_bloc_arch_implementation/bloc/bloc.dart';

///Bloc Delegate personalizado
class MyBlocDelegate extends BlocDelegate {
  //  onEvent
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('bloc: ${bloc.runtimeType}, error: $error, stackTrace: $stackTrace');
  }
}
