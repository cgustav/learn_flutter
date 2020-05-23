import 'package:flutter/material.dart';
import 'package:learn_bloc_arch_implementation/blocs/counter_bloc.dart';
import 'package:learn_bloc_arch_implementation/blocs/stopwatch_bloc.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_provider.dart';
import 'home_screen.dart';
import 'package:learn_bloc_arch_implementation/bloc/bloc_supervisor.dart';
import 'package:learn_bloc_arch_implementation/blocs/my_bloc_delegate.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_provider_tree.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();

  // final stopWatchBloc = StopwatchBloc();
  // final counterBloc = CounterBloc();

  //Sin Bloc Provider Tree
  // runApp(BlocProvider<StopwatchBloc>(
  //   bloc: StopwatchBloc(),
  //   child: BlocProvider<CounterBloc>(
  //     bloc: counterBloc,
  //     child: MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       theme: ThemeData.dark(),
  //       home: HomeScreen(),
  //     ),
  //   ),
  // ));

  runApp(BlocProviderTree(
    blocProviders: [
      BlocProvider<StopwatchBloc>(builder: (context) => StopwatchBloc()),
      BlocProvider<CounterBloc>(builder: (context) => CounterBloc()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    ),
  ));
}
