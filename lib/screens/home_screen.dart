import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
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

    var productProvider = Provider.of<ProductProvider>(context);
    var cartProvider = Provider.of<CartProvider>(context);

    productProvider.getListProduct();
    cartProvider.getCartList();

    var listView = ListView.builder(
      itemCount: productProvider.listProduct.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Image.network(
              productProvider.listProduct[index].image!,
              width: 100,
              height: 100,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                productProvider.listProduct[index].title!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Text("${productProvider.listProduct[index].price!} VND"),
            trailing: IconButton(
              onPressed: () {
                cartProvider.addCart(productProvider.listProduct[index]);
              },
              icon: const Icon(Icons.add_shopping_cart_rounded),
            ),
          ),
        );
      },
    );

    var gridView = GridView.count(
      // padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      childAspectRatio: (itemWidth / itemHeight),
      crossAxisCount: 2,
      children: <Widget>[
        ...productProvider.listProduct.map(
          (product) {
            return Container(
              child: Card(
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
                              cartProvider.addCart(product);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            child: const Text('Add to Cart'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Store Api"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Badge(
                shape: BadgeShape.circle,
                badgeColor: Colors.white,
                badgeContent: Text(cartProvider.cart.length.toString()),
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
        body: productProvider == null
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: _tabController,
                children: [
                  gridView,
                  listView,
                ],
              ),
      ),
    );
  }
}
