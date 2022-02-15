// import 'package:flutter/material.dart';
// import 'package:ghs_app/components/constants.dart';
// import 'package:ghs_app/screens/home_page.dart';
// // import 'package:ghs_app/utility-folder/dropDownList.dart';

// String categorySearchUrl = endPoint + '/products/searchcategory/';

// class ShowCategory extends StatefulWidget {
//   const ShowCategory({Key? key}) : super(key: key);

//   @override
//   _ShowCategoryState createState() => _ShowCategoryState();
// }

// class _ShowCategoryState extends State<ShowCategory> {
//   int categoryCount = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shop by category'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//           ),
//           itemCount: dropDownList.length,
//           itemBuilder: (BuildContext context, int index) {
//             return categoryCard(index);
//           },
//         ),
//       ),
//     );
//   }

//   Widget categoryCard(int index) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => HomePage(
//                     getUrl: categorySearchUrl + dropDownList[index],
//                   )),
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.all(10),
//         child: Center(
//           child: Text(
//             dropDownList[index],
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 17,
//             ),
//           ),
//         ),
//         margin: EdgeInsets.all(8),
//         height: 100,
//         decoration: BoxDecoration(
//             color: Color(0x09000000), borderRadius: BorderRadius.circular(150)),
//       ),
//     );
//   }
// }
