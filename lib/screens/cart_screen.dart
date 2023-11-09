import 'package:book_store/Widgets/my_appbar.dart';
import 'package:book_store/logic/cart/cart_cubit.dart';
import 'package:book_store/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar("Cart", context),
        body: BlocBuilder<CartCubit, List<CartItem>>(
          builder: (context, state) {
            return state.isEmpty
                ? Center(child: Text("Cart is empty"))
                : ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      return state.isEmpty
                          ? Center(
                              child: Text("Cart is empty"),
                            )
                          : Card(
                              child: ListTile(
                                leading:
                                    Image.network(state[index].book.imgUrl),
                                title: Text(state[index].book.name),
                                subtitle: Text(state[index].book.author),
                                trailing: Text("\$${state[index].price}"),
                              ),
                            );
                    },
                  );
          },
        ));
  }
}
