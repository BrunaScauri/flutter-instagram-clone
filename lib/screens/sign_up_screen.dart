import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/image_picker.dart';
import 'package:instagram_clone/utils/show_snack_bar.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    if (res != 'success') {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void loadUser() {
    setState(() {
      _isLoading = true;
    });
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
                    SvgPicture.asset('/ic_instagram.svg',
                        colorFilter:
                            const ColorFilter.mode(white, BlendMode.srcIn),
                        height:
                            64), //color is curently deprecated, using ColorFilter instead
                    const SizedBox(height: 32),
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!))
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://i0.wp.com/digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png?fit=500%2C500&ssl=1')),
                        Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add_circle)))
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextFieldInput(
                      hintText: 'Enter your username',
                      textInputType: TextInputType.text,
                      textEditingController: _usernameController,
                    ),
                    const SizedBox(height: 24),
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
                    TextFieldInput(
                      hintText: 'Enter your bio',
                      textInputType: TextInputType.text,
                      textEditingController: _bioController,
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                        onTap: loadUser,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              color: blueColor),
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator(color: white) )
                              : const Text('Sign Up'),
                        )),
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
                            child: const Text(' Sign up',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    )
                  ],
                ))));
  }
}
