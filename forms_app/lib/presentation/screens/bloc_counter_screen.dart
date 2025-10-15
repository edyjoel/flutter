import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(child: BlocCounterView(), create: (_) => CounterBloc());
  }
}

class BlocCounterView extends StatelessWidget {
  const BlocCounterView({super.key});

  void increaseCounterBy(BuildContext context, [int value = 1]) {
    context.read<CounterBloc>().add(CounterIncreased(value));
  }

  void resetCounter(BuildContext context) {
    context.read<CounterBloc>().add(CounterReset());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select(
          (CounterBloc bloc) =>
              Text('Bloc Counter: ${bloc.state.transactionCounter}'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              resetCounter(context);
            },
            icon: Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Center(
        child: context.select(
          (CounterBloc bloc) => Text('Counter value: ${bloc.state.counter}'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            child: Text('+3'),
            onPressed: () => {increaseCounterBy(context, 3)},
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: '2',
            child: Text('+2'),
            onPressed: () => {increaseCounterBy(context, 2)},
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: '3',
            child: Text('+1'),
            onPressed: () => {increaseCounterBy(context)},
          ),
        ],
      ),
    );
  }
}
