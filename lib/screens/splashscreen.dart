import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/colors.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 16, 15, 1),
      
      body: SafeArea( 
        child: 
        Column(children: [  
        Flexible(flex: 5, child: Container()),
        SvgPicture.asset('/skateboard_only_logo.svg', colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn), height: 150),
        const SizedBox(height: 48),
        Flexible(flex: 2, child: Container()),
        const Image(image: AssetImage('/Animation.gif'), height: 150, width: 150),

        ],)
      )
    );
  }
}