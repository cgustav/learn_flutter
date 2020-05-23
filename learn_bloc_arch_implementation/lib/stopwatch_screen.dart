import 'package:flutter/material.dart';
import 'package:learn_bloc_arch_implementation/action_button.dart';
import 'package:learn_bloc_arch_implementation/blocs/stopwatch_bloc.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_provider.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_builder.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_listener.dart';

// class StopwatchScreenWithLocalState extends StatefulWidget {
class StopwatchScreenWithLocalState extends StatelessWidget {
  StopwatchScreenWithLocalState({
    Key key,
  }) : super(key: key);

//   @override
//   _StopwatchScreenWithLocalStateState createState() =>
//       _StopwatchScreenWithLocalStateState();
// }

// class _StopwatchScreenWithLocalStateState
//     extends State<StopwatchScreenWithLocalState> {
//   StopwatchBloc _stopwatchBloc;

//   @override
//   void initState() {
//     super.initState();
//     _stopwatchBloc = StopwatchBloc();
//   }

//   @override
//   void dispose() {
//     _stopwatchBloc.dispose();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // bloc: _stopwatchBloc,
      builder: (context) => StopwatchBloc(),
      child: StopwatchScaffold(title: 'Stopwatch - Local State'),
    );
  }
}

class StopwatchScreenWithGlobalState extends StatelessWidget {
  const StopwatchScreenWithGlobalState({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StopwatchScaffold(title: 'Stopwatch - Global State');
  }
}

class StopwatchScaffold extends StatelessWidget {
  final String title;

  const StopwatchScaffold({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stopwatchBloc = BlocProvider.of<StopwatchBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocListener<StopwatchEvent, StopwatchState>(
          bloc: stopwatchBloc,
          listener: (BuildContext context, StopwatchState state) {
            if (state.isSpecial) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.lightBlueAccent,
                  duration: Duration(seconds: 1),
                  content: Text(
                    '${state.timeFormatted}',
                    style: TextStyle(color: Colors.black87),
                  )));
            }
          },
          child: Center(
            child: BlocBuilder(
                bloc: stopwatchBloc,
                builder: (BuildContext context, StopwatchState state) {
                  return Text(
                    state.timeFormatted,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
          )
          // child: ,
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: BlocBuilder(
              bloc: stopwatchBloc,
              condition:
                  (StopwatchState previousState, StopwatchState currentState) {
                //Retorna true/false para determinar cuando
                //se debe reconstruir o no el widget con el
                //[currentState]
                //En este caso el widget de botones se reconstruirán
                //unicamente cuando:
                //* El bloc mute su estado [initial]
                //* El bloc mute su propiedad [isRunning] del estado
                return (previousState.isInitial != currentState.isInitial ||
                    previousState.isRunning != currentState.isRunning);
              },
              builder: (BuildContext context, StopwatchState state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    (state.isRunning)
                        ? ActionButton(
                            iconData: Icons.stop,
                            onPressed: () {
                              stopwatchBloc.dispatch(StopStopWatch());
                            })
                        : ActionButton(
                            iconData: Icons.play_arrow,
                            onPressed: () {
                              stopwatchBloc.dispatch(StartStopWatch());
                            }),
                    if (!state.isInitial)
                      ActionButton(
                          iconData: Icons.replay,
                          onPressed: () {
                            stopwatchBloc.dispatch(ResetStopWatch());
                          })
                  ],
                );
              }),
        ),
      ),
    );
  }
}
