import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/show_snack_bar.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res != 'success') {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
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
                    SvgPicture.asset('assets/ic_instagram.svg',
                        colorFilter:
                            const ColorFilter.mode(white, BlendMode.srcIn),
                        height: 64),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          color: blueColor),
                      child: const Text('Log in'),
                    ),
                    const SizedBox(height: 12),
                    Flexible(flex: 2, child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          // padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text('Dont have an account? '),
                        ),
                        GestureDetector(
                          onTap: navigateToSignUp,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: _isLoading
                                ? const Center(
                                    child:
                                        CircularProgressIndicator(color: white))
                                : const Text(
                                    'Sign up',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                          ),
                        )
                      ],
                    )
                  ],
                ))));
  }
}
