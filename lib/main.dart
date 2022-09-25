import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/bloc/cart/bloc/cart_bloc.dart';
import 'package:shopping_cart/bloc/user/bloc/user_bloc.dart';
import 'package:shopping_cart/provider/cart_provider.dart';
import 'package:shopping_cart/provider/product_provider.dart';
import 'package:shopping_cart/screens/cart_screen.dart';
import 'package:shopping_cart/screens/home_screen.dart';
import 'package:shopping_cart/screens/login_screen.dart';
import 'package:shopping_cart/services/product_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CartBloc(),
        ),
        BlocProvider(create: (_) => UserBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Store',
        home: const LoginScreen(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) {
                return MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider(create: (context) => ProductService())
                  ],
                  child: const HomeScreen(),
                );
              });
            case '/cart':
              return MaterialPageRoute(builder: (_) {
                return MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider(create: (context) => ProductService()),
                  ],
                  child: const CartScreen(),
                );
              });
            case '/login':
              return MaterialPageRoute(builder: (_) {
                return const LoginScreen();
              });
            default:
              return MaterialPageRoute(builder: (_) => Container());
          }
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
