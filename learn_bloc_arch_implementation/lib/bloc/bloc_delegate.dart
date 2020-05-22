import 'package:meta/meta.dart';
import 'bloc.dart';
import 'transitions.dart';

//?NOTA: mustCallSuper obligará a clases hijas
//y nietas que extiendan de BlocDelegate a
//implementar los métodos y propiedades marcadas
//con dicha notación.

///Clase destinada a gestionar (sobreescribir)
///los eventos [onEvent], [onTransition] y
///[onError] de la clase [Bloc] para añadir
///código personalizado para manejar las
///eventualidades.
class BlocDelegate {
  @mustCallSuper
  void onEvent(Bloc bloc, Object event) => null;

  @mustCallSuper
  void onTransition(Bloc bloc, Transition transition) => null;

  @mustCallSuper
  void onError(Bloc bloc, Object error, StackTrace stackTrace) => null;
}
