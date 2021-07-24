import 'package:flutter/material.dart';
import 'package:ghs_app/classes/product.dart';
import 'package:ghs_app/utility-folder/utility.dart';
import 'package:ghs_app/screens/add_product.dart';
import 'textItemInfo.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductCard({required this.product, this.isEditable = false});

  bool isEditable;
  Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: convertStringtoImage(widget.product.getimageString()),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    widget.product.getname(),
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  ItemInfoText(
                    property: 'Item No',
                    value: widget.product.getitemNo().toString(),
                  ),
                  ItemInfoText(
                    property: 'Description',
                    value: widget.product.getdescription(),
                  ),
                  ItemInfoText(
                    property: 'Price',
                    value: widget.product.getprice().toString(),
                  ),
                  ItemInfoText(
                    property: 'Category',
                    value: widget.product.getCategory(),
                  ),
                  if (widget.isEditable)
                    ElevatedButton(
                      onPressed: () async {
                        var returnProduct = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProductPage(
                                      product: widget.product,
                                      title: 'Edit Product',
                                    )));
                        setState(() {
                          widget.product = returnProduct;
                        });
                      },
                      child: Text('Edit'),
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
