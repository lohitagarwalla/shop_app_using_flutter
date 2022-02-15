import 'package:flutter/material.dart';
import 'package:ghs_app/classes/product.dart';
import 'package:ghs_app/components/textItemInfo.dart';
import 'package:ghs_app/utility-folder/utility.dart';

class ItemDetails extends StatefulWidget {
  ItemDetails({required Product this.product});

  final Product product;

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.product.getitemNo().toString(),
                  child: convertStringtoImage(widget.product.getimageString()),
                ),
                Text(
                  widget.product.getname(),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Buy"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
