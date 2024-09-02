// ignore_for_file: use_build_context_synchronously
import 'dart:ffi';
import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkmanagerRH/data/repository/signUp_repository.dart';
import 'package:sparkmanagerRH/presentation/screens/agentAdmin/horaire/listhoraire.dart';
import 'package:sparkmanagerRH/presentation/screens/login/widgets/appbarlogin.dart';
import 'package:sparkmanagerRH/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:sparkmanagerRH/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:sparkmanagerRH/presentation/widgets/dialog/loading.dialog.dart';
import 'package:sparkmanagerRH/presentation/widgets/inputs/nameField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:sparkmanagerRH/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:sparkmanagerRH/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:flutter/material.dart';

class SignupHoraireScreen extends StatefulWidget {
 
  SignupHoraireScreen({Key? key,})
      : super(key: key);

  @override
  _SignupHoraireScreenState createState() => _SignupHoraireScreenState();
}

class _SignupHoraireScreenState extends State<SignupHoraireScreen> {
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
              height: 180,
              image: "assets/images/horaire.jpg",
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
                      const SizedBox(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Enregistrement de l'horaire",
                            style: TextStyle(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                AdaptiveTheme.of(context).mode.name != "dark"
                                    ? "assets/images/horaire.jpg"
                                    : "assets/images/horaire.jpg"),
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
                                  color: Colors.white,
                                ),
                                child: TransAcademiaNameInput(
                                  controller: phoneController,
                                  hintText: "Heure d'arrivée",
                                  color: Colors.white,
                                  label: "Heure d'arrivée",
                                  field: "HeureArrive",
                                  fieldValue: state.field!["HeureArrive"],
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 5.0,
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
                                  color: Colors.white,
                                ),
                                child: TransAcademiaNameInput(
                                  controller: phoneController,
                                  hintText: "Heure de cloture",
                                  color: Colors.white,
                                  label: "Heure de cloture",
                                  field: "heureCloture",
                                  fieldValue: state.field!["heureCloture"],
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
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                if (state.field!["HeureArrive"] == "") {
                                  ValidationDialog.show(context,
                                      "veuillez renseigner l'heure d'arrivée.",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                if (state.field!["HeureCloture"] == "") {
                                  ValidationDialog.show(context,
                                      "Veuillez renseigner l'heure de cloture",
                                      () {
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

                                Map<String, dynamic> datahoraire = {
                                  "start": state.field!["HeureArrive"],
                                  "end": state.field!["heureCloture"],
                                  "action": "",
                                };

                                print(datahoraire);

                                TransAcademiaLoadingDialog.show(context);
                                Map<String, dynamic> result =
                                    await SignUpRepository.createHoraire(
                                        datahoraire);
                                int statusCode = result['status'];
                                Map? data = result['data'];

                                if (statusCode == 201) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HorairesScreen(
                                              backNavigation: false,
                                            )),
                                  );
                                } else {
                                  TransAcademiaLoadingDialog.stop(context);
                                  TransAcademiaDialogError.show(context,
                                      "Une erreur est survenue", "horaire");
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
