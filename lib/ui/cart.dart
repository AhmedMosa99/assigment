import 'package:api/providers/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, x) {
          return provider.cart == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: provider.cart.length,
                  itemBuilder: (context, index) {
                    return GFListTile(
                      avatar: GFImageOverlay(
                          width: 100,
                          height: 80,
                          image: NetworkImage(provider.cart[index].image)),
                      titleText: provider.cart[index].title,
                      subTitle: Text(provider.cart[index].price.toString()),
                    );
                  });
        },
      ),
    );
  }
}
