import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:learn_bloc_arch_implementation/bloc/bloc.dart';

typedef BlocWidgetListener<S> = void Function(BuildContext context, S state);

class BlocListener<E, S> extends StatefulWidget {
  final Bloc<E, S> bloc;
  final BlocWidgetListener<S> listener;
  final Widget child;

  BlocListener({
    Key key,
    this.bloc,
    this.listener,
    this.child,
  })  : assert(bloc != null),
        assert(listener != null),
        super(key: key);

  BlocListener<E, S> copyWith(Widget child) {
    return BlocListener<E, S>(
      key: key,
      bloc: bloc,
      listener: listener,
      child: child,
    );
  }

  // BlocListener<E,S> copyWith({Bloc<E,S> bloc, BlocWidgetListener listener, Widget child,})=>{}

  @override
  _BlocListenerState<E, S> createState() => _BlocListenerState<E, S>();
}

class _BlocListenerState<E, S> extends State<BlocListener<E, S>> {
  StreamSubscription<S> _subscription;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  void didUpdateWidget(BlocListener<E, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bloc.state != widget.bloc.state) {
      if (_subscription != null) _unsubscribe();
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  ///Escucha el listener de entrada del bloc objetivo
  ///y emite eventos correspondientes a los widgets
  ///implementados con [BlocListener].
  ///
  ///Por defecto evita escuchar el primer elemento
  ///de entrada.
  void _subscribe() {
    if (widget.bloc.state != null)
      _subscription = widget.bloc.state.skip(1).listen((S state) {
        widget.listener.call(context, state);
      });
  }

  ///Cierra el listener asociado y
  ///la variable subscription
  void _unsubscribe() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }
}
