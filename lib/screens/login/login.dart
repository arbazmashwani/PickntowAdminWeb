import 'package:adminweb/helpers/responsive.dart';
import 'package:adminweb/screens/dashboard.dart';
import 'package:adminweb/screens/login/action_button.dart';
import 'package:adminweb/screens/login/constants.dart';
import 'package:adminweb/widgets/loading.dart';

import 'package:adminweb/widgets/widgets.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({
    super.key,
  });

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  DatabaseReference userRef = FirebaseDatabase.instance.ref();

  bool showpassword = true;

  String email = "";
  String password = "";
  String errormessage = "";
  String adminId = "";

  TextEditingController controller = TextEditingController();

  TextEditingController controller1 = TextEditingController();

  bool saveme = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.height > 770
          ? 64
          : size.height > 670
              ? 32
              : 16),
      child: Center(
        child: Card(
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: size.height *
                (size.height > 770
                    ? 0.7
                    : size.height > 670
                        ? 0.8
                        : 0.9),
            width: 500,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: (Responsive.isMobile(context)) ? 100 : 100,
                        child: (kDebugMode)
                            ? Image.asset("icon.png")
                            : Image.asset("assets/icon.png"),
                      ),
                      Text(
                        "LOG IN",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 30,
                        child: Divider(
                          color: kPrimaryColor,
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      loginTextFields(
                          controller,
                          "Email",
                          IconButton(onPressed: () {}, icon: Icon(Icons.email)),
                          false),
                      loginTextFields(
                          controller1,
                          "Password",
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  showpassword = !showpassword;
                                });
                              },
                              icon: Icon(showpassword
                                  ? Icons.remove_red_eye
                                  : Icons.password)),
                          showpassword),
                      errormessage.isEmpty
                          ? Container()
                          : Text(
                              errormessage.isEmpty ? "" : errormessage,
                              style: const TextStyle(
                                  color: Color(0xff343A40),
                                  fontWeight: FontWeight.bold),
                            ),
                      SizedBox(
                        height: errormessage.isEmpty ? 10 : 0,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              activeColor: Color(0xff343A40),
                              value: saveme,
                              onChanged: (valu) {
                                setState(() {
                                  saveme = !saveme;
                                });
                              }),
                          const Text("Remember Me")
                        ],
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      actionButton(
                        "Log In",
                        () async {
                          Navigator.of(context).push(_createRoute());
                          Future.delayed(const Duration(seconds: 2), () async {
                            setState(() {
                              email = "";
                              password = "";
                              errormessage = "";
                            });

                            await userRef
                                .child("Admins")
                                .orderByChild("Name")
                                .equalTo(controller.text)
                                .once()
                                .then((DatabaseEvent databaseEvent) {
                              if (databaseEvent.snapshot.value != null) {
                                setState(() {
                                  email = controller.text;
                                });
                                Map<dynamic, dynamic> values =
                                    databaseEvent.snapshot.value as Map;
                                values.forEach((key, values) {
                                  if (values["password"] == controller1.text) {
                                    setState(() {
                                      password = controller1.text;
                                      adminId = values["id"].toString();
                                    });
                                  }
                                });
                              } else {}
                            });

                            if (email.isEmpty || password.isEmpty) {
                              Navigator.pop(context);
                              setState(() {
                                errormessage = "email or password is wrong";
                              });
                            } else {
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen(
                                        name: email, uid: adminId)),
                                (Route<dynamic> route) => false,
                              );
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MyWidget(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
