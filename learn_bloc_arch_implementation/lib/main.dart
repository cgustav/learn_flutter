import 'package:flutter/material.dart';
import 'package:learn_bloc_arch_implementation/counter_bloc.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_provider.dart';
import 'home_screen.dart';
import 'package:learn_bloc_arch_implementation/bloc/bloc_supervisor.dart';
import 'package:learn_bloc_arch_implementation/blocs/my_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();
  final counterBloc = CounterBloc();

  runApp(BlocProvider(
    bloc: counterBloc,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    ),
  ));
}
