

import 'package:flutter/material.dart';

enum DListViewType {
  none,
  separated,
}

class DListView extends StatelessWidget {

  final DListViewType type;
  final IndexedWidgetBuilder builder;
  final int itemCount;

  DListView({
    Key? key,
    this.type = DListViewType.none,
    required this.builder,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case DListViewType.none: {
        return ListView.builder(
          itemBuilder: builder,
          itemCount: itemCount,
        );
      }
      case DListViewType.separated: {
        return ListView.separated(
          itemBuilder: builder,
          separatorBuilder: (context, index) => const Divider(height: 2,),
          itemCount: itemCount
        );
      }
    }
  }
}