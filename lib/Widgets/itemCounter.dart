import 'package:book_store/logic/cart/item_counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCounter extends StatefulWidget {
  const ItemCounter({super.key});

  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            context.read<ItemCounterCubit>().decrement();
          },
        ),
        BlocBuilder<ItemCounterCubit, int>(
          builder: (context, state) {
            return Text(
              "$state",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            context.read<ItemCounterCubit>().increment();
          },
        ),
      ],
    );
  }
}
