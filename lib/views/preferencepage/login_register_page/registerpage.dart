import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/views/preferencepage/login_register_page/loginpage.dart';
import 'package:newsapplication/views/sideview/widgets/generic_widgets.dart';

class RegisterPage extends StatefulWidget {
  final AppBloc appBloc;
  const RegisterPage({super.key, required this.appBloc});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void registerFunc(String email, String password, String confirmPassword) {
    widget.appBloc.add(
      AppRegisterEvent(
        context: context,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: BottomSheet(
          onClosing: () {},
          enableDrag: false,
          showDragHandle: false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.93,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr("register"),
                          style: GoogleFonts.dancingScript(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    divineSpace(height: 10),
                    textFieldTitle(title: tr("email")),
                    divineSpace(height: 10),
                    userTextField(
                        textController: emailController, context: context),
                    divineSpace(height: 10),
                    textFieldTitle(title: tr("password")),
                    divineSpace(height: 10),
                    passwordTextField(
                        textController: passwordController, context: context),
                    divineSpace(height: 10),
                    textFieldTitle(title: tr("confirmpassword")),
                    divineSpace(height: 10),
                    passwordTextField(
                        textController: confirmPasswordController,
                        context: context),
                    divineSpace(height: 30),
                    Center(
                      child: textButtonCustom(
                          context, tr("register"), Colors.blueGrey, () {
                        registerFunc(
                          emailController.text,
                          passwordController.text,
                          confirmPasswordController.text,
                        );
                      }),
                    ),
                    divineSpace(height: 20),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
