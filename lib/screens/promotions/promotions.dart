import 'dart:typed_data';
import 'dart:ui';

import 'package:adminweb/screens/promotions/voucher.dart';
import 'package:adminweb/widgets/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:universal_html/html.dart';
import 'package:uuid/uuid.dart';

class PromotionsPage extends StatefulWidget {
  PromotionsPage({super.key, required this.adminName});
  String adminName;

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  final promotionRefrence = FirebaseDatabase.instance.ref("Promotions");
  final vouchersRefrence = FirebaseDatabase.instance.ref("Vouchers");
  final expiredvouchersRefrence = FirebaseDatabase.instance.ref("Vouchers");
  final pendingvouchersRefrence = FirebaseDatabase.instance.ref("Vouchers");
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController pictureUrl = TextEditingController();
  //vouchersControllers
  TextEditingController voucherTitleController = TextEditingController();
  TextEditingController voucherPriceController = TextEditingController();
  TextEditingController vouchersExpiryDatecontroller = TextEditingController();
  TextEditingController vouchersStartDatecontroller = TextEditingController();
  TextEditingController voucherCodeController = TextEditingController();
  TextEditingController RidesCountController = TextEditingController();
  TextEditingController RidesTypeController = TextEditingController();

  String urls = "";

  Uint8List? uploadedImage;
  Future<void> _startFilePicker() async {}

  String option1Text = "ok";
  uploadpicturestoFirebase(String title, uids) async {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        }));
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('Promotions');
    final String uidofpromotion = const Uuid().v1();
    Reference adminsRefrence = referenceDirImages.child(uids).child(title);
    try {
      //Store the license file
      await adminsRefrence.putData(uploadedImage!);
    } catch (error) {
      //Some error occurred
    }
    urls = await adminsRefrence.getDownloadURL();

    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343A40),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    MaterialButton(
                      color: Colors.green,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return StatefulBuilder(
                                  builder: (context, StateSetter setState) {
                                return AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          final String uuidPromotions =
                                              const Uuid().v1();
                                          uploadedImage != null
                                              ? await uploadpicturestoFirebase(
                                                  titlecontroller.text,
                                                  uuidPromotions)
                                              : null;
                                          Map promotionMapurl = {
                                            "Title":
                                                titlecontroller.text.toString(),
                                            "description": descriptioncontroller
                                                .text
                                                .toString(),
                                            "Imageurl":
                                                pictureUrl.text.toString(),
                                            "uid": uuidPromotions,
                                            "Createdon":
                                                DateTime.now().toString(),
                                            "CreatedBy":
                                                widget.adminName.toString(),
                                          };
                                          Map promotionMappicture = {
                                            "Title":
                                                titlecontroller.text.toString(),
                                            "description": descriptioncontroller
                                                .text
                                                .toString(),
                                            "Imageurl": urls,
                                            "uid": uuidPromotions,
                                            "Createdon":
                                                DateTime.now().toString(),
                                            "CreatedBy":
                                                widget.adminName.toString(),
                                          };

                                          uploadedImage != null
                                              ? await promotionRefrence
                                                  .child(uuidPromotions)
                                                  .set(promotionMappicture)
                                              : await promotionRefrence
                                                  .child(uuidPromotions)
                                                  .set(promotionMapurl);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Add New")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("cancel"))
                                  ],
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                            width: 500,
                                            height: 400,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      loginTextFields(
                                                          titlecontroller,
                                                          "Title",
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: const Icon(
                                                                  Icons.title)),
                                                          false),
                                                      loginTextFields(
                                                          descriptioncontroller,
                                                          "Description",
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: const Icon(
                                                                  Icons.title)),
                                                          false),
                                                      uploadedImage == null
                                                          ? loginTextFields(
                                                              pictureUrl,
                                                              "Picture Url",
                                                              IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .title)),
                                                              false)
                                                          : Container()
                                                    ],
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Column(
                                                  children: [
                                                    uploadedImage != null
                                                        ? IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                uploadedImage =
                                                                    null;
                                                                urls = "";
                                                              });
                                                            },
                                                            icon: const Icon(
                                                                Icons.cancel))
                                                        : Container(),
                                                    Container(
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(40.0),
                                                          child: uploadedImage ==
                                                                  null
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    FileUploadInputElement
                                                                        uploadInput =
                                                                        FileUploadInputElement();
                                                                    uploadInput
                                                                        .click();

                                                                    uploadInput
                                                                        .onChange
                                                                        .listen(
                                                                            (e) async {
                                                                      // read file content as dataURL
                                                                      final files =
                                                                          uploadInput
                                                                              .files;
                                                                      if (files!
                                                                              .length ==
                                                                          1) {
                                                                        final file =
                                                                            files[0];
                                                                        FileReader
                                                                            reader =
                                                                            FileReader();

                                                                        reader
                                                                            .onLoadEnd
                                                                            .listen((e) {
                                                                          setState(
                                                                              () {
                                                                            uploadedImage =
                                                                                reader.result as Uint8List?;
                                                                            option1Text =
                                                                                "done";
                                                                            MemoryImage
                                                                                memoryImage =
                                                                                MemoryImage(uploadedImage!);
                                                                          });
                                                                        });

                                                                        reader
                                                                            .onError
                                                                            .listen((fileEvent) {
                                                                          setState(
                                                                              () {
                                                                            option1Text =
                                                                                "Some Error occured while reading the file";
                                                                          });
                                                                        });

                                                                        reader.readAsArrayBuffer(
                                                                            file);
                                                                      }
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.black12)),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: const [
                                                                        Icon(
                                                                          Icons
                                                                              .upload_outlined,
                                                                          color:
                                                                              Colors.black12,
                                                                        ),
                                                                        Text(
                                                                          "Upload Picture",
                                                                          style:
                                                                              TextStyle(color: Colors.black38),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    FileUploadInputElement
                                                                        uploadInput =
                                                                        FileUploadInputElement();
                                                                    uploadInput
                                                                        .click();

                                                                    uploadInput
                                                                        .onChange
                                                                        .listen(
                                                                            (e) async {
                                                                      // read file content as dataURL
                                                                      final files =
                                                                          uploadInput
                                                                              .files;
                                                                      if (files!
                                                                              .length ==
                                                                          1) {
                                                                        final file =
                                                                            files[0];
                                                                        FileReader
                                                                            reader =
                                                                            FileReader();

                                                                        reader
                                                                            .onLoadEnd
                                                                            .listen((e) {
                                                                          setState(
                                                                              () {
                                                                            uploadedImage =
                                                                                reader.result as Uint8List?;
                                                                            option1Text =
                                                                                "done";
                                                                            MemoryImage
                                                                                memoryImage =
                                                                                MemoryImage(uploadedImage!);
                                                                          });
                                                                        });

                                                                        reader
                                                                            .onError
                                                                            .listen((fileEvent) {
                                                                          setState(
                                                                              () {
                                                                            option1Text =
                                                                                "Some Error occured while reading the file";
                                                                          });
                                                                        });

                                                                        reader.readAsArrayBuffer(
                                                                            file);
                                                                      }
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 200,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: MemoryImage(uploadedImage!))),
                                                                  ),
                                                                )),
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              });
                            }));
                      },
                      child: const Text(
                        "Add New Promotion",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      color: Colors.green,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return StatefulBuilder(
                                  builder: (context, StateSetter setState) {
                                return AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          String uuidVouchers =
                                              const Uuid().v1().toString();
                                          Map voucherMap = {
                                            "VoucherUid":
                                                uuidVouchers.toString(),
                                            "VoucherTitle":
                                                voucherTitleController.text,
                                            "VoucherCode": voucherCodeController
                                                .text
                                                .toUpperCase(),
                                            "VoucherCreateonDate":
                                                DateTime.now().toString(),
                                            "VoucherStartDate":
                                                DateTime.now().toString(),
                                            "VoucherExpiryDate":
                                                DateTime.now().toString(),
                                            "VouchersPrice":
                                                voucherPriceController.text,
                                            "CreatedBy":
                                                widget.adminName.toString(),
                                            "RidesCount": RidesCountController
                                                .text
                                                .toString(),
                                            "RidesType":
                                                RidesTypeController.text,
                                          };
                                          await vouchersRefrence
                                              .child(uuidVouchers)
                                              .set(voucherMap);

                                          Navigator.pop(context);
                                        },
                                        child: const Text("Add New")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("cancel"))
                                  ],
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                            width: 500,
                                            height: 600,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        loginTextFields(
                                                            voucherTitleController,
                                                            "Title",
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .title)),
                                                            false),
                                                        loginTextFields(
                                                            voucherPriceController,
                                                            "Price",
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .title)),
                                                            false),
                                                        loginTextFields(
                                                            voucherCodeController,
                                                            "Voucher Code",
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .title)),
                                                            false),
                                                        loginTextFields(
                                                            vouchersStartDatecontroller,
                                                            "Start Date",
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .title)),
                                                            false),
                                                        loginTextFields(
                                                            vouchersExpiryDatecontroller,
                                                            "Expiry Date",
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .title)),
                                                            false),
                                                        loginTextFields(
                                                            RidesCountController,
                                                            "Rides",
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .title)),
                                                            false),
                                                        loginTextFields(
                                                            RidesTypeController,
                                                            "Rides Type",
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .title)),
                                                            false),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              });
                            }));
                      },
                      child: const Text(
                        "Add New Vouchers",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                  height: 300,
                  child: StreamBuilder(
                      stream: promotionRefrence.onValue,
                      builder: ((BuildContext context, AsyncSnapshot snapshot) {
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
                        return storedocs[0].length == 0
                            ? Container(
                                child: const Center(
                                  child: Text(
                                    "No Pomotions Yet",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : ScrollConfiguration(
                                behavior: MyCustomScrollBehavior(),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: storedocs[0].length,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onLongPress: () {
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () async {
                                                            await promotionRefrence
                                                                .child(storedocs[
                                                                            0]
                                                                        [index]
                                                                    ["uid"])
                                                                .remove();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ))
                                                    ],
                                                    title: Text(storedocs[0]
                                                        [index]["Title"]),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Card(
                                                          elevation: 5,
                                                          child: ListTile(
                                                            title: const Text(
                                                                "Creation Date"),
                                                            subtitle: Text(
                                                                storedocs[0]
                                                                        [index][
                                                                    "Createdon"]),
                                                          ),
                                                        ),
                                                        Card(
                                                          elevation: 5,
                                                          child: ListTile(
                                                            title: const Text(
                                                                "Creation By"),
                                                            subtitle: Text(
                                                                storedocs[0]
                                                                        [index][
                                                                    "CreatedBy"]),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }));
                                          },
                                          child: SizedBox(
                                              width: 250,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(0.0),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              1.5,
                                                          child: Image.network(
                                                            storedocs[0][index]
                                                                ["Imageurl"],
                                                            fit: BoxFit.fill,
                                                            width: 1000.0,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 0.0,
                                                          left: 0.0,
                                                          right: 0.0,
                                                          child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color
                                                                        .fromARGB(
                                                                            200,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    Color
                                                                        .fromARGB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0)
                                                                  ],
                                                                  begin: Alignment
                                                                      .bottomCenter,
                                                                  end: Alignment
                                                                      .topCenter,
                                                                ),
                                                              ),
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0,
                                                                  horizontal:
                                                                      20.0),
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    storedocs[0]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "Title"],
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          40.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    storedocs[0]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "description"],
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                      ],
                                                    )),
                                              )),
                                        ),
                                      );
                                    })),
                              );
                      }))),

              //vouchers
              SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Text("Vouchers",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22)),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 160,
                        child: StreamBuilder(
                            stream: vouchersRefrence.onValue,
                            builder: ((BuildContext context,
                                AsyncSnapshot snapshot) {
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
                              DateTime dt2 = DateFormat("yyyy-MM-dd")
                                  .parse(DateTime.now().toString());

                              storedocs.add(map == null
                                  ? []
                                  : map.values
                                      .where((e) =>
                                          (dt2.compareTo(DateFormat("yyyy-MM-dd")
                                                      .parse(
                                                          DateTime.parse(e['VoucherExpiryDate'])
                                                              .toString())) <=
                                                  0 &&
                                              dt2.compareTo(DateFormat("yyyy-MM-dd")
                                                      .parse(DateTime.parse(e['VoucherStartDate']).toString())) >=
                                                  0

                                          // // DateTime.parse(e.date!)) >= 0
                                          ))
                                      .toList());
                              return storedocs[0].length == 0
                                  ? Container(
                                      child: const Center(
                                        child: Text(
                                          "No Vouchers",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : ScrollConfiguration(
                                      behavior: MyCustomScrollBehavior(),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: storedocs[0].length,
                                          itemBuilder: ((context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onLongPress: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return AlertDialog(
                                                          actions: [
                                                            TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  await vouchersRefrence
                                                                      .child(storedocs[0]
                                                                              [
                                                                              index]
                                                                          [
                                                                          "VoucherUid"])
                                                                      .remove();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "Delete",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ))
                                                          ],
                                                          title: Text(storedocs[
                                                                  0][index]
                                                              ["VoucherTitle"]),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Card(
                                                                elevation: 5,
                                                                child: ListTile(
                                                                  title: const Text(
                                                                      "Creation Date"),
                                                                  subtitle: Text(
                                                                      storedocs[0]
                                                                              [
                                                                              index]
                                                                          [
                                                                          "VoucherCreateonDate"]),
                                                                ),
                                                              ),
                                                              Card(
                                                                elevation: 5,
                                                                child: ListTile(
                                                                  title: const Text(
                                                                      "Creation By"),
                                                                  subtitle: Text(
                                                                      storedocs[0]
                                                                              [
                                                                              index]
                                                                          [
                                                                          "CreatedBy"]),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }));
                                                },
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 300,
                                                  child:
                                                      HorizontalCouponExample1(
                                                    code: storedocs[0][index]
                                                        ["VoucherCode"],
                                                    expirydate: storedocs[0]
                                                            [index]
                                                        ["VoucherExpiryDate"],
                                                    title: storedocs[0][index]
                                                        ["VoucherTitle"],
                                                    price: storedocs[0][index]
                                                        ["VouchersPrice"],
                                                  ),
                                                ),
                                              ),
                                            );
                                          })),
                                    );
                            })))
                  ],
                ),
              ),

              //expiredvouchers
              SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Text("Expired Vouchers",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22)),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 160,
                        child: StreamBuilder(
                            stream: expiredvouchersRefrence.onValue,
                            builder: ((BuildContext context,
                                AsyncSnapshot snapshot) {
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
                              DateTime dt2 = DateFormat("yyyy-MM-dd")
                                  .parse(DateTime.now().toString());
                              DateTime dt1 =
                                  DateFormat("yyyy-MM-dd").parse("2023-01-01");

                              storedocs.add(map == null
                                  ? []
                                  : map.values
                                      .where((e) => (dt2.compareTo(DateFormat(
                                                      "yyyy-MM-dd")
                                                  .parse(DateTime.parse(e[
                                                          'VoucherExpiryDate'])
                                                      .add(const Duration(
                                                          days: 1))
                                                      .toString())) >=
                                              0

                                          // // DateTime.parse(e.date!)) >= 0
                                          ))
                                      .toList());
                              return storedocs[0].length == 0
                                  ? Container(
                                      child: const Center(
                                        child: Text(
                                          "No Expired Vouchers",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : ScrollConfiguration(
                                      behavior: MyCustomScrollBehavior(),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: storedocs[0].length,
                                          itemBuilder: ((context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 50,
                                                width: 300,
                                                child: HorizontalCouponExample1(
                                                  code: storedocs[0][index]
                                                      ["VoucherCode"],
                                                  expirydate: storedocs[0]
                                                          [index]
                                                      ["VoucherExpiryDate"],
                                                  title: storedocs[0][index]
                                                      ["VoucherTitle"],
                                                  price: storedocs[0][index]
                                                      ["VouchersPrice"],
                                                ),
                                              ),
                                            );
                                          })),
                                    );
                            })))
                  ],
                ),
              ),

              //pending Vouchers
              SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Text("Pending Vouchers",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22)),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 160,
                        child: StreamBuilder(
                            stream: pendingvouchersRefrence.onValue,
                            builder: ((BuildContext context,
                                AsyncSnapshot snapshot) {
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
                              DateTime dt2 = DateFormat("yyyy-MM-dd")
                                  .parse(DateTime.now().toString());

                              storedocs.add(map == null
                                  ? []
                                  : map.values
                                      .where((e) => (dt2.compareTo(DateFormat(
                                                      "yyyy-MM-dd")
                                                  .parse(DateTime.parse(
                                                          e['VoucherStartDate'])
                                                      .toString())) <
                                              0
                                          //     //DateTime.parse(e.date!)) <= 0

                                          // // DateTime.parse(e.date!)) >= 0
                                          ))
                                      .toList());
                              return storedocs[0].length == 0
                                  ? Container(
                                      child: const Center(
                                        child: Text(
                                          "No Pending Vouchers",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : ScrollConfiguration(
                                      behavior: MyCustomScrollBehavior(),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: storedocs[0].length,
                                          itemBuilder: ((context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 50,
                                                width: 300,
                                                child: HorizontalCouponExample1(
                                                  code: storedocs[0][index]
                                                      ["VoucherCode"],
                                                  expirydate: storedocs[0]
                                                          [index]
                                                      ["VoucherExpiryDate"],
                                                  title: storedocs[0][index]
                                                      ["VoucherTitle"],
                                                  price: storedocs[0][index]
                                                      ["VouchersPrice"],
                                                ),
                                              ),
                                            );
                                          })),
                                    );
                            })))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

// ScrollBehavior can be set for a specific widget.
final ScrollController controller = ScrollController();
