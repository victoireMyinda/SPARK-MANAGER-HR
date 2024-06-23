// ignore_for_file: use_build_context_synchronously
import 'dart:ffi';
import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_agent/data/repository/signUp_repository.dart';
import 'package:location_agent/presentation/screens/login/widgets/appbarlogin.dart';
import 'package:location_agent/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:location_agent/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:location_agent/presentation/widgets/dialog/loading.dialog.dart';
import 'package:location_agent/presentation/widgets/inputs/nameField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:location_agent/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:location_agent/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:location_agent/presentation/widgets/inputs/passwordTextField.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

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

  Future<Position> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          throw Exception("Permission de localisation refusée");
        }
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
      }

      throw Exception("Permission de localisation non accordée");
    } catch (e) {
      print("Erreur lors de la récupération de la localisation : $e");
      throw e; // Vous pouvez également afficher un message d'erreur à l'utilisateur ici
    }
  }

  Future<bool> _showPermissionDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Permission de localisation"),
        content: const Text(
          "Cette application nécessite l'accès à la localisation. "
          "Veuillez activer les permissions de localisation dans les paramètres pour continuer.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Ouvrir les paramètres"),
          ),
        ],
      ),
    );
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
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Connexion ",
                            style: TextStyle(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
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

                                // Récupérer la position actuelle
                                Position position = await _getCurrentLocation();

                                // Vérification et récupération des données de localisation
                                double latitude = position.latitude;
                                double longitude = position.longitude;

                                Map<String, dynamic> datalogin = {
                                  "login": state.field!["prenom"],
                                  "pwd": state.field!["password"],
                                  "latitude": latitude,
                                  "longitude": longitude,
                                };

                                print(datalogin);

                                TransAcademiaLoadingDialog.show(context);
                                Map<String, dynamic> result =
                                    await SignUpRepository.login(datalogin);
                                int statusCode = result['status'];
                                Map? data = result['data'];

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

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/routestack',
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
