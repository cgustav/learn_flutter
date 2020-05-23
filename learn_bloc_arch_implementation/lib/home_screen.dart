import 'package:flutter/material.dart';
import 'package:learn_bloc_arch_implementation/blocs/counter_bloc.dart';
import 'package:learn_bloc_arch_implementation/blocs/stopwatch_bloc.dart';
import 'package:learn_bloc_arch_implementation/counter_screen.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_builder.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_listener.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_listener_tree.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_provider.dart';
import 'package:learn_bloc_arch_implementation/stopwatch_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  void _pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    ///Para acceder al evento actual de [CounterBloc]
    ///a través de [BlocProvider] con [InheritedWidget]
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final stopwatchBloc = BlocProvider.of<StopwatchBloc>(context);

    return BlocListenerTree(
      blocListeners: [
        BlocListener<CounterEvent, int>(
          bloc: counterBloc,
          listener: (BuildContext context, int state) {
            if (state == 10) {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        content: Text('Count: $state'),
                      ));
            }
          },
        ),
        BlocListener<StopwatchEvent, StopwatchState>(
          bloc: stopwatchBloc,
          listener: (BuildContext context, StopwatchState state) {
            if (state.time.inMilliseconds == 10000) if (!Navigator.of(context)
                .canPop())
              _pushScreen(context, StopwatchScreenWithGlobalState());
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('BloC example'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Counter'),
              trailing: Chip(
                label: Text('Local State'),
                backgroundColor: Colors.blue[800],
              ),
              onTap: () => _pushScreen(context, CounterScreenWithLocalState()),
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Counter'),
              subtitle: BlocBuilder(
                  bloc: counterBloc,
                  builder: (BuildContext context, int state) {
                    return Text('$state');
                  }),
              onLongPress: () {
                counterBloc.dispatch(CounterEvent.increment);
              },
              trailing: Chip(
                label: Text('Global State'),
                backgroundColor: Colors.green[800],
              ),
              onTap: () => _pushScreen(context, CounterScreenWithGlobalState()),
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Stopwatch'),
              trailing: Chip(
                label: Text('Local State'),
                backgroundColor: Colors.blue[800],
              ),
              onTap: () =>
                  _pushScreen(context, StopwatchScreenWithLocalState()),
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Stopwatch'),
              subtitle: BlocBuilder(
                  bloc: stopwatchBloc,
                  builder: (BuildContext context, StopwatchState state) {
                    return Text('${state.timeFormatted}');
                  }),
              onLongPress: () {
                (stopwatchBloc.currentState.isRunning)
                    ? stopwatchBloc.dispatch(StopStopWatch())
                    : stopwatchBloc.dispatch(StartStopWatch());
              },
              trailing: Chip(
                label: Text('Global State'),
                backgroundColor: Colors.green[800],
              ),
              onTap: () =>
                  _pushScreen(context, StopwatchScreenWithGlobalState()),
            ),
          ],
        ),
      ),
    );
  }
}
