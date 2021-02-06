import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:marketapp/models/products.dart';
import 'package:marketapp/provider/cart_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  Products product;
  DetailPage(this.product);

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(product.productName),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset(product.imageUrl),
                  Text(product.description),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.unitPrice.toString() + ' TL',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.shopping_cart),
            onPressed: () {
              cartProvider.addProduct(product);
              Flushbar(
                message: "Ürün Eklendi",
                duration: Duration(seconds: 5),
                backgroundColor: Colors.deepPurpleAccent,
              )..show(context);
            }));
  }
}
