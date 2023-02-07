import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/responsive.dart';
import 'package:adminweb/screens/Reports/reportscree.dart';
import 'package:adminweb/screens/admins/admins.dart';
import 'package:adminweb/screens/admins/manageadmins.dart';
import 'package:adminweb/screens/drivers/drivers.dart';
import 'package:adminweb/screens/drivers/suspendeddr.dart';
import 'package:adminweb/screens/homescreen/homescreen.dart';
import 'package:adminweb/screens/homescreen/homescreen_mobile.dart';
import 'package:adminweb/screens/messages/chatscreen.dart';
import 'package:adminweb/screens/promotions/promotions.dart';
import 'package:adminweb/screens/riders/customerscreen.dart';
import 'package:adminweb/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key, required this.name, required this.uid});
  String name;
  String uid;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<bool> _selected = List.generate(8, (i) => false);
  List options = [
    "Dashboard",
    "Drivers",
    "Customers",
    "Suspended Drivers",
    "Chat",
    "Reports",
    "Managaers",
    "Promotions"
  ];
  final List<IconData> iconslist = [
    Icons.dashboard,
    Icons.verified,
    Icons.people,
    Icons.admin_panel_settings,
    Icons.report,
    Icons.report,
    Icons.report,
    Icons.report,
  ];

  int _selectedindex = 1;
  final defaultPadding = 16.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Responsive.isMobile(context)
          ? const HomeScreenMobile()
          : const HomeScreen(),
      DriversScreens(
        adminName: widget.name,
      ),
      const RiderScreen(),
      const SuspendedDriversSreen(),
      const WebLayoutScreen(),
      ReportScreen(
        name: widget.name,
      ),
      ManageadminsPage(),
      PromotionsPage(
        adminName: widget.name,
      ),
      AdminsPage(
        AdminUid: widget.uid,
      ),
    ];
    callScreens() {
      return screens[_selectedindex];
    }

    return Scaffold(
      drawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                      child: Container(
                        color: const Color(0xff343A40),
                      ),
                    ),
                    Container(
                      color: const Color(0xff343A40),
                      child: Column(
                        children: [
                          SizedBox(
                            height:
                                75 * double.parse(options.length.toString()),
                            child: ListView.builder(
                                itemCount: options.length,
                                itemBuilder: ((context, i) {
                                  return drawertile(
                                      _selected[i]
                                          ? Colors.white
                                          : const Color(0xff414950),
                                      context,
                                      iconslist[i],
                                      options[i], () {
                                    setState(() {
                                      _selected = List.filled(
                                          _selected.length, false,
                                          growable: true);
                                      _selected[i] = !_selected[i];

                                      _selectedindex = i;
                                      callScreens();
                                    });
                                    Navigator.pop(context);
                                  }, _selected[i]);
                                })),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selected =
                      List.filled(_selected.length, false, growable: true);
                  _selectedindex = 8;
                  callScreens();
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: defaultPadding),
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: defaultPadding / 2,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSPWhDcrmhvY86Q42jr73c-812hSyMhO3DxTXRt2H6uxgiLKsnktZsZfJ-14AvPaqR01k&usqp=CAU",
                      height: 38,
                    ),
                    if (!Responsive.isMobile(context))
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        child: const Text("Admin Taha"),
                      ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          )
        ],
        backgroundColor: const Color(0xff343A40),
        title: Row(
          children: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Contact",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
      body: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Responsive.isTablet(context) || Responsive.isMobile(context)
                ? Container()
                : Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: const Color(0xff343A40),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 75 *
                                      double.parse(options.length.toString()),
                                  child: ListView.builder(
                                      itemCount: options.length,
                                      itemBuilder: ((context, i) {
                                        return drawertile(
                                            _selected[i]
                                                ? Colors.white
                                                : const Color(0xff414950),
                                            context,
                                            iconslist[i],
                                            options[i], () {
                                          setState(() {
                                            _selected = List.filled(
                                                _selected.length, false,
                                                growable: true);
                                            _selected[i] = !_selected[i];

                                            _selectedindex = i;
                                            callScreens();
                                          });
                                        }, _selected[i]);
                                      })),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
            Expanded(flex: 9, child: callScreens())
          ],
        ),
      ),
    );
  }
}
