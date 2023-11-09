import 'package:book_store/models/book_model.dart';

class CartItem {
  final String id;
  final BookModel book;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.book,
    required this.quantity,
  }) : price = double.parse(book.price) * quantity;

  CartItem copyWith({
    String? id,
    BookModel? book,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      book: book ?? this.book,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book': book.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      book: BookModel.fromJson(json['book']),
      quantity: json['quantity'],
    );
  }
}
