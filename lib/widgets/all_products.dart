import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:marketapp/models/products.dart';
import 'package:marketapp/provider/cart_provider.dart';
import 'package:marketapp/screens/detail_page.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getProductsFromApi();
    List<Products> products = cartProvider.getProducts();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: SizedBox(
            height: 15,
            child: products != null
                ? GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(products[index]),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GridTile(
                              child: Image.asset(products[index].imageUrl),
                              footer: GridTileBar(
                                title: Text(products[index].productName),
                                trailing: IconButton(
                                  icon: Icon(Icons.shopping_cart),
                                  onPressed: () {
                                    cartProvider.addProduct(products[index]);
                                    Flushbar(
                                      message: "Ürün Eklendi",
                                      duration: Duration(seconds: 5),
                                      backgroundColor: Colors.deepPurpleAccent,
                                    )..show(context);
                                  },
                                ),
                                backgroundColor: Colors.black,
                              )),
                        ),
                      );
                    },
                    physics: ScrollPhysics(),
                    itemCount: products.length,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )),
      ),
    );
  }
}
