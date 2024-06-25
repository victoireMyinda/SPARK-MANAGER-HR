// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_agent/data/repository/signUp_repository.dart';
import 'package:location_agent/presentation/screens/agentAdmin/agents/widget/cardplaceholderagent.dart';
import 'package:location_agent/presentation/screens/home/widgets/cardPresencebyagent.dart';
import 'package:location_agent/presentation/screens/setting/setting.dart';
import 'package:location_agent/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:location_agent/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:location_agent/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:location_agent/presentation/widgets/dialog/loading.dialog.dart';
import 'package:location_agent/presentation/widgets/imageview.dart';
import 'package:location_agent/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenAgent extends StatefulWidget {
  const HomeScreenAgent({Key? key}) : super(key: key);

  @override
  State<HomeScreenAgent> createState() => _HomeScreenAgentState();
}

class _HomeScreenAgentState extends State<HomeScreenAgent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var role;
  bool getAgent = false;
  bool getHistoriquePresence = false;
  bool getHoraire = false;
  bool getSignalerPresence = false;

  List? dataAgent = [];
  bool isLoading = true;
  int dataAgentLength = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idAgent = prefs.getString("idAgent");

    if (idAgent != null) {
      Map<String, dynamic>? response =
          await SignUpRepository.getPresenceByAgent(idAgent);
      List<dynamic>? allAgent = response["data"];

      setState(() {
        dataAgent = allAgent;
        isLoading = false;
        dataAgentLength = allAgent?.length ?? 0;
      });
    } else {
      // Gérer le cas où idAgent n'est pas trouvé dans SharedPreferences
      // Peut-être afficher un message d'erreur ou une action appropriée
    }
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
    String dateEtHeure =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(179, 246, 244, 244),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.notifications,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Text(state.field!["role"] == true
                                    ? "Admin"
                                    : "Agent");
                              },
                            ),
                            const SizedBox(height: 6),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Text(
                                  '${state.field!["data"]["firstname"]} ${state.field!["data"]["lastname"]}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen(
                                    backNavigation: false,
                                  )),
                        );
                      },
                      child: Ink(
                        child: BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return ImageViewerWidget(
                              url: state.field!["data"]["avatarUrl"] ??
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                              height: 40,
                              width: 40,
                              border: Border.all(
                                width: 2,
                                color: Colors.lightGreen.withOpacity(0.8),
                              ),
                              borderRadius: BorderRadius.circular(50),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Center(
                            child: Text(
                              '${state.field!["data"]["firstname"]} ${state.field!["data"]["lastname"]}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        dateEtHeure,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return ElevatedButton.icon(
                                  onPressed: () async {
                                    // Vérifier la connexion Internet
                                    try {
                                      final response =
                                          await InternetAddress.lookup(
                                              'www.google.com');
                                      if (response.isNotEmpty) {
                                        print("connected");
                                      }
                                    } on SocketException {
                                      ValidationDialog.show(context,
                                          "Pas de connexion internet !", () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    // Récupérer la position actuelle
                                    Position position =
                                        await _getCurrentLocation();

                                    // Vérification et récupération des données de localisation
                                    double latitude = position.latitude;
                                    double longitude = position.longitude;

                                    TransAcademiaLoadingDialog.show(context);
                                    Map? data = {
                                      "location": {
                                        "lat": latitude,
                                        "lng": longitude
                                      },
                                      "action": "ARRIVE",
                                      "agent": state.field!["data"]["_id"]
                                    };
                                    //  print(data);

                                    Map<String, dynamic> result =
                                        await SignUpRepository.presenceAgent(
                                            data);

                                    // Map? response = result['data'];

                                    if (result["status"] == 201) {
                                      TransAcademiaLoadingDialog.stop(context);
                                      TransAcademiaDialogSuccess.show(
                                          context,
                                          "Merci d'avoir signalé votre ARRIVEE",
                                          "Auth");

                                      Future.delayed(
                                          const Duration(milliseconds: 4000),
                                          () async {
                                        TransAcademiaDialogSuccess.stop(
                                            context);
                                      });
                                    } else {
                                      TransAcademiaLoadingDialog.stop(context);
                                      TransAcademiaDialogError.show(
                                          context, result["message"], "login");
                                    }
                                  },
                                  icon: const Icon(Icons.check_circle,
                                      color: Colors.white),
                                  label: const Text(
                                    'Présence',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                  ),
                                );
                              },
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return ElevatedButton.icon(
                                  onPressed: () async {
                                    // Vérifier la connexion Internet
                                    try {
                                      final response =
                                          await InternetAddress.lookup(
                                              'www.google.com');
                                      if (response.isNotEmpty) {
                                        print("connected");
                                      }
                                    } on SocketException {
                                      ValidationDialog.show(context,
                                          "Pas de connexion internet !", () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    // Récupérer la position actuelle
                                    Position position =
                                        await _getCurrentLocation();

                                    // Vérification et récupération des données de localisation
                                    double latitude = position.latitude;
                                    double longitude = position.longitude;

                                    TransAcademiaLoadingDialog.show(context);
                                    Map? data = {
                                      "location": {
                                        "lat": latitude,
                                        "lng": longitude
                                      },
                                      "action": "DEPART",
                                      "agent": state.field!["data"]["_id"]
                                    };
                                    print(data);

                                    Map<String, dynamic> result =
                                        await SignUpRepository.presenceAgent(
                                            data);

                                    Map? response = result['data'];

                                    if (result["status"] == 201) {
                                      TransAcademiaLoadingDialog.stop(context);
                                      TransAcademiaDialogSuccess.show(
                                          context,
                                          "Merci d'avoir signalé votre DEPART",
                                          "Auth");

                                      Future.delayed(
                                          const Duration(milliseconds: 4000),
                                          () async {
                                        TransAcademiaDialogSuccess.stop(
                                            context);
                                      });
                                    } else {
                                      TransAcademiaLoadingDialog.stop(context);
                                      TransAcademiaDialogError.show(
                                          context, result['message'], "login");
                                    }
                                  },
                                  icon: const Icon(Icons.check_circle,
                                      color: Colors.white),
                                  label: const Text(
                                    'Cloturer',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Mes presences",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              isLoading == true
                  ? Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return const CardAgentPlaceholder();
                        },
                      ),
                    )
                  : dataAgentLength == 0
                      ? Column(
                          children: [
                            Lottie.asset("assets/images/last-transaction.json",
                                height: 200),
                            const Text(
                              "Aucune donnée trouvée.",
                            )
                          ],
                        )
                      : Flexible(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: dataAgent!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CardPresenceByAgent(
                                    data: dataAgent![index]);
                              }),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
