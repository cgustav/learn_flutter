import 'package:flutter/material.dart';
import 'package:learn_bloc_arch_implementation/blocs/counter_bloc.dart';
import 'action_button.dart';
// import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_builder.dart';
// import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Pantalla construida a partir de un
///statelessWidget que contiene el estado
///global del BloC [CounterBloc] haciendo uso
///de [Bloc Provider] con [InheritedWidget]
///implementado en el árbol de widget.
///Las ventajas de esta implementación son:
///* Los eventos y estados del Bloc [CounterBloc] son
///accesibles globalmente.
///* Los eventos del Bloc se mantienen persistentes en
///memoria aún cuando el widget [CounterScreenWithGlobalState]
///es destruido o reconstruido
class CounterScreenWithGlobalState extends StatelessWidget {
  const CounterScreenWithGlobalState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterScaffold(
      title: 'Counter - Global State',
    );
  }
}

///Pantalla construida a partir de un
///statefulWidget que contiene el estado
///local del BloC [CounterBloc] haciendo uso
///de [Bloc Provider] sin la clase [InheritedWidget].
///
///Las desventajas de esta implementación son:
///* Los unicos widgets que podrán acceder al mismo
///estado de [CounterBloc] serán quienes hereden
///directamente a partir de este widget, o compartan
///su BuioldContext.
///* El estado de esta instancia de [BlocProvider] de
///Bloc [CounterBloc] ya no es accesible globalmente.
///* Al destruir el Widget (es decir cuando se invoca
///el metodo dispose) el estado de [CounterBloc] también
///se destruirá
///
///La ventaja principal es:
///* El estado de [CounterBloc] hace uso en memoria
///únicamente cuando se está accediendo a los Eventos
///del Bloc en cuestión. Optimizando en cierta medida
///el rendimiento.
///* Altamente recomendado para widgets que no necesiten
///gestionar data sensible o que deba ser persistente
///en la sesión de usuario.
class CounterScreenWithLocalState extends StatelessWidget {
  CounterScreenWithLocalState({Key key}) : super(key: key);

//   @override
//   _CounterScreenWithLocalStateState createState() =>
//       _CounterScreenWithLocalStateState();
// }

// class _CounterScreenWithLocalStateState
//     extends State<CounterScreenWithLocalState> {
  // CounterBloc _counterBloc;

  // @override
  // void initState() {
  //   super.initState();
  //   _counterBloc = CounterBloc();
  // }

  // @override
  // void dispose() {
  //   _counterBloc.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      // bloc: _counterBloc,
      // builder: (context) => CounterBloc(),
      create: (context) => CounterBloc(),
      child: CounterScaffold(
        title: 'Counter - Local State',
      ),
    );
  }
}

class CounterScaffold extends StatelessWidget {
  final String title;
  const CounterScaffold({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _counterBloc,
          builder: (BuildContext context, int state) {
            return Text(
              '$state',
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ActionButton(
              iconData: Icons.add,
              onPressed: () {
                // _counterBloc.dispatch(CounterEvent.increment);
                _counterBloc.add(CounterEvent.increment);
              },
            ),
            ActionButton(
              iconData: Icons.remove,
              onPressed: () {
                // _counterBloc.dispatch(CounterEvent.decrement);
                _counterBloc.add(CounterEvent.decrement);
              },
            ),
            ActionButton(
              iconData: Icons.replay,
              onPressed: () {
                // _counterBloc.dispatch(CounterEvent.reset);
                _counterBloc.add(CounterEvent.reset);
              },
            ),
          ],
        ),
      ),
    );
  }
}
