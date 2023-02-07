import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/responsive.dart';
import 'package:adminweb/screens/drivers/driverspersonalpdf.dart';
import 'package:adminweb/screens/drivers/driversprofile.dart';
import 'package:adminweb/screens/homescreen/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:uuid/uuid.dart';

class DriversScreens extends StatefulWidget {
  DriversScreens({super.key, required this.adminName});
  String adminName;

  @override
  State<DriversScreens> createState() => _DriversScreensState();
}

class _DriversScreensState extends State<DriversScreens> {
  final driversrefrence = FirebaseDatabase.instance.ref("drivers");
  DatabaseReference depositRefrence = FirebaseDatabase.instance.ref();

  final availableDriversRefrence =
      FirebaseDatabase.instance.ref("driversAvailable");
  String searchText = '';

  final TextEditingController _controller = TextEditingController();
  MenuItems calssmenu = MenuItems();

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
                    'Drivers',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
            MaterialButton(
              color: Colors.green[600],
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (ctx, a1, a2) {
                    return Container();
                  },
                  transitionBuilder: (ctx, a1, a2, child) {
                    TextEditingController searchdrivercontroller =
                        TextEditingController();
                    var curve = Curves.easeInOut.transform(a1.value);
                    String searchdrivererror = "";
                    return Transform.scale(
                      scale: curve,
                      child: AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("CANCEL")),
                          TextButton(
                              onPressed: () async {
                                await depositRefrence
                                    .child("drivers")
                                    .orderByChild("DriverSerial")
                                    .equalTo(searchdrivercontroller.text)
                                    .once()
                                    .then((DatabaseEvent databaseEvent) {
                                  if (databaseEvent.snapshot.value != null) {
                                    Navigator.pop(context);
                                    Map<dynamic, dynamic> values =
                                        databaseEvent.snapshot.value as Map;
                                    values.forEach((key, values) {
                                      showGeneralDialog(
                                        context: context,
                                        pageBuilder: (ctx, a1, a2) {
                                          return Container();
                                        },
                                        transitionBuilder:
                                            (ctx, a1, a2, child) {
                                          TextEditingController
                                              addcashController =
                                              TextEditingController();
                                          var curve = Curves.easeInOut
                                              .transform(a1.value);

                                          return Transform.scale(
                                            scale: curve,
                                            child: AlertDialog(
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      if (addcashController
                                                          .text.isNotEmpty) {
                                                        String depositUid =
                                                            const Uuid()
                                                                .v1()
                                                                .toString();
                                                        Map depositmap = {
                                                          "Amount":
                                                              addcashController
                                                                  .text,
                                                          "date": DateTime.now()
                                                              .toString(),
                                                          "Uid": depositUid,
                                                          "AddedBy": widget
                                                              .adminName
                                                              .toString()
                                                        };
                                                        await depositRefrence
                                                            .child("drivers")
                                                            .child(values[
                                                                "DriverId"])
                                                            .child("Deposits")
                                                            .child(depositUid)
                                                            .set(depositmap);

                                                        await depositRefrence
                                                            .child("drivers")
                                                            .child(values[
                                                                "DriverId"])
                                                            .child(
                                                                "LastCahDepositDate")
                                                            .set(DateTime.now()
                                                                .toString());

                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child:
                                                        const Text("ADD Cash")),
                                              ],
                                              title: ListTile(
                                                title: Text(values["fullname"]
                                                    .toString()),
                                                subtitle: Text(
                                                    values["phone"].toString()),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all()),
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9]')),
                                                      ],
                                                      controller:
                                                          addcashController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "Deposit Cash To Driver Wallet",
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(10)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 300),
                                      );
                                    });
                                  } else {}
                                });
                              },
                              child: const Text("Search")),
                        ],
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(border: Border.all()),
                              child: TextField(
                                controller: searchdrivercontroller,
                                decoration: const InputDecoration(
                                    hintText: "Search Driver",
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                            ),
                            Text(searchdrivercontroller.text)
                          ],
                        ),
                      ),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );
              },
              child: const Text(
                "Cash Deposit",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
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
                        stream: driversrefrence.onValue,
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

                          storedocs.add(map == null
                              ? []
                              : map.values
                                  .where((element) =>
                                      element["IsSuspended"]
                                              .toString()
                                              .trim() ==
                                          "false" &&
                                      element["vehicledetails"]
                                              .toString()
                                              .trim() ==
                                          "true")
                                  .toList());

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
                                      'Serial Code',
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
      .where((element) => (element["fullname"]
              .toString()
              .toLowerCase()
              .contains(update.toLowerCase()) ||
          element["phone"].toString().contains(update) ||
          element["DriverSerial"].toString().contains(update)))
      .toList();

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
      DataCell(Text(filter[index]['DriverSerial'].toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold))),
      DataCell(Text(filter[index]['phone'].toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold))),
      DataCell(Text(filter[index]['vehicle_details']['car_type'] ?? "",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold))),
      DataCell(filter[index]['status'].toString() == "online"
          ? conatinerwid("online", Colors.green)
          : conatinerwid("offline", Colors.red)),
      DataCell(filter[index]['isApprove'] == "true"
          ? conatinerwid("Approved", Colors.green)
          : conatinerwid("Waiting", Colors.red)),
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
            onChanged: (value) async {
              List<dynamic> storedocs = [];
              await ridesRefrence
                  .child(filter[index]['DriverId'])
                  .child("Deposits")
                  .once()
                  .then((DatabaseEvent databaseEvent) {
                if (databaseEvent.snapshot.value != null) {
                  Map<String, dynamic>? map =
                      databaseEvent.snapshot.value as dynamic;

                  storedocs.add(map == null ? [] : map.values.toList());
                }
              });
              // ignore: use_build_context_synchronously
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
                  filter[index]['isApprove'].toString(),
                  filter[index]["vehicle_details"]["profilePicture"].toString(),
                  filter[index]["DriverId"].toString(),
                  filter[index]["phone"].toString(),
                  filter[index]["email"].toString(),
                  filter[index]["vehicle_details"]["cnic"].toString(),
                  filter[index]["isreject"].toString(),
                  filter[index]["vehicle_details"]["license"].toString(),
                  filter[index]["vehicle_details"]["vehiclePicture"].toString(),
                  filter[index]["token"].toString(),
                  filter[index]["Contacts"]["EmergencyContactNumber"]
                      .toString(),
                  filter[index]["Contacts"]["contactNumber"].toString(),
                  filter[index]["vehicle_details"]["car_type"].toString(),
                  filter[index]["vehicle_details"]["car_model"].toString(),
                  filter[index]["vehicle_details"]["car_color"].toString(),
                  filter[index]["vehicle_details"]["vehicle_number"].toString(),
                  storedocs[0]);
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
  static const List<MenuItem> firstItems = [profile, home, settings, Tip];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Report', icon: Icons.print);
  static const profile = MenuItem(text: 'Profile', icon: Icons.person_pin);
  static const settings = MenuItem(text: 'Suspend', icon: Icons.stop);
  static const logout = MenuItem(text: 'Delete', icon: Icons.delete);
  static const Tip = MenuItem(text: 'Tip', icon: Icons.money);

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
      isapprove,
      profileurl,
      id,
      phonenumber,
      email,
      cnicPic,
      rejectstatus,
      licenesepic,
      vehiclepic,
      token,
      contact1,
      contacr2,
      vehictype,
      vehiclemodel,
      vehicleColor,
      vehicleNumber,
      List<dynamic> listdeposits) {
    switch (item) {
      case MenuItems.profile:
        driverprofilepage(
            context,
            profileurl,
            id,
            phonenumber,
            drivername,
            email,
            cnicPic,
            "",
            licenesepic,
            vehiclepic,
            "",
            contact1,
            contacr2,
            vehictype,
            vehiclemodel,
            vehicleColor,
            vehicleNumber,
            listdeposits);
        //Do something
        break;
      case MenuItems.home:
        printdriverdata(driverid, context, drivername, driverphone, Type,
            colors, model, creationdate);
        //Do something
        break;
      case MenuItems.settings:
        suspenddriver(driverid, context, drivername, isapprove);

        //Do something
        break;
      case MenuItems.Tip:
        tipdrivers(context, tip, driverid);

        //Do something
        break;

      case MenuItems.logout:
        deletedriver(driverid, context, drivername);
        //Do something
        break;
    }
  }
}

suspenddriver(
    String driverid, BuildContext context, String drivername, isapproved) {
  final suspend = FirebaseDatabase.instance
      .ref("drivers")
      .child(driverid)
      .child('IsSuspended');

  List<String> suspensionreason = [
    'MisBehavior',
    'Late',
    'Bad Reviews',
    'Other Reason',
  ];

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

  TextEditingController controller = TextEditingController();
  return showDialog(
      context: context,
      builder: ((context) {
        return isapproved == "true"
            ? AlertDialog(
                title: Text("Driver: $drivername"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Are You Sure To Suspend This Driver?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Select A Reason",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: ListView.builder(
                          itemCount: suspensionreason.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListTile(
                                  onTap: () {
                                    if (index == suspensionreason.length - 1) {
                                      showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return AlertDialog(
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      suspend.set("true");
                                                      cancelapprove
                                                          .set("false");
                                                      suspensionDate.set(
                                                          DateTime.now()
                                                              .toString());
                                                      suspensionReason
                                                          .set(controller.text);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text("Suspend")),
                                              ],
                                              content: Container(
                                                child: TextField(
                                                  maxLines: 5,
                                                  minLines: 5,
                                                  controller: controller,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'type Reason',
                                                  ),
                                                ),
                                              ),
                                            );
                                          }));
                                    } else {
                                      suspend.set("true");
                                      suspensionDate
                                          .set(DateTime.now().toString());
                                      cancelapprove.set("false");
                                      suspensionReason
                                          .set(suspensionreason[index]);
                                      Navigator.pop(context);
                                    }
                                  },
                                  title: Text(suspensionreason[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ),
                            );
                          })),
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                ],
              )
            : AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("ok"))
                ],
                content: Text(
                    "This driver is Not approved/Verified \n Cannot suspend Now $isapproved"),
              );
      }));
}

deletedriver(String driverid, BuildContext context, String drivername) {
  final ridesRefrence =
      FirebaseDatabase.instance.ref("drivers").child(driverid);

  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text(drivername),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Are You Sure To Delete This Driver"),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  ridesRefrence.remove();
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

printdriverdata(String driverid, BuildContext context, String drivername,
    driverphone, Type, colors, model, creationdate) {
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
                          suspensiondate: "",
                          suspensionreason: "",
                          reportname: "",
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

tipdrivers(BuildContext context, String tip, String driverid) {
  TextEditingController controllertip = TextEditingController();
  TextEditingController oldtipcont = TextEditingController();
  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  FirebaseDatabase.instance
                      .ref("drivers")
                      .child(driverid)
                      .child("Tip%")
                      .set(controllertip.text);
                  Navigator.pop(context);
                },
                child: const Text("Save"))
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldtipcont..text = "$tip%",
                readOnly: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    labelText: "OLD Tip",
                    contentPadding: EdgeInsets.only(left: 5)),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                maxLength: 3,
                keyboardType: TextInputType.number,
                controller: controllertip..text = "0",
                onChanged: (value) {
                  if (int.parse(controllertip.text) > 100) {
                    controllertip.clear();
                  }
                },
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    labelText: "New Tip",
                    contentPadding: EdgeInsets.only(left: 5)),
              )
            ],
          ),
        );
      }));
}

TextEditingController datecontroller = TextEditingController();
TextEditingController datecontroller2 = TextEditingController();
TextEditingController errorcontrollertext = TextEditingController();
