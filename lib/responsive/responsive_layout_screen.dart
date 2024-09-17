import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout; //consts for the created layouts in here
  final Widget mobileScreenLayout;
  const ResponsiveLayout({super.key, required this.mobileScreenLayout, required this.webScreenLayout})

  @override
  Widget build(BuildContext context) {
    return const LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth > webScreenSize){
        return webScreenLayout;
      }
      return mobileScreenLayout;
    },
  );
  }
}
