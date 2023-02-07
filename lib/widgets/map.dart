// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps/google_maps.dart';
import 'dart:ui' as ui;

class Maps {
  Widget getMap(num latitide, num longitude) {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final myLatlng = LatLng(latitide, longitude);

      final mapOptions = MapOptions()
        ..zoom = 15
        ..center = LatLng(latitide, longitude);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);

      Marker(MarkerOptions()
        ..position = myLatlng
        ..map = map
        ..title = 'Hello World!');

      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }
}
