

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:js_script/js_script.dart';
import 'package:js_script/types.dart';

import 'dapp_state.dart';
import 'dwidget.dart';
import 'js_wrap.dart';

class Controller {
  DWidgetState? state;
  JsScript script;

  Controller(this.script);

  void setState(JsValue func) {
    if (state != null) {
      func.retain();
      state!.updateData(() {
        func.call();
        func.release();
      });
    }
  }

  Future navigateTo(String src, JsValue ops) async {
    if (state != null) {
      ops.retain();
      var ret = await state!.navigateTo(
        src,
        data: ops["data"],
      );
      ops.release();
      return ret;
    }
  }

  navigateBack(dynamic result) {
    if (state != null) {
      state!.navigateBack(result);
    }
  }

  JsValue? find(String key) {
    var res = state?.find(key);
    if (res is State) {
      StateValue stateValue = StateValue(res);
      JsValue value = state!.script.bind(stateValue, classInfo: stateClass);
      stateValue.setup(value);
      return value;
    }
  }

  loadString(String src) {
    var state = this.state;
    if (state != null) {
      String path = state.relativePath(src);
      return state.script.fileSystems.loadCode(path);
    }
  }

  double getWidth() {
    var renderObject = state?.context.findRenderObject();
    return renderObject?.semanticBounds.width ?? 0;
  }

  double getHeight() {
    var renderObject = state?.context.findRenderObject();
    return renderObject?.semanticBounds.height ?? 0;
  }
}

ClassInfo controllerClass = ClassInfo<Controller>(
  name: "_Controller",
  newInstance: (_,__) => throw Exception("This is a abstract class"),
  fields: {
  },
  functions: {
    "setState": JsFunction.ins((obj, argv) => obj.setState(argv[0])),
    "navigateTo": JsFunction.ins((obj, argv) => obj.navigateTo(argv[0], argv[1])),
    "navigateBack": JsFunction.ins((obj, argv) => obj.navigateBack(argv[0])),
    "findElement": JsFunction.ins((obj, argv) => obj.find(argv[0])),
    "loadString": JsFunction.ins((obj, argv) => obj.loadString(argv[0])),
    "getWidth": JsFunction.ins((obj, argv) => obj.getWidth()),
    "getHeight": JsFunction.ins((obj, argv) => obj.getHeight()),
  }
);