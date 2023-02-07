import 'dart:typed_data';

import 'package:adminweb/helpers/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pw;

class RidesPdfReport extends StatefulWidget {
  RidesPdfReport(
      {Key? key, required this.name, required this.date1, required this.date2})
      : super(key: key);
  String name;
  String date1;
  String date2;

  @override
  State<RidesPdfReport> createState() => _RidesPdfReportState();
}

class _RidesPdfReportState extends State<RidesPdfReport> {
  @override
  Widget build(BuildContext context) {
    final ridesRefrence = FirebaseDatabase.instance.ref("rideRequest");
    return Scaffold(
        backgroundColor: const Color(0xff414950),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('PDF Preview'),
        ),
        body: StreamBuilder(
            stream: ridesRefrence.onValue,
            builder: ((context, snapshot) {
              if (snapshot.hasError) {}
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<dynamic> storedocs = [];

              Map<String, dynamic>? map =
                  snapshot.data!.snapshot.value as dynamic;

              storedocs.clear();

              DateTime dt1 = DateFormat("yyyy-MM-dd").parse(widget.date1);
              DateTime dt2 = DateFormat("yyyy-MM-dd").parse(widget.date2);

              storedocs.add(map == null
                  ? []
                  : map.values
                      .where((e) => (dt1.compareTo(DateFormat("yyyy-MM-dd")
                                      .parse(DateTime.parse(e['created_at'])
                                          .toString())) <=
                                  0
                              //     //DateTime.parse(e.date!)) <= 0
                              &&
                              dt2.compareTo(DateFormat("yyyy-MM-dd").parse(
                                      DateTime.parse(e['created_at'])
                                          .toString())) >=
                                  0

                          // // DateTime.parse(e.date!)) >= 0
                          ))
                      .toList());
              return PdfPreview(
                build: (context) => makePdf(
                    storedocs[0], widget.name, widget.date1, widget.date2),
              );
            })));
  }
}

Future<Uint8List> makePdf(
    List<dynamic> invoice, String name, String date1, String date2) async {
  List<dynamic> endedrides = invoice
      .where((element) => element['status'].toString().trim() == "ended")
      .toList();
  final pdf = pw.Document(
      title: "Rides Report",
      author: name,
      creator: name,
      keywords: name,
      subject: name);
  pdf.addPage(
    pw.MultiPage(
      margin: pw.EdgeInsets.only(left: 4, right: 4),
      pageFormat: PdfPageFormat.a3,
      maxPages: 100,
      build: (pw.Context context) => [
        pw.Divider(thickness: 1),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
          child: pw.Text("Rides Report",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
        ),
        pw.Divider(thickness: 1),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
          child: pw.Text("Created By : $name",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
        ),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
            child: pw.Text("From : $date1",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
            child: pw.Text("To: $date2",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
          ),
        ]),
        pw.SizedBox(height: 10),
        pw.Table.fromTextArray(context: context, data: <List<dynamic>>[
          <String>[
            'Customer',
            'Phone',
            'Payment',
            'Type',
            'Fares',
            'Driver Name',
            'Phone',
            'Destination',
            'status'
          ],
          ...invoice
              .map((user) => [
                    user['rider_name'].toString(),
                    user['rider_phone'].toString(),
                    user['payment_method'].toString(),
                    user['ride_type'].toString(),
                    user['fares'].toString() == "null"
                        ? "0"
                        : user["fares"].toString(),
                    user['driver_name'].toString() == "null"
                        ? "---"
                        : user["driver_name"].toString(),
                    user['driver_phone'].toString() == "null"
                        ? "0"
                        : user["driver_phone"].toString(),
                    user['destination_address'].toString(),
                    user['status'].toString()
                  ])
              .toList()
        ]),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
            child: pw.Text("Total Rides : ${invoice.length}",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
            child: pw.Text("Total Completed Rides: ${endedrides.length}",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
          ),
        ]),
        pw.Divider(thickness: 1),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
          child: pw.Text(
              "Total Fares: ${invoice.fold(0, (previousValue, element) => previousValue += element['fares'].toString() == 'null' ? 0 : int.parse(double.parse(element['fares']).round().toString())).toString()}",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
        ),
      ],
    ),
  );

  return pdf.save();
}
