import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/presentation/pages/menu/users_pages/users_page_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_aplication/presentation/pages/drawer/drawer.dart';


class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> with SingleTickerProviderStateMixin {
  final UsersPageController usersPageController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('UsersPage'),
      ),
      body:
          Builder(
            builder: (BuildContext context) {

              return StreamBuilder<List<Map<String, dynamic>>>(
                stream: usersPageController.fetchDataFromFirestore(),
                builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> orders = snapshot.data ?? [];

                    if (orders.isEmpty) {
                      return Center(
                        child: Text('No orders found.'),
                      );
                    }

                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index)  {
                        Map<String, dynamic> order = orders[index];
                        final [orderNumber,typeOfOrder,address,counterStatus,date] = usersPageController.checkValues(order);
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(
                                    0, 3), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              '$typeOfOrder $orderNumber',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              '$address\n$date\nCounter status: $counterStatus',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            },
          ),

      );

  }
}
