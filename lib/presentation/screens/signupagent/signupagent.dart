import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_agent/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:location_agent/presentation/screens/login/login_screen.dart';
import 'package:location_agent/presentation/screens/login/widgets/appbarlogin.dart';
import 'package:location_agent/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:location_agent/presentation/widgets/inputs/nameField.dart';
import 'package:location_agent/presentation/widgets/inputs/passwordTextField.dart';
import 'package:location_agent/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:share_plus/share_plus.dart';

class SignupStep1 extends StatefulWidget {
  const SignupStep1({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupStep1> createState() => _SignupStep1State();
}

final TextEditingController phoneController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
String? nameError;
String? passwordError;
String? submitError;

class _SignupStep1State extends State<SignupStep1> {
  void shareContent(String content) {
    Share.share(content);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            const RecipeDetailAppBarLogin(
              height: 100,
              image: "image: widget.image, date: widget.date",
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Inscription",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   height: 60,
                      //   // width: 300,
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage(
                      //           AdaptiveTheme.of(context).mode.name != "dark"
                      //               ? "assets/images/locate.png"
                      //               : "assets/images/locate.png"),
                      //     ),
                      //   ),
                      // ),

                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              // color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: TransAcademiaNameInput(
                                  controller: nameController,
                                  hintText: "Nom",
                                  color: Colors.white,
                                  label: "Nom",
                                  field: "nom",
                                  fieldValue: state.field!["nom"],
                                ),
                              ));
                        },
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              // color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: TransAcademiaNameInput(
                                  controller: nameController,
                                  hintText: "Postnom",
                                  color: Colors.white,
                                  label: "Postnom",
                                  field: "postnom",
                                  fieldValue: state.field!["postnom"],
                                ),
                              ));
                        },
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              // color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: TransAcademiaNameInput(
                                  controller: nameController,
                                  hintText: "Prenom",
                                  color: Colors.white,
                                  label: "Prenom",
                                  field: "prenom",
                                  fieldValue: state.field!["prenom"],
                                ),
                              ));
                        },
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              // color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: TransAcademiaNameInput(
                                  controller: nameController,
                                  hintText: "Grade",
                                  color: Colors.white,
                                  label: "Grade",
                                  field: "grade",
                                  fieldValue: state.field!["grade"],
                                ),
                              ));
                        },
                      ),

                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              // color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: TransAcademiaNameInput(
                                  controller: nameController,
                                  hintText: "Poste",
                                  color: Colors.white,
                                  label: "Poste",
                                  field: "poste",
                                  fieldValue: state.field!["poste"],
                                ),
                              ));
                        },
                      ),
                    
                      BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                        return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 15,),
                            child: SizedBox(
                              height: 50.0,
                              child: TransAcademiaPhoneNumber(
                                number: 20,
                                controller: phoneController,
                                hintText: "Numéro de téléphone",
                                field: "phone",
                                fieldValue: state.field!["phone"],
                              ),
                            ));
                      }),

                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              margin: const EdgeInsets.only(bottom: 15),
                              child: SizedBox(
                                height: 50.0,
                                child: TransAcademiaPasswordField(
                                  controller: passwordController,
                                  label: "Mot de passe",
                                  hintText: "Mot de passe",
                                  field: "password",
                                  fieldValue: state.field!["password"],
                                ),
                              ));
                        },
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              margin: const EdgeInsets.only(bottom: 15),
                              child: SizedBox(
                                height: 50.0,
                                child: TransAcademiaPasswordField(
                                  controller: confirmPasswordController,
                                  label: "Confirmer le Mot de passe",
                                  hintText: "Confirmer le Mot de passe",
                                  field: "confirmPassword",
                                  fieldValue: state.field!["confirmPassword"],
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () async {
                                // SharedPreferences prefs =
                                //     await SharedPreferences.getInstance();
                                // prefs.clear();
                                // prefs.setBool("introduction", false);

                                // if (state.field!["password"] ==
                                //     state.field!["confirmPassword"]) {
                                //   if (phoneController.text == "") {
                                //     ValidationDialog.show(context,
                                //         "veuillez saisir le numéro de téléphone",
                                //         () {
                                //       if (kDebugMode) {
                                //         print("modal");
                                //       }
                                //     });
                                //     return;
                                //   }

                                //   if (state.field!["nom"] == "") {
                                //     ValidationDialog.show(context,
                                //         "Veuillez saisir votre nom complet",
                                //         () {
                                //       if (kDebugMode) {
                                //         print("modal");
                                //       }
                                //     });
                                //     return;
                                //   }

                                //   if (!state.field!["email"].contains("@")) {
                                //     ValidationDialog.show(context,
                                //         "Le format du mail est incorrect",
                                //         () {
                                //       if (kDebugMode) {
                                //         print("modal");
                                //       }
                                //     });
                                //     return;
                                //   }
                                //   if ((phoneController.text.substring(0, 1) ==
                                //               "0" ||
                                //           phoneController.text
                                //                   .substring(0, 1) ==
                                //               "+") &&
                                //       codePays == "+243") {
                                //     ValidationDialog.show(context,
                                //         "Veuillez saisir le numéro avec le format valide, exemple: (826016607).",
                                //         () {
                                //       print("modal");
                                //     });
                                //     return;
                                //   }
                                //   if (phoneController.text.length < 8 &&
                                //       codePays == "+243") {
                                //     ValidationDialog.show(context,
                                //         "Le numéro ne doit pas avoir moins de 9 caractères, exemple: (826016607).",
                                //         () {
                                //       print("modal");
                                //     });
                                //     return;
                                //   }

                                //   if (state.field!["password"] == "") {
                                //     ValidationDialog.show(context,
                                //         "Veuillez saisir le mot de passe", () {
                                //       if (kDebugMode) {
                                //         print("modal");
                                //       }
                                //     });
                                //     return;
                                //   }

                                //   // check connexion
                                //   try {
                                //     final response =
                                //         await InternetAddress.lookup(
                                //             'www.google.com');
                                //     if (response.isNotEmpty) {
                                //       print("connected");
                                //     }
                                //   } on SocketException {
                                //     ValidationDialog.show(
                                //         context, "Pas de connexion internet !",
                                //         () {
                                //       if (kDebugMode) {
                                //         print("modal");
                                //       }
                                //     });
                                //     return;
                                //   }

                                //   BlocProvider.of<SignupCubit>(context)
                                //       .updateField(context,
                                //           field: "phone",
                                //           data: phoneController.text);

                                //   var data = {
                                //     "photo": "default",
                                //     "username": state.field!['nom'],
                                //     "password": state.field!['password'],
                                //     "number": codePays! + phoneController.text,
                                //     "email": state.field!['email']
                                //   };

                                //   TransAcademiaLoadingDialog.show(context);

                                //   Map<String, dynamic> result =
                                //       await SignUpRepository.createAccount(
                                //           data);

                                //   int statusCode = result['status'];
                                //   String? message = result['message'];

                                //   if (statusCode == 200) {
                                //     BlocProvider.of<SignupCubit>(context)
                                //         .updateField(context,
                                //             field: "password", data: "");
                                //     BlocProvider.of<SignupCubit>(context)
                                //         .updateField(context,
                                //             field: "confirmPassword", data: "");
                                //     BlocProvider.of<SignupCubit>(context)
                                //         .updateField(context,
                                //             field: "nom", data: "");
                                //     phoneController.text = "";

                                //     Navigator.of(context)
                                //         .pushNamedAndRemoveUntil('/login',
                                //             (Route<dynamic> route) => false);
                                //   } else {
                                //     TransAcademiaLoadingDialog.stop(context);
                                //     TransAcademiaDialogError.show(
                                //         context, message, "login");
                                //   }
                                // } else {
                                //   ValidationDialog.show(context,
                                //       "Les deux mots de passe ne correspondent pas",
                                //       () {
                                //     if (kDebugMode) {
                                //       print("modal");
                                //     }
                                //   });
                                //   return;
                                // }

                                //send data in api

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/routestack',
                                    (Route<dynamic> route) => false);
                              },
                              child: const ButtonTransAcademia(
                                  title: "S'inscrire"),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: Container(
                      //       height: 50.0,
                      //       width: MediaQuery.of(context).size.width,
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: Colors.lightGreen.withOpacity(0.5),.withOpacity(0.5),
                      //         ),
                      //         borderRadius: BorderRadius.circular(16.0),
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Icon(
                      //             Icons.fingerprint_outlined,
                      //             size: 40,
                      //             color: Colors.lightGreen.withOpacity(0.5),.withOpacity(0.8),
                      //           )
                      //         ],
                      //       )),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Vous avez déjà un compte ?"),
                          const SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                            },
                            child: Text(
                              "Connexion",
                              style: TextStyle(
                                color: Colors.lightGreen.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
