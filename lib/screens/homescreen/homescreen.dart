import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/notifications.dart';
import 'package:adminweb/helpers/responsive.dart';
import 'package:adminweb/screens/homescreen/widgets.dart';

import 'package:adminweb/widgets/containers.dart';
import 'package:adminweb/widgets/map.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ridesRefrencedrivers = FirebaseDatabase.instance.ref("drivers");
  final driversstates = FirebaseDatabase.instance.ref("drivers");
  final ref = FirebaseDatabase.instance.ref("rideRequest");
  final driverRegisteredRefrence = FirebaseDatabase.instance.ref("drivers");
  final driverRegisteredRefrence2 = FirebaseDatabase.instance.ref("drivers");
  final userRegisteredRefrence = FirebaseDatabase.instance.ref("users");
  final ridesRefrence = FirebaseDatabase.instance.ref("rideRequest");
  final availableDriversRefrence =
      FirebaseDatabase.instance.ref("driversAvailable");

  final driversnamelist = FirebaseDatabase.instance.ref();
  DatabaseReference userRef = FirebaseDatabase.instance.ref("drivers");
  GlobalKey key = GlobalKey();
  double boxheight = 240;

  final ridesRefrencedriverssss = FirebaseDatabase.instance.ref("drivers");
  final ridesRefrencedriversh = FirebaseDatabase.instance.ref("drivers");
  final ridesRefrencedriversz = FirebaseDatabase.instance.ref("drivers");
  final todayridesrefrence = FirebaseDatabase.instance.ref("rideRequest");
  final todayridesrefrence1 = FirebaseDatabase.instance.ref("rideRequest");
  final todayridesrefrence2 = FirebaseDatabase.instance.ref("rideRequest");
  final todayridesrefrence3 = FirebaseDatabase.instance.ref("rideRequest");

  final Maps _maps = Maps();
  String sportsnumber = "";
  String basiccars = "";
  String standardscars = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff414950),
      body: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: const Color(0xff414950),
        ),
        child: Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: SizedBox(
                    height: 100,
                    child: Card(
                      elevation: 0,
                      color: const Color(0xff414950),
                      child: Row(
                        children: [
                          Expanded(
                              child: streamBuilderMethod(
                                  ridesRefrencedrivers.onValue,
                                  "Drivers Registered",
                                  Icons.people,
                                  const Color(0xff007bff))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width < 814
                                  ? 4
                                  : 10),
                          Expanded(
                              child: streamBuilderMethod(
                                  userRegisteredRefrence.onValue,
                                  "Riders Registered",
                                  Icons.people_outline,
                                  const Color(0xff28a745))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width < 814
                                  ? 4
                                  : 10),
                          Expanded(
                              child: streamBuilderMethod(
                                  ridesRefrence.onValue,
                                  "Total Rides",
                                  Icons.car_rental_outlined,
                                  const Color(0xffffc107))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width < 814
                                  ? 4
                                  : 10),
                          Expanded(
                              child: streamBuilderMethod(
                                  availableDriversRefrence.onValue,
                                  "Available Drivers",
                                  Icons.verified,
                                  const Color(0xffdc3545))),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 4),
                      child: Container(
                        color: const Color(0xff343A40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IntrinsicHeight(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width < 801
                                      ? 10
                                      : 50,
                                  right: MediaQuery.of(context).size.width < 801
                                      ? 10
                                      : 50,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: driverstatsstream(
                                          driversstates
                                              .orderByChild("IsSuspended")
                                              .startAt("true")
                                              .endAt("true")
                                              .onValue,
                                          "Suspended Drivers",
                                          context),
                                    ),
                                    VerticalDivider(
                                      color: Colors.white,
                                      thickness:
                                          MediaQuery.of(context).size.width <
                                                  800
                                              ? 1
                                              : 2,
                                    ),
                                    Container(
                                        child: driverstatsstream(
                                            driversstates
                                                .orderByChild("vehicledetails")
                                                .startAt("false")
                                                .endAt("false")
                                                .onValue,
                                            "Incomplete Registration",
                                            context)),
                                    const VerticalDivider(
                                      color: Colors.white,
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: driverstatsstream(
                                            driversstates
                                                .orderByChild("isApprove")
                                                .startAt("false")
                                                .endAt("false")
                                                .onValue,
                                            "Waiting For Approval",
                                            context)),
                                    const VerticalDivider(
                                      color: Colors.white,
                                      thickness: 2,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          textwidget("0", context),
                                          textwidget(
                                              "InActive Drivers", context)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 255,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: [
                        MediaQuery.of(context).size.width < 841
                            ? Container()
                            : Expanded(
                                flex: 3,
                                child: Card(
                                    elevation: 0,
                                    child: Container(
                                        color: const Color(0xff343A40),
                                        child: Column(
                                          children: [
                                            Card(
                                              color: const Color(0xff343A40),
                                              elevation: 10,
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8,
                                                          top: 4,
                                                          bottom: 4),
                                                      child: Text(
                                                        "Drivers",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8,
                                                                top: 4,
                                                                bottom: 4),
                                                        child: TextButton(
                                                          onPressed: () {},
                                                          child: const Text(
                                                            "View All",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: 200,
                                                child: StreamBuilder(
                                                    stream:
                                                        driverRegisteredRefrence
                                                            .onValue,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                      if (snapshot.hasError) {}
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      }

                                                      final List<dynamic>
                                                          storedocs = [];

                                                      Map<String, dynamic>?
                                                          map = snapshot
                                                              .data
                                                              .snapshot
                                                              .value as dynamic;

                                                      storedocs.clear();

                                                      storedocs.add(map == null
                                                          ? []
                                                          : map.values
                                                              .where((element) =>
                                                                  element["vehicledetails"]
                                                                      .toString()
                                                                      .trim() ==
                                                                  'true')
                                                              .toList());

                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8,
                                                                top: 8),
                                                        child: GridView.builder(
                                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                crossAxisSpacing:
                                                                    0,
                                                                mainAxisSpacing:
                                                                    10),
                                                            itemCount:
                                                                storedocs[0]
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        ctx,
                                                                    index) {
                                                              return Column(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: Responsive.isDesktop(
                                                                            context)
                                                                        ? 15
                                                                        : 30,
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            storedocs[0][index]["vehicle_details"]["profilePicture"].toString()),
                                                                  ),
                                                                  Text(
                                                                    storedocs[0][index]
                                                                            [
                                                                            "fullname"]
                                                                        .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            }),
                                                      );
                                                    })),
                                          ],
                                        )))),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 7,
                            child: Card(
                                elevation: 0,
                                child: Container(
                                  color: const Color(0xff343A40),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8, top: 4, bottom: 4),
                                              child: Text(
                                                "New Drivers Requests",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      StreamBuilder(
                                          stream: userRef
                                              .orderByChild("isApprove")
                                              .startAt("false")
                                              .endAt("false")
                                              .onValue,
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasError) {}
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }

                                            final List<dynamic> storedocs = [];

                                            Map<String, dynamic>? map = snapshot
                                                .data.snapshot.value as dynamic;

                                            storedocs.clear();

                                            storedocs.add(map == null
                                                ? []
                                                : map.values
                                                    .where((element) =>
                                                        element["vehicledetails"]
                                                                .toString()
                                                                .trim() ==
                                                            'true' &&
                                                        element["IsSuspended"]
                                                                .toString()
                                                                .trim() ==
                                                            'false')
                                                    .toList());

                                            return SizedBox(
                                              width: width,
                                              child: _createDataTable(
                                                  storedocs[0], width),
                                            );
                                          })
                                    ],
                                  ),
                                ))),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 7,
                            child: Card(
                                child: Container(
                                    color: const Color(0xff343A40),
                                    child: Column(
                                      children: [
                                        Card(
                                          color: const Color(0xff343A40),
                                          child: Container(
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8,
                                                      top: 4,
                                                      bottom: 4),
                                                  child: Text(
                                                    "Operational Area",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 350,
                                          child: _maps.getMap(
                                              25.276987, 55.296249),
                                        )
                                      ],
                                    )))),
                        Expanded(
                            flex: 3,
                            child: Card(
                                child: Container(
                              color: const Color(0xff343A40),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    color: const Color(0xff343A40),
                                    child: Container(
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, top: 4, bottom: 4),
                                            child: Text(
                                              "Vehicles",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: streamBuilderMethod2(
                                          ridesRefrencedriverssss.onValue,
                                          "Sports",
                                          'Sports',
                                          Icons.sports)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                      child: streamBuilderMethod2(
                                          ridesRefrencedriversh.onValue,
                                          "Standards",
                                          "Standards",
                                          Icons.stay_current_landscape)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                      child: streamBuilderMethod2(
                                          ridesRefrencedriversz.onValue,
                                          "Heavey",
                                          "Heavey",
                                          Icons.fire_truck)),
                                ],
                              ),
                            ))),
                        const SizedBox(
                          width: 0,
                        ),
                        Expanded(
                            flex: 4,
                            child: Card(
                                child: Container(
                              color: const Color(0xff343A40),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    color: const Color(0xff343A40),
                                    child: Container(
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, top: 4, bottom: 4),
                                            child: Text(
                                              "Rides Analytics",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: todayRidesRefrencestream(
                                          todayridesrefrence.onValue,
                                          "Today Rides",
                                          '',
                                          Icons.car_rental_sharp)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                      child: todayRidesRefrencestream(
                                          todayridesrefrence1.onValue,
                                          "Last Month Rides",
                                          '',
                                          Icons.car_rental_sharp)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                      child: todayRidesRefrencestream(
                                          todayridesrefrence2.onValue,
                                          "Total Completed Rides",
                                          '',
                                          Icons.car_rental_sharp)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                      child: todayRidesRefrencestream(
                                          todayridesrefrence3.onValue,
                                          "Total Rides Fares",
                                          '',
                                          Icons.car_rental_sharp)),
                                ],
                              ),
                            ))),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 305,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 7,
                            child: Card(
                                elevation: 0,
                                child: Container(
                                  color: const Color(0xff343A40),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8, top: 4, bottom: 4),
                                              child: Text(
                                                "Recent Rides Requests",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      StreamBuilder(
                                          stream: ridesRefrence
                                              .limitToLast(5)
                                              .onValue,
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasError) {}
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }

                                            final List<dynamic> storedocs = [];

                                            Map<String, dynamic>? map = snapshot
                                                .data.snapshot.value as dynamic;

                                            storedocs.clear();

                                            storedocs.add(map == null
                                                ? []
                                                : map.values.toList());

                                            return _createDataTable2(
                                                storedocs[0], context, width);
                                          })
                                    ],
                                  ),
                                ))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showAlertDialog(
      String profileurl,
      id,
      phonenumber,
      drivername,
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
      vehicleNumber) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 600,
                  height: 550,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(profileurl),
                                            fit: BoxFit.cover)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.account_box_outlined,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "Driver Name: $drivername",
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Text(
                                  "Driver Details",
                                  style: TextStyle(color: Colors.black38),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                color: Colors.grey[200],
                                child: ListTile(
                                  title: const Text(
                                    "Phone Number",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  subtitle: Text(phonenumber,
                                      style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15, top: 5),
                              child: Container(
                                color: Colors.grey[200],
                                child: ListTile(
                                  title: const Text(
                                    "Phone Number",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  subtitle: Text(email,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Text(
                                  "Contact Details",
                                  style: TextStyle(color: Colors.black38),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                color: Colors.grey[200],
                                child: ListTile(
                                  title: const Text(
                                    "Emergency Contact",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  subtitle: Text(contact1,
                                      style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15, top: 5),
                              child: Container(
                                color: Colors.grey[200],
                                child: ListTile(
                                  title: const Text(
                                    "Help Contact",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  subtitle: Text(contacr2,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Documents Details",
                                  style: TextStyle(color: Colors.black38),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 5, top: 4),
                              child: Container(
                                color: Colors.grey[200],
                                child: const ListTile(
                                  title: Text("Cnic"),
                                  trailing: Icon(
                                    Icons.arrow_right,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 5, top: 4),
                              child: Container(
                                color: Colors.grey[200],
                                child: const ListTile(
                                  title: Text("License"),
                                  trailing: Icon(
                                    Icons.arrow_right,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Text(
                                  "Vehicle Details",
                                  style: TextStyle(color: Colors.black38),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15, top: 5),
                              child: Container(
                                color: Colors.grey[200],
                                child: ListTile(
                                  title: const Text(
                                    "Vehicle Type",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  subtitle: Text(vehictype,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15, top: 5),
                              child: Container(
                                color: Colors.grey[200],
                                child: ListTile(
                                  title: const Text(
                                    "Vehicle Model",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  subtitle: Text("$vehicleColor-$vehiclemodel",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15, top: 5),
                              child: Container(
                                color: Colors.grey[200],
                                child: ListTile(
                                  title: const Text(
                                    "Vehicle Number ",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  subtitle: Text(vehicleNumber,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            rejectstatus == "false"
                                ? SizedBox(
                                    width: 200,
                                    child: MaterialButton(
                                      onPressed: () {
                                        userRef
                                            .child(id)
                                            .child('isApprove')
                                            .set("true");
                                        sendPushMessage(
                                            "your request got accepted , go ahead",
                                            "congratulation",
                                            token);
                                        Navigator.pop(context);
                                      },
                                      color: Colors.green,
                                      child: const Text(
                                        "Approve",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 5,
                            ),
                            rejectstatus == "false"
                                ? SizedBox(
                                    width: 200,
                                    child: MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: ((BuildContext context) {
                                              TextEditingController controller =
                                                  TextEditingController();
                                              return AlertDialog(
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        userRef
                                                            .child(id)
                                                            .child('isreject')
                                                            .set("true");
                                                        userRef
                                                            .child(id)
                                                            .child(
                                                                'rejectionmessage')
                                                            .set(controller
                                                                .text);
                                                        sendPushMessage(
                                                            "your request got rejected - ${controller.text}",
                                                            "Failed",
                                                            token);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Send"))
                                                ],
                                                title: const Text(
                                                    "Rejection Message:"),
                                                content: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all()),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextField(
                                                      controller: controller,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "Message"),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }));
                                      },
                                      color: Colors.red,
                                      child: const Text(
                                        "Reject",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 200,
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: Colors.red,
                                      child: const Text(
                                        "Rejected",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 200,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: kPrimaryColor,
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  loadpicture(String? url) {
    return Image.network(
      url ??
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCmqSWdlFU8Z2oiMcidHb4ZkdSRm2nnaw32w&usqp=CAU",
      height: 200,
      fit: BoxFit.contain,
      frameBuilder: (_, image, loadingBuilder, __) {
        if (loadingBuilder == null) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return image;
      },
      loadingBuilder: (BuildContext context, Widget image,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return image;
        return SizedBox(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
  }

  //datatable rows list , can ganerate from api future lists
  List<DataRow> _createRows(List<dynamic> list) {
    return list
        .map((e) => DataRow(
                color: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  // Even rows will have a grey color.
                  if (list.indexOf(e) % 2 == 0) {
                    return Colors.transparent;
                  }
                  return Colors
                      .transparent; // Use default value for other states and odd rows.
                }),
                cells: [
                  DataCell(
                    Text(
                      e['fullname'].toString(),
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(Text(e['email'].toString(),
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(e['phone'].toString(),
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Row(
                    children: [
                      Responsive.isDesktop(context)
                          ? Container()
                          : e['isreject'] == 'false'
                              ? MaterialButton(
                                  onPressed: () {
                                    userRef
                                        .child(e['DriverId'].toString())
                                        .child('isApprove')
                                        .set("true");
                                    sendPushMessage(
                                        "your request got accepted , go ahead",
                                        "congratulation",
                                        e['token'].toString());
                                  },
                                  color: const Color(0xff28A745),
                                  child: const Text(
                                    "Approve",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(
                                  width: 80,
                                ),
                      const SizedBox(
                        width: 5,
                      ),
                      MaterialButton(
                        onPressed: () {
                          _showAlertDialog(
                            e["vehicle_details"]["profilePicture"].toString(),
                            e["DriverId"].toString(),
                            e["phone"].toString(),
                            e["fullname"].toString(),
                            e["email"].toString(),
                            e["vehicle_details"]["cnic"].toString(),
                            e["isreject"].toString(),
                            e["vehicle_details"]["license"].toString(),
                            e["vehicle_details"]["vehiclePicture"].toString(),
                            e["token"].toString(),
                            e["Contacts"]["EmergencyContactNumber"].toString(),
                            e["Contacts"]["contactNumber"].toString(),
                            e["vehicle_details"]["car_type"].toString(),
                            e["vehicle_details"]["car_model"].toString(),
                            e["vehicle_details"]["car_color"].toString(),
                            e["vehicle_details"]["vehicle_number"].toString(),
                          );
                        },
                        color: const Color.fromARGB(255, 201, 16, 3),
                        child: const Text("Info",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )),
                ]))
        .toList();
  }

  DataTable _createDataTable2(
      List<dynamic> list, BuildContext context, double wid) {
    return DataTable(
        headingRowHeight: 20,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => const Color(0xff414950),
        ),
        columnSpacing: Responsive.isDesktop2(context) ? 5 : 0,
        columns: recentridescolumn(wid),
        rows: recentridesRows(list));
  }

  List<DataColumn> _createColumns(double wid) {
    return [
      const DataColumn(
        label: SizedBox(
            child: Text('Name',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
      const DataColumn(
        label: SizedBox(
            child: Text('Email',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
      const DataColumn(
        label: SizedBox(
            child: Text('Phone',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
      DataColumn(
        label: SizedBox(
            width: wid * .1,
            child: const Text('Action',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    ];
  }

  DataTable _createDataTable(List<dynamic> list, double wid) {
    return DataTable(
        headingRowHeight: 20,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => const Color(0xff414950),
        ),
        columns: _createColumns(wid),
        rows: _createRows(list));
  }
}
