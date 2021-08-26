library flutter_dapp;

import 'package:flutter/material.dart';
import 'package:flutter_dapp/dwidget.dart';
import 'package:js_script/js_script.dart';
import 'controller.dart';
import 'template.dart' as template;
import 'setup_js/file_system.dart' as setupJs;

class DApp extends StatefulWidget {

  final String entry;
  final List<JsFileSystem> fileSystems;

  DApp({
    required this.entry,
    required this.fileSystems,
  });

  @override
  State<StatefulWidget> createState() => DAppState();
}

class DAppState extends State<DApp> {

  late JsScript script;

  @override
  void initState() {
    super.initState();
    script = JsScript(
      fileSystems: [
        setupJs.fileSystem,
      ]..addAll(widget.fileSystems)
    );
    script.addClass(controllerClass);
    script.run("/setup.js");
    template.register();
  }

  @override
  void dispose() {
    super.dispose();
    script.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DWidget(
      script: script,
      file: widget.entry
    );
  }
}