import 'package:flutter/widgets.dart';
import 'package:learn_bloc_arch_implementation/bloc/bloc.dart';

typedef BlocProviderBuilder<T extends Bloc<dynamic, dynamic>> = T Function(
    BuildContext context);

class BlocProvider<T extends Bloc<dynamic, dynamic>> extends StatefulWidget {
  // final T bloc;
  final Widget child;
  final bool dispose;
  final BlocProviderBuilder<T> builder;
  BlocProvider({
    Key key,
    @required this.builder,
    this.child,
    this.dispose = true,
  })  : assert(builder != null),
        super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends Bloc<dynamic, dynamic>>(BuildContext context) {
    // final type = _typeof<_InheritedBlocProvider<T>>();
    final _InheritedBlocProvider<T> provider = context
        .getElementForInheritedWidgetOfExactType<_InheritedBlocProvider<T>>()
        ?.widget as _InheritedBlocProvider<T>;

    if (provider == null)
      throw FlutterError(
          'BlocProvider.of() called with a context that does not contain a Bloc of type $T.');
    else
      return provider?.bloc;
  }

  BlocProvider<T> copyWith(Widget child) => BlocProvider<T>(
        key: key,
        // dispose: dispose,
        builder: builder,
        child: child,
      );
}

class _BlocProviderState<T extends Bloc<dynamic, dynamic>>
    extends State<BlocProvider<T>> {
  T _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = widget.builder(context);
    if (_bloc == null)
      throw FlutterError('BlocProvider builder method did not return a Bloc');
  }

  @override
  void dispose() {
    if (widget.dispose ?? true) {
      _bloc.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedBlocProvider(
      // child: child,
      bloc: _bloc,
      child: widget.child,
    );
  }
}

class _InheritedBlocProvider<T extends Bloc<dynamic, dynamic>>
    extends InheritedWidget {
  final T bloc;
  final Widget child;

  _InheritedBlocProvider({
    Key key,
    @required this.bloc,
    this.child,
  })  : assert(bloc != null),
        super(key: key, child: child);

  ///Retorna una copia del bloc provider cambiando el child
  // _InheritedBlocProvider<T> copyWith(Widget child) => _InheritedBlocProvider<T>(
  //       key: key,
  //       bloc: bloc,
  //       child: child,
  //     );

  //?No notificará a los widgets herederos
  //de [Bloc Provider] sobre posibles cambios
  //de este widget.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  // static Type _typeof<T>() => T;
}
