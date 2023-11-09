import 'package:book_store/Database/firebase_service.dart';
import 'package:book_store/Widgets/app_drawer.dart';
import 'package:book_store/Widgets/my_appbar.dart';
import 'package:book_store/models/book_model.dart';
import 'package:book_store/utils/product_screen_args.dart';
import 'package:book_store/utils/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String title;
  const HomeScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: myAppBar(title, context),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: FireStoreService("books").retriveData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> row =
                      data[index].data() as Map<String, dynamic>;
                  String name = row["name"].toString();
                  String author = row["author"].toString();
                  String imgUrl = row["imgUrl"].toString();
                  String price = row["price"].toString();

                  BookModel book = BookModel(
                      author: author,
                      desc: row["desc"],
                      imgUrl: imgUrl,
                      name: name,
                      price: row["price"].toString());
                  debugPrint("$row");

                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.productOverview,
                          arguments: ProductScreenArgs(
                              appBarTitle: name, bookModel: book));
                    },
                    child: Card(
                        child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: FadeInImage(
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(imgUrl),
                          placeholder:
                              const AssetImage("assets/gif/loading.gif"),
                        ),
                      ),
                      title: Text(name.trim(),
                          style: Theme.of(context).textTheme.displaySmall),
                      subtitle: Text(
                        "Written by: $author",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: Text("\$$price"),
                    )),
                  );
                });
          }
          return const Center(child: Text("No Book uploaded yet!"));
        },
      ),
    ));
  }
}
