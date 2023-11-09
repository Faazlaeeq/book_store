import 'package:book_store/Database/firebase_service.dart';
import 'package:book_store/logic/cart/cart_cubit.dart';
import 'package:book_store/logic/cart/item_counter_cubit.dart';
import 'package:book_store/logic/manage/manage_cubit.dart';
import 'package:book_store/logic/theme/theme_cubit.dart';
import 'package:book_store/utils/routes.dart';
import 'package:book_store/utils/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  final appDirectory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: appDirectory);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ManageCubit()),
        BlocProvider(create: (context) => ItemCounterCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Reads',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              textTheme: TextTheme(
                labelSmall: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gilroy"),
                labelMedium: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gilroy"),
                labelLarge: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Gilroy"),
                displaySmall: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gilroy"),
                displayMedium: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Gilroy"),
                displayLarge: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gilroy"),
                titleMedium: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gilroy"),
                bodySmall: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "ABeeZee",
                ),
                bodyMedium: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "ABeeZee",
                ),
                bodyLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "ABeeZee",
                ),
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              useMaterial3: true,
              primaryColor: Colors.black12,
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                secondary: Colors.deepPurpleAccent,
                background: Colors.green,
              ),
              textTheme: TextTheme(
                labelSmall: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gilroy"),
                labelMedium: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gilroy"),
                labelLarge: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Gilroy"),
                displaySmall: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gilroy"),
                displayMedium: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Gilroy"),
                displayLarge: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gilroy"),
                titleMedium: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gilroy"),
                bodySmall: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "ABeeZee",
                ),
                bodyMedium: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "ABeeZee",
                ),
                bodyLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "ABeeZee",
                ),
              ),
            ),
            themeMode: state ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: (settings) =>
                RoutesManager().generateRoute(settings),
            initialRoute: Routes.homepage,
          );
        },
      ),
    );
  }
}
