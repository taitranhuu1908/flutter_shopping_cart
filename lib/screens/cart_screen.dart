import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/bloc/cart/bloc/cart_bloc.dart';
import 'package:shopping_cart/model/product.dart';
import 'package:shopping_cart/provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Shopping Carts'),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is ListCartState) {
              return Container(
                child: Text("${state.carts.length}"),
              );
            }
            return Container();
          },
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: const Text('Shopping Carts'),
    //   ),
    //   body: Column(
    //     children: [
    //       cart.getCartList().isEmpty
    //           ? const Expanded(
    //               child: Center(
    //               child: Text('Cart is empty'),
    //             ))
    //           : Expanded(
    //               child: ListView.builder(
    //                 itemCount: cart.getCartList().length,
    //                 itemBuilder: (context, index) {
    //                   return Card(
    //                     child: ListTile(
    //                       leading: Image.network(
    //                         cart.getCartList()[index].image!,
    //                         width: 100,
    //                         height: 100,
    //                       ),
    //                       title: Text(
    //                         cart.getCartList()[index].title!,
    //                         overflow: TextOverflow.ellipsis,
    //                       ),
    //                       subtitle:
    //                           Text("${cart.getCartList()[index].price!} VND"),
    //                       trailing: Row(
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           IconButton(
    //                             onPressed: () {
    //                               cart.decrementQuantity(index);
    //                             },
    //                             icon: const Icon(Icons.remove),
    //                           ),
    //                           Text(cart
    //                               .getCartList()[index]
    //                               .quantity
    //                               .toString()),
    //                           IconButton(
    //                             onPressed: () {
    //                               cart.incrementQuantity(index);
    //                             },
    //                             icon: const Icon(Icons.add),
    //                           ),
    //                           IconButton(
    //                             onPressed: () {
    //                               cart.removeCart(index);
    //                             },
    //                             icon: const Icon(Icons.delete),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //       Padding(
    //         padding: const EdgeInsets.only(left: 20, right: 20),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             const Padding(
    //               padding: EdgeInsets.only(left: 10.0),
    //               child: Text(
    //                 'Total Price',
    //                 style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(right: 10.0),
    //               child: Text(
    //                 '${cart.totalPrice.toStringAsFixed(2).toString()} VND',
    //                 style: const TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       Container(
    //         height: 50,
    //         width: double.infinity,
    //         margin: EdgeInsets.only(top: 20, bottom: 20),
    //         padding: EdgeInsets.only(left: 20, right: 20),
    //         child: ElevatedButton(
    //           onPressed: () {
    //             List carts = cart.getCartList();
    //             int amountCart = carts.length;
    //             if (carts.isEmpty) {
    //               ScaffoldMessenger.of(context).showSnackBar(
    //                   const SnackBar(content: Text('Cart is empty')));
    //             } else {
    //               showDialog<void>(
    //                 context: context,
    //                 barrierDismissible: false, // user must tap button!
    //                 builder: (BuildContext context) {
    //                   return AlertDialog(
    //                     title: const Text('Thanks you for shopping'),
    //                     content: SingleChildScrollView(
    //                       child: ListBody(
    //                         children: <Widget>[
    //                           Text("You have ordered $amountCart products"),
    //                           const SizedBox(
    //                             height: 10,
    //                           ),
    //                           const Text('Thank you for your purchase'),
    //                         ],
    //                       ),
    //                     ),
    //                     actions: <Widget>[
    //                       TextButton(
    //                         child: const Text('Close'),
    //                         onPressed: () {
    //                           Navigator.of(context).pop();
    //                         },
    //                       ),
    //                     ],
    //                   );
    //                 },
    //               );
    //               cart.clearCart();
    //             }
    //           },
    //           style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.all(Colors.blue)),
    //           child: const Text('Check Out',
    //               style: TextStyle(color: Colors.white)),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
