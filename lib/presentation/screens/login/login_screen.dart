// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_agent/constants/my_colors.dart';
import 'package:location_agent/data/repository/signUp_repository.dart';
import 'package:location_agent/presentation/screens/login/widgets/appbarlogin.dart';
import 'package:location_agent/presentation/screens/signupagent/signupagent.dart';
import 'package:location_agent/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:location_agent/presentation/widgets/dialog/TransAcademiaDialogLoginPayment.dart';
import 'package:location_agent/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:location_agent/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:location_agent/presentation/widgets/dialog/loading.dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:location_agent/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:location_agent/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:location_agent/presentation/screens/home/home_screen.dart';
import 'package:location_agent/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:location_agent/sizeconfig.dart';
import 'package:location_agent/presentation/widgets/inputs/passwordTextField.dart';
import 'package:location_agent/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  String stateInfoUrl = 'https://api.trans-academia.cd/';
  var androidState;
  var iosState;
  var dataAbonnement = [], prixCDF, prixUSD;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AbonnementCubit>(context).initFormPayment();
    print(AdaptiveTheme.of(context).mode.name);
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "password", data: "");
    // checkVersion();
    getDataListAbonnement();
  }

  void getDataListAbonnement() async {
    await http.post(Uri.parse("${stateInfoUrl}Trans_Liste_Abonement.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

//      print(data);

      dataAbonnement =
          data['donnees'].where((e) => e['Type'] == 'Prelevement').toList();
      prixUSD = dataAbonnement[0]['prix_USD'];

      BlocProvider.of<SignupCubit>(context).updateField(context,
          field: "prixCDF", data: dataAbonnement[0]['prix_CDF']);
      BlocProvider.of<SignupCubit>(context).updateField(context,
          field: "prixUSD", data: dataAbonnement[0]['prix_USD']);
      BlocProvider.of<SignupCubit>(context).updateField(context,
          field: "abonnement", data: dataAbonnement[0]['id']);
    });
  }

  // checkVersion() async {
  //   WidgetsFlutterBinding.ensureInitialized();

  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   String appName = packageInfo.appName;
  //   String packageName = packageInfo.packageName;
  //   String buildNumber = packageInfo.buildNumber;

  //   print('build' + buildNumber);

  //   final response = await http
  //       .get(Uri.parse('https://api-bantou-store.vercel.app/api/v1/versions'));

  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);

  //     print(data["android"]);
  //     androidState = data["android"];
  //     iosState = data["ios"];
  //     List<String> descriptionList = data["description"].split(",");

  //     if (Platform.isIOS == true) {
  //       if (int.parse(buildNumber) < int.parse(iosState)) {
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "iconVersion", data: "assets/images/appstore.json");
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "titreVersion",
  //             data: "Mettez à jour l'application sur Appstore");
  //         Navigator.of(context).pushNamedAndRemoveUntil(
  //             '/version', (Route<dynamic> route) => false, arguments: descriptionList);
  //       } else {
  //         return;
  //       }
  //     }

  //     if (Platform.isIOS == false) {
  //       if (int.parse(buildNumber) < int.parse(androidState)) {
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "iconVersion", data: "assets/images/playstore.json");
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "titreVersion",
  //             data: "Mettez à jour l'application sur playstore");

  //         Navigator.of(context).pushNamedAndRemoveUntil(
  //             '/version', (Route<dynamic> route) => false,arguments: descriptionList);
  //         // return;
  //       } else {
  //         print('ok');
  //       }
  //     }
  //   } else {
  //     print('error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ToastContext().init(context);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            const RecipeDetailAppBarLogin(
              height: 180,
              image: "image: widget.image",
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
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Agent Localisation",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        // width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                AdaptiveTheme.of(context).mode.name != "dark"
                                    ? "assets/images/locate.png"
                                    : "assets/images/locate.png"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                        return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 15, top: 20),
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
                      const SizedBox(
                        height: 5.0,
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
                        height: 10,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/routestack',
                                    (Route<dynamic> route) => false);
                              },
                              // onTap: () async {
                              //   print("moi");
                              //   SharedPreferences prefs =
                              //       await SharedPreferences.getInstance();
                              //   prefs.clear();
                              //   prefs.setBool("introduction", false);

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
                              //   if ((phoneController.text.substring(0, 1) ==
                              //               "0" ||
                              //           phoneController.text.substring(0, 1) ==
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
                              //     final response = await InternetAddress.lookup(
                              //         'www.google.com');
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
                              //           field: "phonePayment",
                              //           data: codePays! + phoneController.text);
                              //   print(state.field!["phonePayment"]);
                              //   //send data in api
                              //   TransAcademiaLoadingDialog.show(context);
                              //   Map<String, dynamic> result =
                              //       await SignUpRepository.login(
                              //           codePays! + phoneController.text,
                              //           state.field!["password"]);
                              //   String? token = result['token'];
                              //   int statusCode = result['status'];
                              //   Map? data = result['data'];

                              //   if (statusCode == 200) {
                              //     prefs.setString('token', token.toString());
                              //     prefs.setString(
                              //         'password', state.field!["password"]);
                              //     BlocProvider.of<SignupCubit>(context)
                              //         .updateField(context,
                              //             field: "token", data: token);
                              //     BlocProvider.of<SignupCubit>(context)
                              //         .updateField(context,
                              //             field: "data", data: data);
                              //     BlocProvider.of<SignupCubit>(context)
                              //         .updateField(context,
                              //             field: "role", data: "user");

                              //     Navigator.of(context).pushNamedAndRemoveUntil(
                              //         '/routestack',
                              //         (Route<dynamic> route) => false);
                              //   } else {
                              //     TransAcademiaLoadingDialog.stop(context);
                              //     TransAcademiaDialogError.show(
                              //         context,
                              //         "Nom d'utilisateur ou mot de passe incorrect",
                              //         "login");
                              //   }

                              // },

                              child: const ButtonTransAcademia(
                                  title: "Se connecter"),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.lightGreen.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.fingerprint_outlined,
                                  size: 40,
                                  color: Colors.lightGreen.withOpacity(0.8),
                                )
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Pas de compte ?"),
                          const SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupStep1(),
                                  ));
                            },
                            child: const Text(
                              "S'inscrire",
                              style: TextStyle(color: Colors.lightGreen),
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

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}
