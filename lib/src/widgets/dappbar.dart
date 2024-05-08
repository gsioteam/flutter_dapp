
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DAppBar extends StatelessWidget implements PreferredSizeWidget {

  final Widget? leading;
  final Widget? child;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Color? background;
  final Color? color;
  final Brightness? brightness;
  final double height;

  DAppBar({
    Key? key,
    this.leading,
    this.child,
    this.actions,
    this.bottom,
    this.background,
    this.color,
    this.brightness,
    this.height = 56,
  }) : preferredSize = Size.fromHeight(bottom == null ? height : height + bottom.preferredSize.height),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: child,
      leading: leading,
      actions: actions,
      bottom: bottom,
      backgroundColor: background,
      foregroundColor: color,
      iconTheme: color == null ? null : IconThemeData(
        color: color
      ),
      actionsIconTheme: color == null ? null : IconThemeData(
        color: color
      ),
      systemOverlayStyle: brightness == null ? null : (brightness == Brightness.light ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark),
    );
  }

  @override
  final Size preferredSize;
}