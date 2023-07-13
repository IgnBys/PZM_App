// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import 'account_page_controller.dart';
//
// class PicturePage extends StatefulWidget {
//   @override
//   _PicturePageState createState() => _PicturePageState();
// }
//
// class _PicturePageState extends State<PicturePage> {
//   final AccountPageController accountPageController = Get.find();
//
//   List<String> selectedImages = [];
//
//   List<String> images = [
//     // Add your image URLs here
//     // '../../../../depositphotos_179282970-stock-illustration-developer-flat-vector-icon.jpg',
//     'https://cdn4.iconfinder.com/data/icons/people-of-medical-education-and-science/512/People_Medical_Education_Science_lab_scientist_woman-1024.png',
//     'https://cdn.pixabay.com/photo/2012/04/18/15/20/nurse-37322_1280.png',
//     'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png',
//     'https://cdn.pixabay.com/photo/2016/12/13/16/17/dancer-1904467_1280.png',
//     'https://cdn.pixabay.com/photo/2014/12/22/00/07/tree-576847_1280.png',
//     // Add more image URLs as needed
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Picture Page'),
//       ),
//       body: GridView.count(
//         crossAxisCount: 2, // Two images per row
//         children: List.generate(images.length, (index) {
//           final imageUrl = images[index];
//           final isSelected = selectedImages.contains(imageUrl);
//
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 if (isSelected) {
//                   selectedImages.remove(imageUrl);
//                 } else {
//                   selectedImages.add(imageUrl);
//                 }
//               });
//             },
//             child: Stack(
//               children: [
//                 Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Icon(
//                     isSelected ? Icons.check_circle : Icons.check_circle_outline,
//                     color: Colors.green,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Return the selected images to the previous screen
//           print('---------------SELECTED IMAGE--------------');
//           print(selectedImages);
//           accountPageController.changeAppUserData('picture', selectedImages[0]); // Сохраните выбранные изображения после обновления списка
//
//           Navigator.pop(context, selectedImages);
//         },
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }
