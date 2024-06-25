import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_agent/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key, required this.backNavigation}) : super(key: key);
  bool backNavigation = false;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.lightGreen.withOpacity(0.5),
              Colors.white70,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: -50,
                  child: CircleAvatar(
                    radius: 60,
                    // backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg', // Remplacer par l'URL de l'avatar de l'utilisateur
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
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
            SizedBox(height: 10),
            BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
                return Center(
                  child: Text(
                    '${state.field!["data"]["grade"]}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                // Ajouter la logique de déconnexion ici
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Déconnexion"),
                      content:
                          Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
                      actions: <Widget>[
                        BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return TextButton(
                              child: Text("Annuler"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                        BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return TextButton(
                              child: const Text("Confirmer"),
                              onPressed: () async {
                                BlocProvider.of<SignupCubit>(context)
                                    .updateField(context,
                                        field: "phone", data: "");
                                BlocProvider.of<SignupCubit>(context)
                                    .updateField(context,
                                        field: "password", data: "");
                                BlocProvider.of<SignupCubit>(context)
                                    .updateField(context,
                                        field: "nom", data: "");

                                BlocProvider.of<SignupCubit>(context)
                                    .updateField(context,
                                        field: "postnom", data: "");
                                BlocProvider.of<SignupCubit>(context)
                                    .updateField(context,
                                        field: "prenom", data: "");
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.clear();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/login', (Route<dynamic> route) => false);
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.logout),
              label: Text('Déconnexion'),
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.lightGreen.withOpacity(0.5), // Couleur du bouton
                onPrimary: Colors.white, // Couleur du texte
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
