import 'package:adminweb/helpers/responsive.dart';
import 'package:flutter/material.dart';

totalinfoContainer(String value, String text, IconData icon, Color color,
    BuildContext context) {
  return Container(
    color: const Color(0xff343A40),
    height: 90,
    width: 59,
    child: Row(
      children: [
        MediaQuery.of(context).size.width > 576 &&
                MediaQuery.of(context).size.width < 676
            ? Container(
                width: 10,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: color,
                  height: MediaQuery.of(context).size.width < 796 ? 30 : 60,
                  width: MediaQuery.of(context).size.width < 796 ? 30 : 60,
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width < 796 ? 15 : 30,
                    ),
                  ),
                ),
              ),
        Expanded(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.isMobile(context) ? 10 : 15),
                  )
                ],
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 15,
              ),
              Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ))
      ],
    ),
  );
}
