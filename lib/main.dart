import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_location_service/geolocator_widget.dart';


void main() {
  runApp(MaterialApp(home: Scaffold(body: GeolocatorWidget())));
}
