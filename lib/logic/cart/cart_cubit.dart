import 'package:book_store/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'cart_cubit_state.dart';

class CartCubit extends HydratedCubit<List<CartItem>> {
  CartCubit() : super([]);

  void addItem(CartItem val) {
    state.add(val);
    emit(state);
  }

  void removeItem(String id) {
    state.removeWhere((element) => element.id == id);
    emit(state);
  }

  @override
  List<CartItem> fromJson(Map<String, dynamic> json) {
    debugPrint("CartCubit.fromjson: $json");

    return json['cartItems'] as List<CartItem>;
  }

  @override
  Map<String, List<CartItem>> toJson(List<CartItem> state) {
    debugPrint("CartCubit.toJson: $state");
    return {
      'cartItems': state,
    };
  }
}
