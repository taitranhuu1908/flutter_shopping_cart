import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/cart/bloc/cart_bloc.dart';
import 'package:shopping_cart/bloc/product/bloc/product_bloc.dart';
import 'package:shopping_cart/services/product_service.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> tabs = <Tab>[
    Tab(
      icon: Icon(Icons.grid_on),
    ),
    Tab(
      icon: Icon(Icons.list),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    gridView(context, listProduct) {
      return GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisCount: 2,
        children: [
          ...listProduct.map((product) {
            return gridItem(context, product);
          })
        ],
      );
    }

    listView(listProduct) {
      return ListView.builder(
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          return listItem(listProduct[index]);
        },
      );
    }

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => ProductBloc(
                    RepositoryProvider.of<ProductService>(context),
                  )..add(FindAllProductEvent())),
        ],
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Store api"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Badge(
                    shape: BadgeShape.circle,
                    badgeColor: Colors.white,
                    badgeContent: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is ListCartState) {
                          return Text("${state.carts.length}");
                        }
                        return const Text("");
                      },
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartScreen()));
                      },
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  ),
                )
              ],
              bottom: TabBar(
                tabs: tabs,
                controller: _tabController,
              ),
            ),
            body: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
              if (state is ListProductLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ListProductState) {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    gridView(context, state.products),
                    listView(state.products),
                  ],
                );
              }

              return Container();
            }),
          ),
        ));
  }

  gridItem(context, product) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            Image.network(
              product.image!,
              width: double.infinity,
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  product.category!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  product.title!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Center(
              child: Text("${product.price!} VND"),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context)
                        .add(AddCartEvent(product));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  child: const Text('Add to Cart'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  listItem(product) {
    return Card(
      child: ListTile(
        leading: Image.network(
          product.image!,
          width: 100,
          height: 100,
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            product.title!,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text("${product.price!} VND"),
        trailing: IconButton(
          onPressed: () {
            // cartProvider.addCart(productProvider.listProduct[index]);
          },
          icon: const Icon(Icons.add_shopping_cart_rounded),
        ),
      ),
    );
  }
}
