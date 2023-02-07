import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/responsive.dart';
import 'package:adminweb/widgets/containers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

textwidget(String text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontSize: Responsive.isMobile(context) &&
                  MediaQuery.of(context).size.width < 721
              ? 10
              : 17,
          fontWeight: FontWeight.bold),
    ),
  );
}

textwidget2(String text) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
    ),
  );
}

streamBuilderMethod(
    Stream stream, String name, IconData iconData, Color color) {
  return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return totalinfoContainer("error", name, iconData, color, context);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return totalinfoContainer("0", name, iconData, color, context);
        }

        final List<dynamic> storedocs = [];

        Map<String, dynamic>? map = snapshot.data.snapshot.value as dynamic;

        storedocs.clear();

        storedocs.add(map == null ? [] : map.values.toList());

        return totalinfoContainer(
            // ignore: unnecessary_null_comparison
            storedocs == null ? "0" : storedocs[0].length.toString(),
            name,
            iconData,
            color,
            context);
      });
}

//datatable head list
List<DataColumn> _createColumns(double wid) {
  return [
    const DataColumn(
      label: SizedBox(
          child: Text('Name',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    ),
    const DataColumn(
      label: SizedBox(
          child: Text('Email',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    ),
    const DataColumn(
      label: SizedBox(
          child: Text('Phone',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    ),
    DataColumn(
      label: SizedBox(
          width: wid * .1,
          child: const Text('Action',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    ),
  ];
}

List<DataColumn> recentridescolumn(double wid) {
  return [
    DataColumn(
      label: SizedBox(
        width: wid * .1,
        child: const Text(
          'customer',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    DataColumn(
      label: SizedBox(
        width: wid * .1,
        child: const Text(
          'Type',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    DataColumn(
      label: SizedBox(
        width: wid * .1,
        child: const Text(
          'pay',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    DataColumn(
      label: SizedBox(
        width: wid * .1,
        child: const Text(
          'status',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    DataColumn(
      label: SizedBox(
        width: wid * .1,
        child: const Text(
          'D name',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    DataColumn(
      label: SizedBox(
        width: wid * .1,
        child: const Text(
          'Destination',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  ];
}

List<DataRow> recentridesRows(List<dynamic> list) {
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
                DataCell(Text(e['rider_name'].toString(),
                    style: const TextStyle(color: Colors.white))),
                DataCell(Text(e['ride_type'].toString(),
                    style: const TextStyle(color: Colors.white))),
                DataCell(Text(e['payment_method'].toString(),
                    style: const TextStyle(color: Colors.white))),
                DataCell(e['status'].toString() == "ended"
                    ? conatinerwid(e['status'].toString(), Colors.blue)
                    : e['status'].toString() == "waiting"
                        ? conatinerwid(e['status'].toString(), Colors.red)
                        : conatinerwid(e['status'].toString(), Colors.green)),
                DataCell(Text(
                    e['driver_name'].toString() == "null"
                        ? "-"
                        : e['driver_name'].toString(),
                    style: const TextStyle(color: Colors.white))),
                DataCell(Text(e['destination_address'].toString(),
                    style: const TextStyle(color: Colors.white))),
              ]))
      .toList();
}

conatinerwid(String text, Color color) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // <-- Radius
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

conatinerwidfunction(String text, Color color, void Function() function) {
  return ElevatedButton(
    onPressed: function,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // <-- Radius
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

vehiclecontainer(String text, tite, IconData iconData) {
  return Container(
    color: kPrimaryColor,
    child: Center(
      child: ListTile(
        trailing: Text(
          text,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        title: Text(
          tite,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          "Total Drivers",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

vehiclecontainer2(String text, tite) {
  return Container(
    color: kPrimaryColor,
    child: Center(
      child: ListTile(
        trailing: Text(
          text,
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        title: Text(
          tite,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

streamBuilderMethod2(
    Stream stream, String text, String tittle, IconData iconData) {
  return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<dynamic> storedocs = [];

        Map<String, dynamic>? map = snapshot.data.snapshot.value as dynamic;

        storedocs.clear();

        storedocs.add(map == null
            ? []
            : map.values
                .where((element) =>
                    element['vehicle_details']['car_type'].toString().trim() ==
                        text &&
                    element['vehicledetails'].toString().trim() == "true")
                .toList());

        return vehiclecontainer(
            storedocs[0].length.toString(), tittle, iconData);
      });
}

todayRidesRefrencestream(
    Stream stream, String text, String tittle, IconData iconData) {
  return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<dynamic> storedocs = [];

        Map<String, dynamic>? map = snapshot.data.snapshot.value as dynamic;

        storedocs.clear();

        storedocs.add(map == null
            ? []
            : text == "Today Rides"
                ? map.values
                    .where((element) =>
                        DateFormat("yyyy-MM-dd")
                            .parse(
                                DateTime.parse(element["created_at"].toString())
                                    .toString())
                            .toString() ==
                        DateFormat("yyyy-MM-dd")
                            .parse(DateTime.now().toString())
                            .toString())
                    .toList()
                : text == "Total Completed Rides"
                    ? map.values
                        .where((element) =>
                            element["status"].toString().trim() == "ended")
                        .toList()
                    : text == "Last Month Rides"
                        ? map.values
                            .where((element) =>
                                element["status"].toString().trim() == "ended")
                            .toList()
                        : map.values.toList());

        return text == "Total Rides Fares"
            ? vehiclecontainer2(
                storedocs[0]
                    .fold(
                        0,
                        (previousValue, element) => previousValue +=
                            element['fares'].toString() == 'null'
                                ? 0
                                : int.parse(double.parse(element['fares'])
                                    .round()
                                    .toString()))
                    .toString(),
                text)
            : vehiclecontainer2(storedocs[0].length.toString(), text);
      });
}

driverstatsstream(Stream stream, String title, BuildContext context) {
  return StreamBuilder(
      stream: stream,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<dynamic> storedocs = [];

        Map<String, dynamic>? map = snapshot.data.snapshot.value as dynamic;

        storedocs.clear();

        storedocs.add(map == null
            ? []
            : title == "Waiting For Approval"
                ? map.values
                    .where((element) => element["IsSuspended"] == "false")
                    .toList()
                : map.values.toList());
        return Column(
          children: [
            textwidget(storedocs[0].length.toString(), context),
            textwidget(title, context)
          ],
        );
      }));
}
