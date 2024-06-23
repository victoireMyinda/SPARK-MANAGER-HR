import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_agent/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:location_agent/data/repository/signUp_repository.dart';
import 'package:location_agent/presentation/screens/login/login_screen.dart';
import 'package:location_agent/presentation/screens/login/widgets/appbarlogin.dart';
import 'package:location_agent/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:location_agent/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:location_agent/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:location_agent/presentation/widgets/dialog/loading.dialog.dart';
import 'package:location_agent/presentation/widgets/inputs/dropdownRole.dart';
import 'package:location_agent/presentation/widgets/inputs/nameField.dart';
import 'package:location_agent/presentation/widgets/inputs/passwordTextField.dart';
import 'package:location_agent/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:share_plus/share_plus.dart';

class SignupAgent extends StatefulWidget {
  const SignupAgent({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupAgent> createState() => _SignupAgentState();
}

final TextEditingController phoneController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
String? nameError;
String? passwordError;
String? submitError;
String? pays;
String? codePays = "+243";

class _SignupAgentState extends State<SignupAgent> {
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
              height: 100.0,
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
                            "Inscription agent",
                            style: TextStyle(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const TransAcademiaDropDownRole(
                        value: "role",
                        label: "Role",
                        hintText: "Role",
                      ),
                      const SizedBox(height: 10),

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

                      // BlocBuilder<SignupCubit, SignupState>(
                      //   builder: (context, state) {
                      //     return Container(
                      //         margin: const EdgeInsets.only(bottom: 15),
                      //         // color: Colors.white,
                      //         child: Container(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: 20.0),
                      //           height: 50.0,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10),
                      //             color: Colors.white,
                      //           ),
                      //           child: TransAcademiaNameInput(
                      //             controller: nameController,
                      //             hintText: "Poste",
                      //             color: Colors.white,
                      //             label: "Poste",
                      //             field: "poste",
                      //             fieldValue: state.field!["poste"],
                      //           ),
                      //         ));
                      //   },
                      // ),

                      BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                        return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(
                              bottom: 15,
                            ),
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
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () async {
                                if (state.field!["nom"] == "") {
                                  ValidationDialog.show(context,
                                      "Veuillez saisir votre nom complet", () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                if ((state.field!["phone"].substring(0, 1) ==
                                            "0" ||
                                        state.field!["phone"].substring(0, 1) ==
                                            "+") &&
                                    codePays == "+243") {
                                  ValidationDialog.show(context,
                                      "Veuillez saisir le numéro avec le format valide, exemple: (826016607).",
                                      () {
                                    print("modal");
                                  });
                                  return;
                                }
                                if (state.field!["phone"].length < 8 &&
                                    codePays == "+243") {
                                  ValidationDialog.show(context,
                                      "Le numéro ne doit pas avoir moins de 9 caractères, exemple: (826016607).",
                                      () {
                                    print("modal");
                                  });
                                  return;
                                }

                                if (state.field!["password"] == "") {
                                  ValidationDialog.show(context,
                                      "Veuillez saisir le mot de passe", () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                if (state.field!["password"] !=
                                    state.field!["confirmPassword"]) {
                                  ValidationDialog.show(context,
                                      "Les deux mots de passe ne correspond pas ",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                // check connexion
                                try {
                                  final response = await InternetAddress.lookup(
                                      'www.google.com');
                                  if (response.isNotEmpty) {
                                    print("connected");
                                  }
                                } on SocketException {
                                  ValidationDialog.show(
                                      context, "Pas de connexion internet !",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                var data = {
                                  "username": state.field!['prenom'],
                                  "firstname": state.field!['nom'],
                                  "lastname": state.field!['postnom'],
                                  "pwd": state.field!['password'],
                                  "pwd_repeat": state.field!["confirmPassword"],
                                  "mobile_no": state.field!["phone"],
                                  "grade": state.field!["grade"],
                                  "poste": "Agent",
                                  "is_root": state.field!['role'] == "true"
                                      ? true
                                      : false
                                };

                                // print(data);

                                TransAcademiaLoadingDialog.show(context);

                                Map<String, dynamic> result =
                                    await SignUpRepository.signupAgent(data);

                                int statusCode = result['status'];
                                String? message = result['message'];

                                if (statusCode == 200) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/routestack',
                                      (Route<dynamic> route) => false);
                                } else {
                                  TransAcademiaLoadingDialog.stop(context);
                                  TransAcademiaDialogError.show(
                                      context, message, "Signup");
                                }
                              },
                              child: const ButtonTransAcademia(
                                  title: "S'inscrire"),
                            ),
                          );
                        },
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
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text("Vous avez déjà un compte ?"),
                      //     const SizedBox(
                      //       width: 4,
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => const LoginScreen(),
                      //             ));
                      //       },
                      //       child: Text(
                      //         "Connexion",
                      //         style: TextStyle(
                      //           color: Colors.lightGreen.withOpacity(0.5),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )
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
