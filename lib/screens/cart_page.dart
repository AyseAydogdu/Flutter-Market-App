import 'package:flutter/material.dart';
import 'package:marketapp/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage();

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("My Cart"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.saved.length,
              itemBuilder: (context, index) {
                final item = cartProvider.saved[index];
                return ListTile(
                  title: Text(item.productName),
                  trailing: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      cartProvider.removeProduct(item);
                    },
                  ),
                );
              },
            ),
          ),
          Divider(
            color: Colors.deepPurpleAccent,
            thickness: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 100,
              child: Text(
                "Total: ${cartProvider.totalPrice}",
                style: TextStyle(fontSize: 40.0, color: Colors.teal[300]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
