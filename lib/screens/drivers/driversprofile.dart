import 'package:adminweb/screens/login/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

driverprofilepage(
    BuildContext context,
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
    vehicleNumber,
    List<dynamic> listdeposits) {
  Widget _dialog(BuildContext context, String text, String url) {
    return AlertDialog(
      title: Text(text),
      content: Container(
        height: 400,
        width: 400,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Okay"))
      ],
    );
  }

  void _scaleDialog(String text, String url) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: _dialog(ctx, text, url),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  return showDialog<void>(
    context: context,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 800,
                height: 600,
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
                                      "$drivername - 0001 - Active",
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
                                    style: TextStyle(
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
                                    style: TextStyle(
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
                                "Other Details",
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
                                  "Registration Date",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                subtitle: Text(phonenumber,
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              color: Colors.grey[200],
                              child: ListTile(
                                title: const Text(
                                  "Languages",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                subtitle: Text(phonenumber,
                                    style: TextStyle(
                                        color: kPrimaryColor,
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
                                "Documents Details",
                                style: TextStyle(color: Colors.black38),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15, left: 5, top: 4),
                            child: GestureDetector(
                              onTap: () {
                                _scaleDialog("Cnic", cnicPic);
                              },
                              child: Container(
                                color: Colors.grey[200],
                                child: const ListTile(
                                  title: Text(
                                    "Cnic",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15, left: 5, top: 4),
                            child: GestureDetector(
                              onTap: () {
                                _scaleDialog("License", licenesepic);
                              },
                              child: Container(
                                color: Colors.grey[200],
                                child: const ListTile(
                                  title: Text("License",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  trailing: Icon(
                                    Icons.arrow_right,
                                  ),
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
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Rides/Fares Details",
                                style: TextStyle(color: Colors.black38),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15, left: 5, top: 4),
                            child: Container(
                              color: Colors.grey[200],
                              child: const ListTile(
                                  title: Text("No Of Rides",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  trailing: Text("10",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15, left: 5, top: 4),
                            child: Container(
                              color: Colors.grey[200],
                              child: ListTile(
                                  title: const Text("Total Deposit",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  trailing: Text(
                                      listdeposits
                                          .fold(
                                              0,
                                              (previousValue, element) =>
                                                  previousValue += element['Amount']
                                                              .toString() ==
                                                          'null'
                                                      ? 0
                                                      : int.parse(double.parse(
                                                              element['Amount'])
                                                          .toString()))
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15, left: 5, top: 4),
                            child: Container(
                              color: Colors.grey[200],
                              child: const ListTile(
                                  title: Text("Rides Fares",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  trailing: Text("10",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              color: Colors.grey[200],
                              child: ListTile(
                                trailing: const Text(
                                  "60%",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                title: const Text(
                                  "Driver Share",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                subtitle: Text("673800",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              color: Colors.grey[200],
                              child: ListTile(
                                trailing: const Text(
                                  "40%",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                title: const Text(
                                  "Company Share",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                subtitle: Text("6283967093",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          CreditCardWidget(
                            isSwipeGestureEnabled: true,
                            isHolderNameVisible: false,
                            cardNumber: "",
                            expiryDate: "12-01-2002",
                            cardHolderName: "cardHolderName",
                            cvvCode: "23",
                            showBackView: false,
                            cardBgColor: Colors.black,
                            obscureCardNumber: true,
                            obscureCardCvv: false,
                            height: 175,
                            textStyle:
                                const TextStyle(color: Colors.yellowAccent),
                            width: MediaQuery.of(context).size.width,
                            animationDuration:
                                const Duration(milliseconds: 1000),
                            onCreditCardWidgetChange: (creditCardBrand) {},
                          ),
                        ],
                      ),
                    ))
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
