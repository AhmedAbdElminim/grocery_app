import 'package:flutter/material.dart';
import 'package:grocery_app/shared/consts/constants.dart';

import 'empty_viewed.dart';
import 'full_viewed.dart';

class ViewedScreen extends StatelessWidget {
  const ViewedScreen({Key? key}) : super(key: key);
static const String viewedScreenId='ViewedScreenId';
  @override
  Widget build(BuildContext context) {
    return recentViewed.isEmpty?const EmptyViewedScreen():const FullViewedScreen();
  }
}
