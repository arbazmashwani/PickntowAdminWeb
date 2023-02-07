import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/responsive.dart';
import 'package:adminweb/screens/homescreen/homescreen.dart';
import 'package:adminweb/screens/homescreen/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RiderScreen extends StatefulWidget {
  const RiderScreen({super.key});

  @override
  State<RiderScreen> createState() => _RiderScreenState();
}

class _RiderScreenState extends State<RiderScreen> {
  final ridesRefrence = FirebaseDatabase.instance.ref("users");

  String SearchText = '';

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff414950),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            Responsive.isMobile(context)
                ? Container()
                : const Text(
                    'Customers',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SizedBox(
                width: 300,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    suffixIcon: const Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1),
                    ),
                    labelText: 'Search Customer',
                  ),
                  controller: _controller,
                  onChanged: (v) {
                    setState(() {
                      SearchText = _controller.text.toString().trim();
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          textTheme: const TextTheme(caption: TextStyle(color: Colors.white)),
          dividerColor: const Color(0xff414950),
          cardColor: kPrimaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    color: const Color(0xff343A40),
                    child: StreamBuilder(
                        stream: ridesRefrence.onValue,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {}
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: LinearProgressIndicator(),
                            );
                          }

                          List<dynamic> storedocs = [];

                          Map<String, dynamic>? map =
                              snapshot.data.snapshot.value as dynamic;

                          storedocs.clear();

                          storedocs.add(map == null ? [] : map.values.toList());

                          final DataTableSource data =
                              MyData(khan: storedocs[0], update: SearchText);
                          return Container(
                            width: width,
                            child: PaginatedDataTable(
                              arrowHeadColor: Colors.white,
                              source: data,
                              columns: [
                                DataColumn(
                                  label: SizedBox(
                                    width: width * .1,
                                    child: const Text(
                                      'Name',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: width * .1,
                                    child: const Text(
                                      'Email',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: width * .2,
                                    child: const Text(
                                      'Phone',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: width * .1,
                                    child: const Text(
                                      'Type',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: width * .1,
                                    child: const Text(
                                      'Action',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                              headingRowHeight: 40,
                              horizontalMargin: 10,
                              dataRowHeight: 60,
                              rowsPerPage: 7,
                              showCheckboxColumn: false,
                            ),
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  // ignore: avoid_types_as_parameter_names
  MyData({Key, required this.khan, required this.update});

  List<dynamic> khan;
  String update;
  late List<dynamic> filter =
      khan.where((element) => element["fullname"].contains(update)).toList();

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => filter.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text(
          filter[index]['fullname'].toString(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      DataCell(Text(filter[index]['email'].toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold))),
      DataCell(Text(filter[index]['phone'].toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold))),
      const DataCell(Text("Full Access",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      DataCell(IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ]);
  }
}
