// ignore_for_file: use_build_context_synchronously
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparkmanagerRH/data/repository/signUp_repository.dart';
import 'package:sparkmanagerRH/presentation/screens/login/widgets/appbarlogin.dart';
import 'package:sparkmanagerRH/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:sparkmanagerRH/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:sparkmanagerRH/presentation/widgets/dialog/loading.dialog.dart';
import 'package:sparkmanagerRH/presentation/widgets/inputs/nameField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:sparkmanagerRH/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:sparkmanagerRH/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:sparkmanagerRH/presentation/widgets/inputs/passwordTextField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? nameError;
  String? passwordError;
  String? submitError;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            const RecipeDetailAppBarLogin(
              height: 200,
              image: "image: widget.image",
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Color.fromARGB(31, 8, 175, 131),
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Spark Manager-RH ",
                            style: GoogleFonts.montserrat(
                                fontSize: 17, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.white,
                                ),
                                child: TransAcademiaNameInput(
                                  controller: phoneController,
                                  hintText: "Nom  d'utilisateur",
                                  color: Colors.white,
                                  label: "Nom  d'utilisateur",
                                  field: "prenom",
                                  fieldValue: state.field!["prenom"],
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
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
                                  controller: passwordController,
                                  label: "Mot de passe",
                                  hintText: "Mot de passe",
                                  field: "password",
                                  fieldValue: state.field!["password"],
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                if (state.field!["prenom"] == "") {
                                  ValidationDialog.show(context,
                                      "veuillez saisir le nom d'utilisateur",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
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

                                // Vérifier la connexion Internet
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

                                Map<String, dynamic> datalogin = {
                                  "login": state.field!["prenom"],
                                  "pwd": state.field!["password"],
                                };

                                //  print(datalogin);

                                TransAcademiaLoadingDialog.show(context);
                                Map<String, dynamic> result =
                                    await SignUpRepository.login(datalogin);
                                int statusCode = result['status'];
                                Map? data = result['data'];
                                // bool role = data!['as_user']['is_root'];

                                if (statusCode == 200) {
                                  BlocProvider.of<SignupCubit>(context)
                                      .updateField(context,
                                          field: "data", data: data);

                                  BlocProvider.of<SignupCubit>(context)
                                      .updateField(context,
                                          field: "role",
                                          data: data!['as_user']['is_root']);

                                  prefs.setBool(
                                      'role', data['as_user']['is_root']);

                                  data['as_user']['is_root'] == true
                                      ? Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/routestack',
                                              (Route<dynamic> route) => false)
                                      : Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/routestackAgent',
                                              (Route<dynamic> route) => false);
                                } else {
                                  TransAcademiaLoadingDialog.stop(context);
                                  TransAcademiaDialogError.show(
                                      context,
                                      "Nom d'utilisateur ou mot de passe incorrect",
                                      "login");
                                }
                              },
                              child: const ButtonTransAcademia(
                                  title: "Se connecter"),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}
