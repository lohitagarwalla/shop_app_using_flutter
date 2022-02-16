import 'package:flutter/material.dart';
import 'package:ghs_app/classes/product.dart';
import 'package:ghs_app/screens/home_page.dart';
import 'package:ghs_app/screens/item_details.dart';
import 'package:ghs_app/utility-folder/utility.dart';
// import 'package:ghs_app/screens/add_product.dart';
import 'textItemInfo.dart';

class ProductCard extends StatelessWidget {
  ProductCard({required this.product, required this.onDeleted});

  final Product product;
  final Function onDeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ItemDetails(product: product, title: 'Product Details'),
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
                // tag: widget.product.getitemNo().toString(),
                convertStringtoImage(product.getimageString()),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Text(
                    product.getname(),
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Price  "),
                    Text(
                      product.getprice().toString(),
                    )
                  ],
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
