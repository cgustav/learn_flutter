import 'package:flutter/widgets.dart';
import 'package:learn_bloc_arch_implementation/bloc/bloc.dart';

class BlocProvider<T extends Bloc<dynamic, dynamic>> extends InheritedWidget {
  final T bloc;
  final Widget child;

  BlocProvider({
    Key key,
    @required this.bloc,
    this.child,
  })  : assert(bloc != null),
        super(key: key, child: child);

  static T of<T extends Bloc<dynamic, dynamic>>(BuildContext context) {
    // final type = _typeof<BlocProvider<T>>();
    final BlocProvider<T> provider = context
        .getElementForInheritedWidgetOfExactType<BlocProvider<T>>()
        ?.widget as BlocProvider<T>;

    if (provider == null)
      throw FlutterError(
          'BlocProvider.of() called with a context that does not contain a Bloc of type $T.');
    else
      return provider?.bloc;
  }

  ///Retorna una copia del bloc provider cambiando el child
  BlocProvider<T> copyWith(Widget child) => BlocProvider<T>(
        key: key,
        bloc: bloc,
        child: child,
      );

  //?No notificará a los widgets herederos
  //de [Bloc Provider] sobre posibles cambios
  //de este widget.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  // static Type _typeof<T>() => T;
}
