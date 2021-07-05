import 'package:flutter/material.dart';
import 'textItemInfo.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {this.imageUrl = '',
      this.productName = '',
      this.itemNo = 0,
      this.desctiption = '',
      this.price = 0,
      this.category = ''});

  final String imageUrl;
  final String productName;
  final int itemNo;
  final String desctiption;
  final int price;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
          width: 1.7,
        ),
        color: Color.fromARGB(10, 10, 10, 10),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 300,
      margin: const EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    productName,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  ItemInfoText(
                    property: 'Item No',
                    value: itemNo.toString(),
                  ),
                  ItemInfoText(
                    property: 'Description',
                    value: desctiption,
                  ),
                  ItemInfoText(
                    property: 'Price',
                    value: price.toString(),
                  ),
                  ItemInfoText(
                    property: 'Category',
                    value: category,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
