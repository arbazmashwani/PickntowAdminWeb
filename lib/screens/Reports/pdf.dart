import 'dart:typed_data';

import 'package:adminweb/helpers/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

class LedgerPdfPreviewPage extends StatefulWidget {
  LedgerPdfPreviewPage(
      {Key? key, required this.name, required this.date1, required this.date2})
      : super(key: key);
  String name;
  String date1;
  String date2;

  @override
  State<LedgerPdfPreviewPage> createState() => _LedgerPdfPreviewPageState();
}

class _LedgerPdfPreviewPageState extends State<LedgerPdfPreviewPage> {
  @override
  Widget build(BuildContext context) {
    final ridesRefrence = FirebaseDatabase.instance.ref("drivers");
    return Scaffold(
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
                                      .parse(DateTime.parse(e['createdAt'])
                                          .toString())) <=
                                  0
                              //     //DateTime.parse(e.date!)) <= 0
                              &&
                              dt2.compareTo(DateFormat("yyyy-MM-dd").parse(
                                      DateTime.parse(e['createdAt'])
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
  List<dynamic> standards = invoice
      .where((element) =>
          element['vehicle_details']['car_type'].toString().trim() ==
          "Standards")
      .toList();
  List<dynamic> heavey = invoice
      .where((element) =>
          element['vehicle_details']['car_type'].toString() == "Heavey")
      .toList();
  List<dynamic> sports = invoice
      .where((element) =>
          element['vehicle_details']['car_type'].toString() == "Sports")
      .toList();
  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a3,
      margin: const pw.EdgeInsets.only(left: 4, right: 4),
      maxPages: 100,
      build: (context) => [
        pw.Divider(thickness: 1),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
          child: pw.Text("Driver Report",
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
            'Name',
            'Phone',
            'Earn',
            'Tip %',
            'Model',
            'Type',
            'Vehicle N',
            'Emergency',
            'status'
          ],
          ...invoice
              .map((user) => [
                    user['fullname'].toString(),
                    user['phone'].toString(),
                    user['earnings'].toString() == "null"
                        ? "0"
                        : user['earnings'].toString(),
                    '60%',
                    user['vehicle_details']['car_model'].toString(),
                    user['vehicle_details']['car_type'].toString(),
                    user['vehicle_details']['vehicle_number'].toString(),
                    user['Contacts']['EmergencyContactNumber'].toString(),
                    user['isApprove'].toString() == 'true' ? 'Verified' : "-"
                  ])
              .toList()
        ]),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
            child: pw.Text("Total Drivers : ${invoice.length.toString()}",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
            child: pw.Text(
                "Total Fares : ${invoice.fold(0, (previousValue, element) => previousValue = element['earnings'].toString() == 'null' ? 0 : int.parse(double.parse(element['earnings']).round().toString())).toString()}",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
          ),
        ]),
        pw.Divider(thickness: 1),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
          child: pw.Text(
              "Total Standards Drivers : ${standards.length.toString()}",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
          child: pw.Text("Total Heavey Drivers : ${heavey.length.toString()}",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
          child: pw.Text("Total Sports Drivers : ${sports.length.toString()}",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
        ),
        pw.Divider(thickness: 1),
      ],
    ),
  );
  return pdf.save();
}
