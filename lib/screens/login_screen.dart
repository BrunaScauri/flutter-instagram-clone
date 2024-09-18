import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
@override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              SvgPicture.asset('/ic_instagram.svg', colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn), height: 64), //color is curently deprecated, using ColorFilter instead
              const SizedBox(height: 64),
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
              ),
              const SizedBox(height: 24),
              Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)
                  )
                ),
                color: blueColor
              ),
              child: const Text('Log in'),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('Dont have an account?'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(' Sign up', style:TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              )
            ],
          )
        )
      )
    );
  }
}