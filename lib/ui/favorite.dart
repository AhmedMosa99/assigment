import 'package:api/providers/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, x) {
          return provider.favarite == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: provider.favarite.length,
                  itemBuilder: (context, index) {
                    return GFListTile(
                      avatar: GFImageOverlay(
                          width: 100,
                          height: 80,
                          image: NetworkImage(provider.favarite[index].image)),
                      titleText: provider.favarite[index].title,
                      subTitle: Text(provider.favarite[index].price.toString()),
                    );
                  });
        },
      ),
    );
  }
}
