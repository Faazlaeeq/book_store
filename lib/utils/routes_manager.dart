import 'package:book_store/screens/cart_screen.dart';
import 'package:book_store/screens/home_screen.dart';
import 'package:book_store/screens/manage_book_screen.dart';
import 'package:book_store/screens/product_overview_screen.dart';
import 'package:book_store/utils/product_screen_args.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ("/"):
        return MaterialPageRoute(
          builder: (context) => HomeScreen(title: "Reads 2"),
        );
      case ("/manage"):
        return MaterialPageRoute(
          builder: (context) => ManageBookScreen(),
        );
      case ("/productoverview"):
        return MaterialPageRoute(
          builder: (context) => ProductOverviewScreen(
              (settings.arguments as ProductScreenArgs).appBarTitle,
              bookModel: (settings.arguments as ProductScreenArgs).bookModel),
        );
      case ("/cart"):
        return MaterialPageRoute(
          builder: (context) => CartScreen(),
        );

      default:
        return MaterialPageRoute(
            builder: (context) => HomeScreen(title: "Reads"));
    }
  }
}
