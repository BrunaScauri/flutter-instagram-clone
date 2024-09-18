import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/colors.dart';

class LogoBanner extends StatelessWidget {
  const LogoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset('/ic_instagram.svg', colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn), height: 64), //color is curently deprecated, using ColorFilter instead
    );
  }
}