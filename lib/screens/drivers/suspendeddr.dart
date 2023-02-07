import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/responsive.dart';
import 'package:adminweb/screens/drivers/driverspersonalpdf.dart';
import 'package:adminweb/screens/homescreen/homescreen.dart';
import 'package:adminweb/screens/homescreen/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuspendedDriversSreen extends StatefulWidget {
  const SuspendedDriversSreen({super.key});

  @override
  State<SuspendedDriversSreen> createState() => _SuspendedDriversSreenState();
}

class _SuspendedDriversSreenState extends State<SuspendedDriversSreen> {
  final ridesRefrence = FirebaseDatabase.instance.ref("drivers");

  String searchText = '';

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
                    'Suspended Drivers',
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
                    labelText: 'Search Driver',
                  ),
                  controller: _controller,
                  onChanged: (v) {
                    setState(() {
                      searchText = _controller.text;
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
                        stream: ridesRefrence
                            .orderByChild("IsSuspended")
                            .equalTo("true")
                            .onValue,
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
                          List<dynamic> filterlist = [];

                          Map<String, dynamic>? map =
                              snapshot.data.snapshot.value as dynamic;

                          storedocs.clear();

                          storedocs.add(map == null ? [] : map.values.toList());

                          final DataTableSource data = MyData(
                              khan: storedocs[0],
                              update: searchText,
                              context: context);
                          return SizedBox(
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
                                      'Date',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const DataColumn(
                                  label: SizedBox(
                                    child: Text(
                                      'Type',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const DataColumn(
                                  label: SizedBox(
                                    child: Text(
                                      'Status',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const DataColumn(
                                  label: SizedBox(
                                    child: Text(
                                      'Tip',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const DataColumn(
                                  label: SizedBox(
                                    child: Text(
                                      'Actions',
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
  MyData(
      {Key, required this.khan, required this.update, required this.context});

  List<dynamic> khan;
  BuildContext context;
  final ridesRefrence = FirebaseDatabase.instance.ref("drivers");
  String update;
  late List<dynamic> filter = khan
      .where((element) => (element["fullname"].contains(update) ||
          element["phone"].toString().contains(update)))
      .toList();

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => filter.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    List<TextEditingController> selected =
        List.generate(filter.length, (i) => TextEditingController());
    return DataRow(cells: [
      DataCell(
        Text(
          filter[index]['fullname'].toString(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      DataCell(Text(filter[index]['phone'].toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold))),
      DataCell(Text(
          DateFormat('MMMM-dd-yyyy')
              .format(DateTime.parse(filter[index]['SuspensionDate'])),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold))),
      DataCell(Text(filter[index]['vehicle_details']['car_type'] ?? "",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold))),
      DataCell(conatinerwid("Suspended", Colors.red)),
      DataCell(filter[index]['isApprove'].toString() == "true"
          ? const Icon(
              Icons.verified,
              color: Colors.green,
            )
          : const Icon(
              Icons.error,
              color: Colors.red,
            )),
      DataCell(
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            customItemsHeights: [
              ...List<double>.filled(MenuItems.firstItems.length, 48),
              8,
              ...List<double>.filled(MenuItems.secondItems.length, 48),
            ],
            items: [
              ...MenuItems.firstItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ...MenuItems.secondItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
            ],
            onChanged: (value) {
              MenuItems.onChanged(
                context,
                value as MenuItem,
                filter[index]['DriverId'].toString(),
                filter[index]['fullname'].toString(),
                filter[index]['phone'].toString(),
                filter[index]['Tip%'].toString(),
                filter[index]['vehicle_details']['car_type'].toString(),
                filter[index]['vehicle_details']['car_color'].toString(),
                filter[index]['vehicle_details']['car_model'].toString(),
                filter[index]['createdAt'].toString(),
                filter[index]['SuspensionReason'].toString(),
                filter[index]['SuspensionDate'].toString(),
              );
            },
            itemHeight: 48,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownWidth: 160,
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            dropdownElevation: 8,
            offset: const Offset(0, 8),
          ),
        ),
      ),
    ]);
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  final ridesRefrence = FirebaseDatabase.instance.ref("drivers");
  static const List<MenuItem> firstItems = [home];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Report', icon: Icons.print);

  static const logout = MenuItem(text: 'Remove', icon: Icons.delete);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  static onChanged(
      BuildContext context,
      MenuItem item,
      String driverid,
      String drivername,
      driverphone,
      tip,
      Type,
      colors,
      model,
      creationdate,
      suspensionreason,
      suspensiondate) {
    switch (item) {
      case MenuItems.home:
        printdriverdata(driverid, context, drivername, driverphone, Type,
            colors, model, creationdate, suspensionreason, suspensiondate);
        //Do something
        break;

      case MenuItems.logout:
        deletedriver(driverid, context, drivername);
        //Do something
        break;
    }
  }
}

deletedriver(String driverid, BuildContext context, String drivername) {
  final ridesRefrence =
      FirebaseDatabase.instance.ref("drivers").child(driverid);
  final suspend = FirebaseDatabase.instance
      .ref("drivers")
      .child(driverid)
      .child('IsSuspended');

  final cancelapprove = FirebaseDatabase.instance
      .ref("drivers")
      .child(driverid)
      .child('isApprove');

  final suspensionReason = FirebaseDatabase.instance
      .ref("drivers")
      .child(driverid)
      .child("SuspensionReason");
  final suspensionDate = FirebaseDatabase.instance
      .ref("drivers")
      .child(driverid)
      .child("SuspensionDate");

  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text(drivername),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                  "Are You Sure To Remove This Driver from The suspended List"),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  suspend.set("false");
                  cancelapprove.set("true");
                  suspensionReason.set("");
                  suspensionDate.set("");
                  Navigator.pop(context);
                },
                child: const Text("Ok")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
          ],
        );
      }));
}

printdriverdata(
    String driverid,
    BuildContext context,
    String drivername,
    driverphone,
    Type,
    colors,
    model,
    creationdate,
    suspensionreason,
    suspensiondate) {
  final ridesRefrence =
      FirebaseDatabase.instance.ref("drivers").child(driverid);

  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text("Driver: $drivername Report"),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              children: const [
                Text(
                  "From",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            TextField(
              readOnly: true,
              controller: datecontroller,
              onTap: () async {
                DateTime? showdate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000));

                if (showdate != null) {
                  datecontroller.text =
                      DateFormat("yyyy-MM-dd").format(showdate);
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                Text(
                  "To",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            TextField(
              readOnly: true,
              controller: datecontroller2,
              onTap: () async {
                DateTime? showdate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000));

                if (showdate != null) {
                  datecontroller2.text =
                      DateFormat("yyyy-MM-dd").format(showdate);
                }
              },
            ),
          ]),
          actions: [
            TextButton(
                onPressed: () {
                  datecontroller.clear();
                  datecontroller2.clear();
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () async {
                  if (datecontroller.text.isEmpty ||
                      datecontroller2.text.isEmpty) {
                  } else {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DriverPersonalPdfData(
                          suspensiondate: suspensiondate,
                          suspensionreason: suspensionreason,
                          reportname: "suspended",
                          driverphone: driverphone,
                          drivername: drivername,
                          name: driverid,
                          date1: datecontroller.text,
                          date2: datecontroller2.text,
                          type: Type,
                          colors: colors,
                          model: model,
                          creationdate: creationdate,
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Print")),
          ],
        );
      }));
}

TextEditingController datecontroller = TextEditingController();
TextEditingController datecontroller2 = TextEditingController();
TextEditingController errorcontrollertext = TextEditingController();
