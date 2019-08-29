import 'package:flutter/material.dart';
import 'package:flutter_app_todo/ui/Home.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Home()
    )
  );
}

