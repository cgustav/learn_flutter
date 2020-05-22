import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

///Clase para manejar las transiciones de estados para
///la implementación [BLOC], extiende a Equatable
///para permitir la comparación entre objetos,
///evitando el uso de HashCode
class Transition<Event, State> extends Equatable {
  final State currentState;
  final Event event;
  final State nextState;

  Transition({
    @required this.currentState,
    @required this.event,
    @required this.nextState,
  })  : assert(currentState != null),
        assert(event != null),
        assert(nextState != null);

  @override
  String toString() => 'Transition { currentState: $currentState, '
      'event: $event, nextState: $nextState }';

  //Implementación requerida por [Equatable]
  @override
  List<Object> get props => [currentState, event, nextState];

  //Implementación recomedada por [Equatable]
  @override
  bool get stringify => false;
}
