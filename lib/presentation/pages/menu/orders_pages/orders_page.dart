import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_aplication/presentation/pages/drawer/drawer.dart';

import 'orders_alert_dialog.dart';
import 'orders_page_controller.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  final OrdersPageController ordersPageController = Get.find();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        bottom: TabBar(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
          ],
        ),
        title: Text('OrdersPage'),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Builder(
            builder: (BuildContext context) {

              return StreamBuilder<List<Map<String, dynamic>>>(
                stream: ordersPageController.getTodayOrdersFromCollection(),
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
                        print('+++++++++++++++++++++++++');
                        // final orderNumber, typeOfOrder, address, counterStatus,date;
                        var [orderNumber, typeOfOrder, address, counterStatus, date] = ordersPageController.checkValues(order);

                        print('+++++++++++++----------------++++++++++++');
                        // final orderNumber = values[0];
                        // final typeOfOrder = values[1];
                        // final address = values[2];
                        // final counterStatus = values[3];
                        // final date = values[4];




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
                            trailing: IconButton(
                              icon: Icon(Icons.check_circle,
                              color: Colors.yellowAccent,),
                              onPressed: () {
                                print('-------------ORDER--------------');
                                print(order);
                                print('------------------------------');
                                print('------------------order index-----------------');
                                print(order[index]);
                                print('-----------------------------------');
                                ordersPageController.changeAppOrderStatus(order);
                              },
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
          // Placeholder for the second tab
          Builder(

            builder: (BuildContext context) {

              return StreamBuilder<List<Map<String, dynamic>>>(
                stream: ordersPageController.getAllOrdersFromCollection(),
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
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> order = orders[index];

                        // final orderNumber, typeOfOrder, address, counterStatus,date;
                        var [orderNumber, typeOfOrder, address, counterStatus,date ] = ordersPageController.checkValues(order);
                        print('+++++++++++++----------------++++++++++++');
                        // final orderNumber = values[0];
                        // final typeOfOrder = values[1];
                        // final address = values[2];
                        // final counterStatus = values[3];
                        // final date = values[4];

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
                            trailing: IconButton(
                              icon: Icon(Icons.check_circle,
                                color: Colors.greenAccent,),
                              onPressed: () {
                                // ordersPageController.changeAppOrderStatus(ordersPageController.appOrdersList[index]);

                              },
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
        ],
      ),
      floatingActionButton: OrdersAlertDialog(
      ),
    );
  }
}
