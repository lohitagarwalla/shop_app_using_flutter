import 'package:flutter/material.dart';
import 'package:ghs_app/classes/product.dart';
import 'package:ghs_app/screens/home_page.dart';
import 'package:ghs_app/screens/item_details.dart';
import 'package:ghs_app/utility-folder/utility.dart';
// import 'package:ghs_app/screens/add_product.dart';
import 'textItemInfo.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductCard(
      {required this.product,
      // this.isEditable = false,
      required this.onDeleted});

  // bool isEditable;
  Product product;
  Function onDeleted;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetails(product: widget.product),
            ));
      },
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Hero(
                tag: widget.product.getitemNo().toString(),
                child: convertStringtoImage(widget.product.getimageString()),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Text(
                  widget.product.getname(),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Price  "),
                  Text(
                    widget.product.getprice().toString(),
                  )
                ],
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
