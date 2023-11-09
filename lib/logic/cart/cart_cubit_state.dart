import 'package:book_store/models/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class CartCubitState extends Equatable {
  final int? itemsCount;
  final List<CartItem> items;
  final double? totalPrice;

  const CartCubitState({
    required this.itemsCount,
    required this.items,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [itemsCount, items, totalPrice];
}

class CartCubitInitState extends CartCubitState {
  CartCubitInitState(
      {required super.itemsCount,
      required super.items,
      required super.totalPrice});
}

class CartCubitUpdatedState extends CartCubitState {
  CartCubitUpdatedState(
      {required super.itemsCount,
      required super.items,
      required super.totalPrice});
}
