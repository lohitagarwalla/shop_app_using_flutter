import 'package:flutter/material.dart';
import 'package:ghs_app/components/product.dart';
import 'package:ghs_app/components/utility.dart';
import 'package:ghs_app/screens/add_product.dart';
import 'textItemInfo.dart';

class ProductCard extends StatelessWidget {
  ProductCard({required this.product, this.isEditable = false});

  final bool isEditable;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
          width: 0.5,
        ),
        color: Color.fromARGB(10, 10, 10, 10),
        borderRadius: BorderRadius.circular(5),
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
            child: Image.memory(convertStringtoByteList(
              product.getimageString(),
            )),
            // child: Image.network(
            //   product.getimageString(),
            //   fit: BoxFit.contain,
            // ),
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
                    product.getname(),
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  ItemInfoText(
                    property: 'Item No',
                    value: product.getitemNo().toString(),
                  ),
                  ItemInfoText(
                    property: 'Description',
                    value: product.getdescription(),
                  ),
                  ItemInfoText(
                    property: 'Price',
                    value: product.getprice().toString(),
                  ),
                  ItemInfoText(
                    property: 'Category',
                    value: product.getCategory(),
                  ),
                  if (isEditable)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProductPage(
                                      product: product,
                                      title: 'Edit Product',
                                    )));
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
