import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dapp/flutter_dapp.dart';
import 'package:js_script/js_script.dart';

class ArchiveFileSystem extends JsFileSystem {
  final Archive archive;

  ArchiveFileSystem(this.archive);

  @override
  bool exist(String filename) {
    if (filename[0] == '/') filename = filename.substring(1);
    return archive.findFile(filename) != null;
  }

  @override
  String? read(String filename) {
    if (filename[0] == '/') filename = filename.substring(1);
    var file = archive.findFile(filename);
    if (file != null) {
      return utf8.decode(file.content);
    } else {
      return null;
    }
  }

}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<Archive> _loadData() async {
    var data = await rootBundle.load("assets/test.zip");
    return ZipDecoder().decodeBytes(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Archive>(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DApp(
              entry: '/main',
              fileSystems: [
                ArchiveFileSystem(snapshot.requireData),
              ]
          );
        } else {
          return Container();
        }
      }
    );
  }
}
