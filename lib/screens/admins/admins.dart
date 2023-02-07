import 'dart:html';
import 'dart:typed_data';

import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/responsive.dart';
import 'package:adminweb/screens/admins/manageadmins.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AdminsPage extends StatefulWidget {
  AdminsPage({super.key, required this.AdminUid});
  String AdminUid;

  @override
  State<AdminsPage> createState() => _AdminsPageState();
}

class _AdminsPageState extends State<AdminsPage> {
  final AdminsRefrencess = FirebaseDatabase.instance.ref("Admins");
  String name = "";
  String phone = "";
  String email = "";
  String role = "";
  String profileimageurl = '';

  @override
  void initState() {
    AdminsRefrencess.child(widget.AdminUid)
        .once()
        .then((DatabaseEvent databaseEvent) {
      if (databaseEvent.snapshot.value != null) {
        setState(() {
          name = databaseEvent.snapshot.child("Name").value.toString();
          phone = databaseEvent.snapshot.child("phone").value.toString();
          email = databaseEvent.snapshot.child("email").value.toString();
          role = databaseEvent.snapshot.child("Role").value.toString();
          profileimageurl =
              databaseEvent.snapshot.child("pictureurl").value.toString();
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }
  // variable to hold image to be displayed

  Uint8List? uploadedImage;
  String option1Text = "ok";

//method to load image and update `uploadedImage`

  Future<void> _startFilePicker() async {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files!.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result as Uint8List?;
            option1Text = "done";
            MemoryImage memoryImage = MemoryImage(uploadedImage!);

            memoryImage.bytes.isNotEmpty
                ? showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                uploadpicturestoFirebase();
                              },
                              child: const Text("save"))
                        ],
                        title: const Text("Change Profile Picture"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: MemoryImage(uploadedImage!),
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        ),
                      );
                    }))
                : null;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            option1Text = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  String licenseurl = "";

  uploadpicturestoFirebase() async {
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
    Reference referenceDirImages = referenceRoot.child('images');
    Reference adminsRefrence =
        referenceDirImages.child(name).child("ProfilePictureUrl");
    try {
      //Store the license file
      await adminsRefrence.putData(uploadedImage!);
    } catch (error) {
      //Some error occurred
    }
    licenseurl = await adminsRefrence.getDownloadURL();
    var k = AdminsRefrencess.child(widget.AdminUid)
        .child("pictureurl")
        .set(licenseurl);
    AdminsRefrencess.child(widget.AdminUid)
        .once()
        .then((DatabaseEvent databaseEvent) {
      if (databaseEvent.snapshot.value != null) {
        setState(() {
          name = databaseEvent.snapshot.child("Name").value.toString();
          phone = databaseEvent.snapshot.child("phone").value.toString();
          email = databaseEvent.snapshot.child("email").value.toString();
          role = databaseEvent.snapshot.child("Role").value.toString();
          profileimageurl =
              databaseEvent.snapshot.child("pictureurl").value.toString();
        });
      }
    });

    Navigator.pop(context);
    setState(() {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff343A40),
        appBar: AppBar(
          title: const Text(
            "Profile Setting",
            style: TextStyle(
                letterSpacing: 3,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: kPrimaryColor,
              ),
              child: name.isEmpty && profileimageurl.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Responsive.isMobile(context)
                                    ? Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    profileimageurl),
                                                fit: BoxFit.fill)),
                                      )
                                    : Container(),
                                nametile(name, Icons.person_pin, context),
                                nametile(email, Icons.email_rounded, context),
                                nametile(phone, Icons.phone_android_rounded,
                                    context),
                                nametile(role, Icons.room_outlined, context),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      showpassworddialog();
                                    },
                                    color: const Color(0xffE0A800),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.lock_open,
                                          size: 22,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Change Password',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    await _startFilePicker();
                                  },
                                  color: const Color(0xff138496),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.camera_alt,
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Change Picture',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                        Responsive.isMobile(context)
                            ? Container()
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: 400,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(profileimageurl),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                              )
                      ],
                    )),
        ));
  }

  TextEditingController oldpasswordcontroller = TextEditingController();
  TextEditingController newpasswordcontroller = TextEditingController();
  TextEditingController confirmnewpassword = TextEditingController();

  showpassworddialog() {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("Change Password"),
            actions: [
              TextButton(
                  onPressed: () {
                    AdminsRefrencess.child(widget.AdminUid)
                        .once()
                        .then((DatabaseEvent databaseEvent) {
                      if (databaseEvent.snapshot.value != null) {
                        if (oldpasswordcontroller.text.toString().trim() ==
                            databaseEvent.snapshot
                                .child("password")
                                .value
                                .toString()
                                .trim()) {
                          if (newpasswordcontroller.text ==
                              confirmnewpassword.text) {
                            AdminsRefrencess.child(widget.AdminUid)
                                .child("password")
                                .set(newpasswordcontroller.text);
                            Navigator.pop(context);
                          } else {}
                        } else {}
                      }
                    });
                  },
                  child: const Text("Change"))
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                textfieldwidgetmaxlength(
                    oldpasswordcontroller, "OLd Password", (s) {}, 1, 1, false),
                const SizedBox(
                  height: 15,
                ),
                textfieldwidgetmaxlength(
                    newpasswordcontroller, "New Password", (s) {}, 1, 1, false),
                const SizedBox(
                  height: 15,
                ),
                textfieldwidgetmaxlength(confirmnewpassword,
                    "Confirm New Password", (s) {}, 1, 1, false),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        }));
  }
}

nametile(String name, IconData iconData, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
            flex: 1,
            child: Icon(
              iconData,
              color: Colors.white,
              size: Responsive.isMobile(context) ? 15 : 30,
            )),
        Expanded(
            flex: 9,
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.isMobile(context) ? 15 : 30,
              ),
            )),
      ],
    ),
  );
}
