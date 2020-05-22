import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'transitions.dart';
import 'bloc_supervisor.dart';

abstract class Bloc<Event, State> {
  final PublishSubject<Event> _eventSubject = PublishSubject<Event>();
  BehaviorSubject<State> _stateSubject;

  State get initialState;

  State get currentState => _stateSubject.value;

  Stream<State> get state => _stateSubject.stream;

  Bloc() {
    _stateSubject = BehaviorSubject<State>.seeded(initialState);
    _bindStateSubject();
  }

  @mustCallSuper
  void dispose() {
    _eventSubject.close();
    _stateSubject.close();
  }

  void dispatch(Event event) {
    try {
      //Implementación Singleton Bloc Supervisor
      BlocSupervisor.delegate.onEvent(this, event);
      onEvent(event);
      _eventSubject.sink.add(event);
    } catch (error) {
      _handleError(error);
    }
  }

  Stream<State> mapEventToState(Event event);

  Stream<State> transform(
    Stream<Event> events,
    Stream<State> next(Event event),
  ) {
    return events.asyncExpand(next);
  }

  void _bindStateSubject() {
    Event currentEvent;

    transform(_eventSubject, (Event event) {
      currentEvent = event;
      return mapEventToState(currentEvent).handleError(_handleError);
    }).forEach((State nextState) {
      if (currentState == nextState || _stateSubject.isClosed) return;

      ///Se registra una transición de eventos
      final transition = Transition(
          currentState: currentState,
          event: currentEvent,
          nextState: nextState);

      ///Implementación Singleton [BlocDelegate] para el
      ///evento [onTransition]
      BlocSupervisor.delegate.onTransition(this, transition);

      onTransition(transition);

      _stateSubject.sink.add(nextState);
    });
  }

  ///Implementa evento [onError] y [BlocDelegate.onError]
  ///para cualquier eventualidad de error dentro de la
  ///clase [BLOC]
  void _handleError(Object error, [StackTrace stackTrace]) {
    ///Implementación Singleton [BlocDelegate] para el
    ///evento [onError]
    BlocSupervisor.delegate.onError(this, error, stackTrace);

    onError(error, stackTrace);
  }

  //Eventos (Handlers)

  ///Evento disparado cuando existe un cambio
  ///de estado. Destinado principalmente para habilitar
  ///a clases que extiendan de BLOC en operaciones de
  ///control o registro de las transiciones de estados
  ///para procesos de logs o analytics personalizados.
  void onTransition(Transition<Event, State> transition) => null;

  ///Evento disparado cuando existe un error en algún
  ///momento del flujo de eventos o estados de la clase
  ///[BLOC]
  void onError(Object error, StackTrace stackTrace) => null;

  ///Evento disparado cuando existe un nuevo evento de
  ///salida disponible
  void onEvent(Event event) => null;
}
