import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/responsive.dart';
import 'package:adminweb/screens/Reports/pdf.dart';
import 'package:adminweb/screens/Reports/ridesreports.dart';
import 'package:adminweb/screens/homescreen/homescreen.dart';
import 'package:adminweb/screens/homescreen/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({super.key, required this.name});
  String name;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ridesRefrence = FirebaseDatabase.instance.ref("Reports");

  String searchText = '';
  String ReportType = '';
  List options = ["Rides Reports", "Drivers Reports", "Customer Reports"];
  List<bool> _selected = List.generate(3, (i) => false);
  TextEditingController datecontroller = TextEditingController();
  TextEditingController datecontroller2 = TextEditingController();

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
                : conatinerwidfunction("Add New Report", Colors.green, () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return StatefulBuilder(builder: ((context, setState) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 300,
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "From",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        TextField(
                                          readOnly: true,
                                          controller: datecontroller,
                                          onTap: () async {
                                            DateTime? showdate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(3000));

                                            if (showdate != null) {
                                              setState(() {
                                                datecontroller.text =
                                                    DateFormat("yyyy-MM-dd")
                                                        .format(showdate);
                                              });
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
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        TextField(
                                          readOnly: true,
                                          controller: datecontroller2,
                                          onTap: () async {
                                            DateTime? showdate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(3000));

                                            if (showdate != null) {
                                              setState(() {
                                                datecontroller2.text =
                                                    DateFormat("yyyy-MM-dd")
                                                        .format(showdate);
                                              });
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 40 *
                                              double.parse(
                                                  options.length.toString()),
                                          child: ListView.builder(
                                              itemCount: options.length,
                                              itemBuilder: ((context, index) {
                                                return Row(
                                                  children: [
                                                    Checkbox(
                                                        value: _selected[index],
                                                        onChanged: (d) {
                                                          setState(() {
                                                            ReportType =
                                                                options[index]
                                                                    .toString();
                                                            _selected =
                                                                List.filled(
                                                                    _selected
                                                                        .length,
                                                                    false,
                                                                    growable:
                                                                        true);
                                                            _selected[index] =
                                                                !_selected[
                                                                    index];
                                                          });
                                                        }),
                                                    Text(options[index])
                                                  ],
                                                );
                                              })),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              actions: [
                                conatinerwidfunction("ADD", Colors.green, () {
                                  String randommessageid =
                                      const Uuid().v1().toString();
                                  String adminid = "1";
                                  Map reportmap = {
                                    "Admin": widget.name,
                                    "FROM": datecontroller.text.toString(),
                                    "TO": datecontroller2.text.toString(),
                                    "TYPE": ReportType,
                                    "Time": DateTime.now().toString()
                                  };
                                  ridesRefrence
                                      .child(randommessageid)
                                      .set(reportmap)
                                      .catchError((error) {
                                    return error.toString();
                                  });
                                  _selected = List.filled(
                                      _selected.length, false,
                                      growable: true);
                                  Navigator.pop(context);
                                }),
                                conatinerwidfunction(
                                    "Cancel", Colors.red, () {})
                              ],
                            );
                          }));
                        }));
                  })
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
                    labelText: 'Search Report',
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
                Responsive.isMobile(context)
                    ? Container(
                        color: const Color(0xff343A40),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              conatinerwidfunction(
                                  "Add New Report", Colors.green, () {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return StatefulBuilder(
                                          builder: ((context, setState) {
                                        return AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: 300,
                                                width: 300,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: const [
                                                        Text(
                                                          "From",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                    TextField(
                                                      readOnly: true,
                                                      controller:
                                                          datecontroller,
                                                      onTap: () async {
                                                        DateTime? showdate =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        2000),
                                                                lastDate:
                                                                    DateTime(
                                                                        3000));

                                                        if (showdate != null) {
                                                          setState(() {
                                                            datecontroller
                                                                .text = DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .format(
                                                                    showdate);
                                                          });
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
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                    TextField(
                                                      readOnly: true,
                                                      controller:
                                                          datecontroller2,
                                                      onTap: () async {
                                                        DateTime? showdate =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        2000),
                                                                lastDate:
                                                                    DateTime(
                                                                        3000));

                                                        if (showdate != null) {
                                                          setState(() {
                                                            datecontroller2
                                                                .text = DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .format(
                                                                    showdate);
                                                          });
                                                        }
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 40 *
                                                          double.parse(options
                                                              .length
                                                              .toString()),
                                                      child: ListView.builder(
                                                          itemCount:
                                                              options.length,
                                                          itemBuilder:
                                                              ((context,
                                                                  index) {
                                                            return Row(
                                                              children: [
                                                                Checkbox(
                                                                    value: _selected[
                                                                        index],
                                                                    onChanged:
                                                                        (d) {
                                                                      setState(
                                                                          () {
                                                                        ReportType =
                                                                            options[index].toString();
                                                                        _selected = List.filled(
                                                                            _selected
                                                                                .length,
                                                                            false,
                                                                            growable:
                                                                                true);
                                                                        _selected[index] =
                                                                            !_selected[index];
                                                                      });
                                                                    }),
                                                                Text(options[
                                                                    index])
                                                              ],
                                                            );
                                                          })),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          actions: [
                                            conatinerwidfunction(
                                                "ADD", Colors.green, () {
                                              String randommessageid =
                                                  const Uuid().v1().toString();
                                              String adminid = "1";
                                              Map reportmap = {
                                                "Admin": widget.name,
                                                "FROM": datecontroller.text
                                                    .toString(),
                                                "TO": datecontroller2.text
                                                    .toString(),
                                                "TYPE": ReportType,
                                                "Time":
                                                    DateTime.now().toString()
                                              };
                                              ridesRefrence
                                                  .child(randommessageid)
                                                  .set(reportmap)
                                                  .catchError((error) {
                                                return error.toString();
                                              });
                                              _selected = List.filled(
                                                  _selected.length, false,
                                                  growable: true);
                                              Navigator.pop(context);
                                            }),
                                            conatinerwidfunction(
                                                "Cancel", Colors.red, () {})
                                          ],
                                        );
                                      }));
                                    }));
                              })
                            ],
                          ),
                        ),
                      )
                    : Container(),
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
                              columns: const [
                                DataColumn(
                                    label: Text(
                                  'Created By',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'From',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'To',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Type',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Action',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                              columnSpacing: 140,
                              headingRowHeight: 40,
                              horizontalMargin: 10,
                              dataRowHeight: 60,
                              rowsPerPage: Responsive.isMobile(context) ? 6 : 7,
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
  String update;
  late List<dynamic> filter = khan
      .where((element) => (element["Admin"]
              .toString()
              .toLowerCase()
              .trim()
              .contains(update.toLowerCase()) ||
          element["TYPE"]
              .toString()
              .toLowerCase()
              .trim()
              .contains(update.toLowerCase())))
      .toList();

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => filter.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    widgetcalling() {
      if (filter[index]['TYPE'].toString()[0] == 'D') {
        return conatinerwid(filter[index]['TYPE'], Colors.green);
      } else if (filter[index]['TYPE'].toString()[0] == 'R') {
        return conatinerwid(filter[index]['TYPE'], Colors.blue);
      } else if (filter[index]['TYPE'].toString()[0] == 'C') {
        return conatinerwid(
            filter[index]['TYPE'], const Color.fromARGB(255, 158, 15, 50));
      }
    }

    pagecalling() {
      if (filter[index]['TYPE'].toString()[0] == 'D') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LedgerPdfPreviewPage(
                name: filter[index]['Admin'],
                date1: filter[index]['FROM'],
                date2: filter[index]['TO']),
          ),
        );
      } else if (filter[index]['TYPE'].toString()[0] == 'R') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RidesPdfReport(
                name: filter[index]['Admin'],
                date1: filter[index]['FROM'],
                date2: filter[index]['TO']),
          ),
        );
      } else if (filter[index]['TYPE'].toString()[0] == 'C') {
        return conatinerwid(
            filter[index]['TYPE'], const Color.fromARGB(255, 158, 15, 50));
      }
    }

    return DataRow(cells: [
      DataCell(
        Text(
          filter[index]['Admin'].toString(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      DataCell(Text(
          DateFormat('MMMM-dd-yyyy')
              .format(DateTime.parse(filter[index]['FROM'])),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold))),
      DataCell(Text(
          DateFormat('MMMM-dd-yyyy')
              .format(DateTime.parse(filter[index]['TO'])),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold))),
      DataCell(widgetcalling()),
      DataCell(Row(
        children: [
          IconButton(
            onPressed: () {
              pagecalling();
            },
            icon: const Icon(
              Icons.print,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      )),
    ]);
  }
}
