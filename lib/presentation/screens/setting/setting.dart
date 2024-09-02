import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkmanagerRH/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  bool backNavigation = false;
  SettingScreen({Key? key, required this.backNavigation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), backgroundColor: Colors.lightGreen.withOpacity(0.8)),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  height: 250,
                  color: Colors.lightGreen.withOpacity(0.8),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/images/user.jpg'), // Remplacez par le chemin de votre image
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {
                    return Text(
                      state.field!["data"]["firstname"] +
                          " " +
                          state.field!["data"]["lastname"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(height: 8),
                BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {
                    return Text(
                      state.field!["data"]["poste"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Action de modification du profil
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Modifier le profil'),
                ),
                const SizedBox(height: 16),
                ProfileDetail(
                  icon: Icons.info,
                  text: 'À propos',
                  onTap: () {
                    // Action pour "À propos"
                  },
                ),

                const Divider(thickness: 1,),
                // ProfileDetail(
                //   icon: Icons.location_on,
                //   text: 'Localisation',
                //   onTap: () {
                //     // Action pour "Localisation"
                //   },
                // ),
                ProfileDetail(
                  icon: Icons.person,
                  text: 'Profil',
                  onTap: () {
                    // Action pour "Profil"
                  },
                ),
                const Divider(thickness: 1,),
                ProfileDetail(
                  icon: Icons.logout,
                  text: 'Déconnexion',
                  onTap: () async {
                    // BlocProvider.of<SignupCubit>(context)
                    //     .updateField(context, field: "phone", data: "");
                    // BlocProvider.of<SignupCubit>(context)
                    //     .updateField(context, field: "password", data: "");
                    // BlocProvider.of<SignupCubit>(context)
                    //     .updateField(context, field: "nom", data: "");

                    // BlocProvider.of<SignupCubit>(context)
                    //     .updateField(context, field: "postnom", data: "");
                    // BlocProvider.of<SignupCubit>(context)
                    //     .updateField(context, field: "prenom", data: "");
                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // prefs.getBool('first');

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login', (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ProfileDetail({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.lightGreen.withOpacity(0.8),
      ),
      title: Text(text),
      onTap: onTap,
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
