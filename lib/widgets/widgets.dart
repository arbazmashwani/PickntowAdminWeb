import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/responsive.dart';
import 'package:flutter/material.dart';

loginTextFields(TextEditingController controller, String labeltext,
    IconButton iconData, bool obscuretext) {
  FocusNode myFocusNode = new FocusNode();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: TextFormField(
        focusNode: myFocusNode,
        controller: controller,
        textInputAction: TextInputAction.done,
        obscureText: obscuretext,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color:
                  myFocusNode.hasFocus ? const Color(0xff2f68c0) : Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          suffixIcon: iconData,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black38, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff2f68c0), width: 1),
          ),
          labelText: labeltext,
        ),
      ),
    ),
  );
}

drawertile(Color color, BuildContext context, IconData icon, String name,
    void function(), bool bool) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
    child: Container(
      color: color,
      child: ListTile(

// If current item is selected show blue color
          title: Row(
            children: [
              Responsive.isDesktop(context)
                  ? Container()
                  : Icon(
                      icon,
                      color: bool ? kPrimaryColor : Colors.white,
                    ),
              const SizedBox(width: 15),
              Text(
                name,
                style: TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                    color: bool ? kPrimaryColor : Colors.white,
                    fontSize: 15),
              ),
            ],
          ),
          onTap: function),
    ),
  );
}
