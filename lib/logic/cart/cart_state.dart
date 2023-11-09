import 'package:book_store/models/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  final List<CartItem> items;

  CartState() : items = [];

  Map<String, dynamic> tojson() {
    return {'cartItems': items};
  }

  CartState fromjson(Map<String, dynamic> json) {
    return json['cartItems'];
  }

  @override
  List<Object> get props => [items];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {}
