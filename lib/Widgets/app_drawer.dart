import 'package:book_store/logic/theme/theme_cubit.dart';
import 'package:book_store/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget AppDrawer() {
  const tiles = [
    {"name": "Home", "url": Routes.homepage},
    {"name": "Manage", "url": Routes.manage},
  ];
  return Drawer(
    child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: tiles.length + 1,
            itemBuilder: (context, index) {
              int ind = index - 1;
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Menu",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ),
                );
              }

              return InkWell(
                child: ListTile(
                  title: Text(tiles[ind]["name"]!),
                ),
                onTap: () => Navigator.pushNamed(context, tiles[ind]["url"]!),
              );
            }),
        Divider(),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<ThemeCubit, bool>(
              builder: (context, state) {
                return ListTile(
                  title: Text("Dark Mode"),
                  trailing: Switch(
                      value: state,
                      onChanged: (value) =>
                          context.read<ThemeCubit>().toggleTheme()),
                );
              },
            )),
      ],
    ),
  );
}
