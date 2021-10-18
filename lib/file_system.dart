
import 'package:flutter/services.dart';
import 'package:js_script/js_script.dart';

abstract class DappFileSystem extends JsFileSystem {
  ByteData? readBytes(String filename);
}