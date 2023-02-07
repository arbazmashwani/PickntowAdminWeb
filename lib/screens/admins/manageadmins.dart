import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/responsive.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ManageadminsPage extends StatefulWidget {
  const ManageadminsPage({super.key});

  @override
  State<ManageadminsPage> createState() => _ManageadminsPageState();
}

class _ManageadminsPageState extends State<ManageadminsPage> {
  final AdminsRefrencess = FirebaseDatabase.instance.ref("Admins");
  final AdminsRefrencessStream = FirebaseDatabase.instance.ref("Admins");
  String errormessage = "";
  String driverkey = "";
  String adminname = "";
  bool permissionscreen = false;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff343A40),
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Users',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  MaterialButton(
                    onPressed: () {
                      showaddadmindialog();
                    },
                    color: const Color.fromARGB(255, 170, 30, 5),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Responsive.isMobile(context)
                  ? Container()
                  : driverkey.isEmpty
                      ? Container()
                      : Text(
                          'Customize Permission:   ${adminname}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
            ],
          )),
      body: Container(
        child: Row(
          children: [
            permissionscreen == false
                ? Expanded(
                    child: StreamBuilder(
                        stream: AdminsRefrencessStream.onValue,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {}
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final List<dynamic> storedocs = [];

                          Map<String, dynamic>? map =
                              snapshot.data.snapshot.value as dynamic;

                          storedocs.clear();

                          storedocs.add(map == null ? [] : map.values.toList());

                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: const Color(0xff343A40),
                                  width: width,
                                  child: _createDataTable(storedocs[0], width),
                                ),
                              ],
                            ),
                          );
                        }))
                : Expanded(
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: driverkey.isEmpty
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: kPrimaryColor,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [
                                        Responsive.isMobile(context)
                                            ? driverkey.isEmpty
                                                ? Container()
                                                : Text(
                                                    'Customize Permission:   ${adminname}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22),
                                                  )
                                            : Container(),
                                        Text(
                                          "Dahboard",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {}))
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                  //
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [textwidget("Drivers")],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        textwidget("V"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("R"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("E"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("D"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("S"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {}))
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                  //
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [textwidget("Customers")],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        textwidget("V"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("R"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("E"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("D"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [textwidget("Reports")],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        textwidget("V"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("C"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("D"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("P"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {}))
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [textwidget("Admins Manage")],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        textwidget("V"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("M"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("E"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("D"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [textwidget("Company")],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        textwidget("V"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("R"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("E"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("D"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {})),
                                        textwidget("S"),
                                        Checkbox(
                                            value: true,
                                            onChanged: ((value) {}))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ))
          ],
        ),
      ),
    );
  }

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
                  DataCell(ListTile(
                    title: Text(
                      e['Name'].toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      "Admin",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )),
                  DataCell(ListTile(
                    title: Text(
                      e['phone'].toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      e['email'],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
                  DataCell(Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              permissionscreen = true;
                              driverkey = e["id"];
                              adminname = e["Name"];
                            });
                          },
                          icon: const Icon(
                            Icons.view_agenda,
                            color: Colors.blue,
                          ))
                    ],
                  )),
                ]))
        .toList();
  }

  List<DataColumn> _createColumns(double wid) {
    return [
      const DataColumn(
        label: SizedBox(
            child: Text('User',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
      const DataColumn(
        label: SizedBox(
            child: Text('Contact',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
      const DataColumn(
        label: SizedBox(
            child: Text('Action',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    ];
  }

  DataTable _createDataTable(List<dynamic> list, double wid) {
    return DataTable(
        showCheckboxColumn: false,
        dataRowHeight: 60,
        headingRowHeight: 20,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => const Color(0xff414950),
        ),
        columns: _createColumns(wid),
        rows: _createRows(list));
  }

  showaddadmindialog() {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      errormessage = "";
                    });
                    if (usernamecontroller.text.isEmpty ||
                        emailcontroller.text.isEmpty ||
                        passwordcontroller.text.isEmpty ||
                        phonecontroller.text.isEmpty) {
                      setState(() {
                        errormessage = "Fields Are Empty";
                      });
                    } else {
                      if (passwordcontroller.text == confirmpassword.text) {
                        final String uid = const Uuid().v1().toString();
                        Map userMap = {
                          "id": uid.toString(),
                          "Name": usernamecontroller.text,
                          "phone": phonecontroller.text,
                          "email": emailcontroller.text,
                          "password": passwordcontroller.text,
                          "Role": "Admin"
                        };

                        AdminsRefrencess.child(uid).set(userMap);
                        setState(() {
                          driverkey = "";
                        });
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          errormessage = "password are not same";
                        });
                      }
                    }
                  },
                  child: const Text("ADD"))
            ],
            title: const Text("Register"),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  textfieldwidgetmaxlength(
                      usernamecontroller, "Username", (value) {}, 1, 1, false),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: textfieldwidgetmaxlength(
                            emailcontroller, "Emial", (value) {}, 1, 1, false),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: textfieldwidgetmaxlength(
                            phonecontroller, "Phone", (value) {}, 1, 1, false),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: textfieldwidgetmaxlength(passwordcontroller,
                            "Password", (value) {}, 1, 1, false),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: textfieldwidgetmaxlength(confirmpassword,
                            "Confirm Password", (value) {}, 1, 1, false),
                      ),
                    ],
                  ),
                  Text(
                    errormessage.isEmpty ? "" : errormessage,
                    style: const TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          );
        }));
  }

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
}

textfieldwidgetmaxlength(TextEditingController controller, String textlabel,
    void Function(value), int lines, int lines2, bool bools) {
  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: TextField(
      readOnly: bools,
      controller: controller,
      minLines: lines,
      maxLines: lines2,
      onChanged: Function,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 0.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        label: Text(textlabel),
        labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
      ),
    ),
  );
}

textwidget(String t) {
  return Text(
    t,
    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  );
}
