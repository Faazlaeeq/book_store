import 'package:book_store/logic/cart/cart_cubit.dart';
import 'package:book_store/models/cart_item.dart';
import 'package:book_store/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

PreferredSizeWidget myAppBar(title, BuildContext context) {
  return AppBar(
    title: Text(title),
    actions: [
      Stack(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.cart);
              },
              icon: const Icon(Icons.shopping_cart)),
          BlocBuilder<CartCubit, List<CartItem>>(builder: (context, state) {
            return Positioned(
                top: 5,
                right: 10,
                child: Badge(
                  backgroundColor: Colors.red,
                  isLabelVisible: true,
                  label: Text(state.length.toString()),
                ));
          })
        ],
      )
    ],
  );
}
