
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dapp/extensions/extension.dart';
import 'package:flutter_dapp/src/flutter_dapp.dart';
import 'package:js_script/js_ffi.dart';
import 'package:js_script/js_script.dart';
import 'dart:async' as asyn;

class Timer implements JsDispose {
  Duration time;
  bool repeat;

  Timer(this.time, this.repeat);

  JsValue? _onTimeout;

  JsValue? get onTimeout => _onTimeout;
  set onTimeout(JsValue? value) {
    _onTimeout?.release();
    _onTimeout = value?..retain();
  }

  dispose() {
    print("DisposeTimer");
    _onTimeout?.release();
  }

  late asyn.Timer? _timer;

  void start() {
    if (repeat) {
      _timer = asyn.Timer.periodic(this.time, (timer) {
        this.onTimeout?.call();
      });
    } else {
      _timer = asyn.Timer(this.time, () {
        this.onTimeout?.call();
      });
    }
  }

  void stop() {
    _timer?.cancel();
  }
}

ClassInfo _timerClass = ClassInfo<Timer>(
  newInstance: (script, argv) => Timer(Duration(milliseconds: argv[0]), argv[1]),
  functions: {
    "start": JsFunction.ins((obj, argv) => obj.start()),
    "stop": JsFunction.ins((obj, argv) => obj.stop()),
  },
  fields: {
    "onTimeout": JsField.ins(
      set: (obj, value) => obj.onTimeout = value,
      get: (obj) => obj.onTimeout,
    )
  }
);

///
/// Contains `Buffer`, `URL`, `setTimeout`, `atob`, `btoa`, `Event`,
/// `EventTarget`  functions.
class Main extends Extension {
  @override
  Future<String> loadCode(BuildContext context) {
    return rootBundle.loadString("packages/flutter_dapp/js_env/index.min.js");
  }

  @override
  void setup(JsScript script) {
    script.addClass(_timerClass);
  }

}