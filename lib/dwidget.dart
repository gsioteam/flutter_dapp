
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_dapp/controller.dart';
import 'package:js_script/js_script.dart';
import 'package:path/path.dart' as path;
import 'package:xml_layout/xml_layout.dart';

wrap(object) {
  if (object is JsValue) {
    if (object.isArray) {
      return DataList(object);
    } else {
      return DataMap(object);
    }
  } else {
    return object;
  }
}

unwrap(object) {
  if (object is DataMap) {
    return object.value;
  } else if (object is DataList) {
    return object.value;
  } else {
    return object;
  }
}

class DataList with List, ListMixin {
  JsValue value;
  DataList(this.value);

  @override
  int get length => value["length"];
  set length(int len) => value["length"] = len;

  @override
  operator [](int index) {
    return wrap(value[index]);
  }

  @override
  void operator []=(int index, value) {
    this.value[index] = unwrap(value);
  }

}

class DataMap with Map, MapMixin {
  JsValue value;

  DataMap(this.value);

  @override
  operator [](Object? key) {
    return wrap(value[key]);
  }

  @override
  void operator []=(key, value) {
    this.value[key] = unwrap(value);
  }

  @override
  void clear() {
  }

  @override
  Iterable get keys sync* {
    for (var key in value.getOwnPropertyNames()) {
      yield key;
    }
  }

  @override
  remove(Object? key) {
  }

}

class ContextData {
  final JsValue controller;
  final String file;

  ContextData({
    required this.controller,
    required this.file
  });

  String relativePath(String file) {
    return path.join(this.file, '..', file);
  }
}

class _InheritedContext extends InheritedWidget {
  final ContextData data;

  _InheritedContext({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(
    key: key,
    child: child
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is _InheritedContext) {
      return oldWidget.data != data;
    }
    return true;
  }

}

class DWidget extends StatefulWidget {
  final String file;
  final JsScript script;
  final Map<String, dynamic>? initializeData;

  DWidget({
    Key? key,
    required this.script,
    required this.file,
    this.initializeData
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => DWidgetState();

  static ContextData? of(BuildContext context) {
    _InheritedContext? res = context.dependOnInheritedWidgetOfExactType<_InheritedContext>();
    return res?.data;
  }
}

class DWidgetState extends State<DWidget> {

  late String template;
  late JsValue controller;
  late ContextData _contextData;
  bool _ready = false;

  void updateData(VoidCallback callback) {
    if (_ready) {
      setState(callback);
    } else {
      callback();
    }
  }

  @override
  void initState() {
    super.initState();
    String file = path.join(path.dirname(widget.file), "${path.basenameWithoutExtension(widget.file)}.xml");

    template = widget.script.fileSystems.loadCode(file)!;
    file = path.extension(widget.file).isEmpty ? "${widget.file}.js" : widget.file;
    JsValue jsClass = widget.script.run(file);
    if (!jsClass.isConstructor) {
      throw Exception("Script result must be a constructor.");
    }
    controller = widget.script.bind(
        Controller(widget.script)
          ..state = this,
        classFunc: jsClass)..retain();
    _contextData = ContextData(
      controller: controller,
      file: file,
    );
    try {
      controller.invoke("load", [widget.initializeData ?? {}]);
    } catch (e) {
      print(e);
    }

    _ready = true;
  }

  @override
  void dispose() {
    super.dispose();
    _ready = false;
    try {
      controller.invoke("unload");
    } catch (e) {
      print(e);
    }
    controller.release();
    data?.release();
  }

  JsValue? data;
  @override
  Widget build(BuildContext context) {
    data?.release();
    data = (controller["data"] as JsValue?);
    Map objects;
    if (data != null) {
      data!.retain();
      objects = DataMap(data!);
    } else {
      objects = {};
    }
    return _InheritedContext(
      child: XmlLayout(
        template: template,
        objects: objects,
        onUnkownElement: (node, key) {
          print("Unkown tag ${node.name}");
        },
      ),
      data: _contextData,
    );
  }
}