import 'package:book_store/Widgets/itemCounter.dart';
import 'package:book_store/Widgets/my_appbar.dart';
import 'package:book_store/logic/cart/cart_cubit.dart';
import 'package:book_store/logic/cart/item_counter_cubit.dart';
import 'package:book_store/models/book_model.dart';
import 'package:book_store/models/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductOverviewScreen extends StatelessWidget {
  final String title;
  final BookModel bookModel;

  const ProductOverviewScreen(this.title, {required this.bookModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(title, context),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          image: CachedNetworkImageProvider(bookModel.imgUrl),
                          placeholder:
                              const AssetImage("assets/gif/loading.gif"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              child: Text(bookModel.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                            ),
                            Spacer(),
                            Text(
                              "\$${bookModel.price}",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Description",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          bookModel.desc,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Row(
              children: [
                Expanded(child: ItemCounter()),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 3))
                      ]),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  margin: const EdgeInsets.all(10),
                  child: TextButton(
                      child: Text("Add to Cart",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                      onPressed: () {
                        CartItem item = CartItem(
                          id: DateTime.now().toString(),
                          book: bookModel,
                          quantity: context.read<ItemCounterCubit>().state,
                        );
                        context.read<CartCubit>().addItem(item);
                      }),
                ),
              ],
            )
          ],
        ));
  }
}
