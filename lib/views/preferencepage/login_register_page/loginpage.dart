import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/views/preferencepage/login_register_page/registerpage.dart';
import 'package:newsapplication/views/sideview/overlays/loading_dialog.dart';
import 'package:newsapplication/views/sideview/widgets/generic_widgets.dart';

class LoginPage extends StatelessWidget {
  final AppBloc appBloc;
  final String? username;
  const LoginPage({super.key, required this.appBloc, this.username});

  void loginTrigger(
    BuildContext context,
    String email,
    String password,
  ) {
    appBloc.add(
      AppLoginEvent(
        context: context,
        email: email,
        password: password,
      ),
    );
  }

  void registerTrigger(BuildContext context) {
    Navigator.push(
      context,
      CupertinoModalPopupRoute(
        barrierDismissible: true,
        semanticsDismissible: true,
        builder: (context) => RegisterPage(
          appBloc: appBloc,
        ),
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
          final TextEditingController emailController =
              TextEditingController(text: username ?? "");
          final TextEditingController passwordController =
              TextEditingController();
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
                        tr("login"),
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
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        textFieldTitle(title: tr("email")),
                        divineSpace(height: 10),
                        userTextField(
                            textController: emailController,
                            context: context,
                            username: username),
                        divineSpace(height: 10),
                        textFieldTitle(title: tr("password")),
                        divineSpace(height: 10),
                        passwordTextField(
                          textController: passwordController,
                          context: context,
                        ),
                        divineSpace(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textButtonCustom(context, tr("register"),
                                Colors.blueGrey.withOpacity(0.6), () {
                              registerTrigger(context);
                            }),
                            divineSpace(width: 20),
                            textButtonCustom(context, tr("login"), Colors.green,
                                () {
                              loginTrigger(
                                context,
                                emailController.text,
                                passwordController.text,
                              );
                            }),
                          ],
                        ),
                        divineSpace(height: 20),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              divineLine(
                                  colors: [Colors.grey, Colors.grey],
                                  space: 0,
                                  size: 0.3,
                                  spaceBot: 40,
                                  start: Alignment.center),

                              genericTextButton(
                                context: context,
                                icon: Icons.apple,
                                text: tr("applelogin"),
                                bgcolor: const Color.fromARGB(
                                  170,
                                  234,
                                  220,
                                  198,
                                ),
                                sized: 45,
                                func: () {
                                  LoadingOverlay.instance().showOverlay(
                                    context: context,
                                  );
                                },
                              ),
                              divineSpace(height: 20),

                              genericTextButton(
                                context: context,
                                icon: Icons.g_mobiledata,
                                text: tr("gglogin"),
                                bgcolor: const Color.fromARGB(
                                  170,
                                  234,
                                  220,
                                  198,
                                ),
                                sized: 45,
                                func: () {},
                              ),
                              divineSpace(height: 20),
                              genericTextButton(
                                context: context,
                                icon: Icons.tiktok,
                                text: tr("tiktoklogin"),
                                bgcolor: const Color.fromARGB(
                                  170,
                                  234,
                                  220,
                                  198,
                                ),
                                sized: 40,
                                func: () {},
                              ),
                              divineSpace(height: 10),
                              textButtonCustom(context, tr("forgot"),
                                  Colors.blueAccent, () {}),
                              // TextButton(
                              //     onPressed: () {},
                              //     child: const Text(
                              //       'forgot password ?',
                              //       style: TextStyle(
                              //           decoration: TextDecoration.underline,
                              //           color: Colors.blue),
                              //     )),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget textFieldTitle({required String title, double? size}) {
  return Text(
    title,
    style: TextStyle(
        fontWeight: FontWeight.w400, color: Colors.grey, fontSize: size ?? 16),
  );
}

Widget userTextField({
  required TextEditingController textController,
  required BuildContext context,
  String? username,
}) {
  return TextField(
      controller: textController,
      cursorColor: Colors.blueGrey,
      textAlignVertical: TextAlignVertical.center,
      maxLines: 1,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        hintText: username ?? "",
        prefixIcon: const Icon(
          Icons.account_circle,
          size: 22,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              textController.clear();
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
              size: 22,
            )),
        fillColor: Theme.of(context).colorScheme.background,
        iconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        textController.text = value;
      });
}

Widget passwordTextField({
  required TextEditingController textController,
  required BuildContext context,
}) {
  return SizedBox(
    child: TextField(
        cursorColor: Colors.blueGrey,
        controller: textController,
        textAlignVertical: TextAlignVertical.center,
        obscureText: true,
        obscuringCharacter: 'X',
        maxLines: 1,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          prefixIcon: const Icon(
            Icons.password_rounded,
            size: 22,
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                textController.clear();
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.grey,
                size: 22,
              )),
          // fillColor: Colors.white,
          fillColor: Theme.of(context).colorScheme.background,

          iconColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          textController.text = value;
        }),
  );
}
