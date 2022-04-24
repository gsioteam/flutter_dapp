
import 'package:flutter/material.dart';
import 'package:flutter_dapp/src/dapp_state.dart';

enum ScrollViewType {
  normal,
  page,
  disable,
}

class DScrollView extends StatefulWidget {

  final List<Widget> children;
  final Axis direction;
  final ScrollViewType type;
  final bool reverse;

  DScrollView({
    Key? key,
    this.children = const <Widget>[],
    this.direction = Axis.vertical,
    this.type = ScrollViewType.normal,
    this.reverse = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScrollViewState();
}

class ScrollViewState extends DAppState<DScrollView> {

  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();

    registerMethod("scrollTo", (num x, num y) {
      if (widget.direction == Axis.horizontal) {
        controller.animateTo(x.toDouble(), duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic);
      } else {
        controller.animateTo(y.toDouble(), duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: getChildren(),
      scrollDirection: widget.direction,
      physics: makeScrollPhysics(),
      reverse: widget.reverse,
    );
  }

  ScrollPhysics? makeScrollPhysics() {
    switch (widget.type) {
      case ScrollViewType.normal:
        return null;
      case ScrollViewType.disable:
        return NeverScrollableScrollPhysics();
      case ScrollViewType.page:
        return PageScrollPhysics();
    }
  }

  List<Widget> getChildren() {
    switch (widget.type) {
      case ScrollViewType.page: {
        return widget.children.map((e) {
          return SliverFillRemaining(
            child: e,
          );
        }).toList();
      }
      default: {
        return widget.children.map((e) {
          return SliverToBoxAdapter(
            child: e,
          );
        }).toList();
      }
    }
  }
}