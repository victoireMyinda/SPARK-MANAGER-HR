// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location_agent/constants/my_colors.dart';
import 'package:location_agent/presentation/screens/agentAdmin/historiquepresence/historiquepresence.dart';
import 'package:location_agent/presentation/screens/agentAdmin/sites/sites.dart';
import 'package:location_agent/presentation/screens/home/widgets/cardHome.dart';
import 'package:location_agent/presentation/widgets/imageview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location_agent/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:location_agent/presentation/screens/agentAdmin/agents/listeagent.dart';
import 'package:location_agent/sizeconfig.dart';
import 'widgets/cardMenu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var role;
  bool getAgent = false;
  bool getMesPresences = false;
  bool getHistoriquePresence = false;
  bool getHoraire = false;
  bool getSignalerPresence = false;

  var androidState;
  var iosState;

  Future _launchURL(url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole();
     
  }

  // checkVersion() async {
  //   WidgetsFlutterBinding.ensureInitialized();

  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   String buildNumber = packageInfo.buildNumber;

  //   print('build' + buildNumber);

  //   final response = await http.get(
  //       Uri.parse('https://api-bantou-store.vercel.app/api/v1/versionsagent'));

  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);

  //     print(data["android"]);

  //     androidState = data["android"];
  //     iosState = data["ios"];
  //     List<String> descriptionList = data["description"].split(",");

  //     BlocProvider.of<SignupCubit>(context).updateField(context,
  //         field: "descriptionVersion", data: data["description"]);

  //     if (Platform.isIOS == true) {
  //       if (int.parse(buildNumber) < int.parse(iosState)) {
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "iconVersion", data: "assets/images/update.json");
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "titreVersion", data: "Découvrez les nouveautés");
  //         Navigator.of(context).pushNamedAndRemoveUntil(
  //             '/version', (Route<dynamic> route) => false,
  //             arguments: descriptionList);
  //       } else {
  //         print('ok');
  //         return;
  //       }
  //     }

  //     if (Platform.isIOS == false) {
  //       if (int.parse(buildNumber) < int.parse(androidState)) {
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "iconVersion", data: "assets/images/update.json");
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "titreVersion", data: "Découvrez les nouveautés");
  //         Navigator.of(context).pushNamedAndRemoveUntil(
  //             '/version', (Route<dynamic> route) => false,
  //             arguments: descriptionList);
  //         // return;
  //       } else {
  //         print('ok');
  //       }
  //     }
  //   } else {
  //     print('error');
  //   }
  // }

  getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getBool('role')!;
      if (role == true) {
        getAgent = true;
        getHistoriquePresence = true;
        getHoraire = true;
        getMesPresences = false;
        getSignalerPresence = false;
      } else {
        getAgent = false;
        getHistoriquePresence = false;
        getHoraire = false;
        getMesPresences = true;
        getSignalerPresence = true;
      }
    });
  }

  // getProfilAgent() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "idAgent", data: prefs.getString('id'));
  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "nom", data: prefs.getString('nom'));
  //   BlocProvider.of<SignupCubit>(context).updateField(context,
  //       field: "postnom", data: prefs.getString('postnom'));
  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "prenom", data: prefs.getString('prenom'));
  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "role", data: prefs.getString('fonction'));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawerMenu(context),
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(179, 246, 244, 244),
          width: MediaQuery.of(context).size.width,
          height: 700,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.notifications,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
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
                                    state.field!["data"]["firstname"] +
                                        " " +
                                        state.field!["data"]["lastname"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (Route<dynamic> route) => false);
                        },
                        child: Ink(
                          child: BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              return ImageViewerWidget(
                                url:
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
                      )
                    ],
                  ),
                ),
              ),

              // const Padding(
              //   padding: EdgeInsets.all(20.0),
              //   child: CardLocalisation(),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    // childAspectRatio: 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      if (getAgent == true)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ListeAgentsScreen(backNavigation: false),
                              ),
                            );
                          },
                          child: CardMenu(
                            icon: "assets/icons/user-adds.svg",
                            title: "Agents",
                            active: true,
                          ),
                        ),
                      if (getMesPresences == true)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ListSitesScreen(backNavigation: false),
                              ),
                            );
                          },
                          child: CardMenu(
                            icon: "assets/icons/site.svg",
                            title: "Mes presences",
                            active: true,
                          ),
                        ),
                      if (getHoraire == true)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ListeAgentsScreen(backNavigation: false),
                              ),
                            );
                          },
                          child: CardMenu(
                            icon: "assets/icons/user-adds.svg",
                            title: "Horaire",
                            active: true,
                          ),
                        ),
                      if (getHistoriquePresence == true)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HistoriquePresenceScreen(),
                              ),
                            );
                          },
                          child: CardMenu(
                            icon: "assets/icons/site.svg",
                            title: "Historique presence",
                            active: true,
                          ),
                        ),
                      if (getSignalerPresence == true)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HistoriquePresenceScreen(),
                              ),
                            );
                          },
                          child: CardMenu(
                            icon: "assets/icons/site.svg",
                            title: "Signaler presence",
                            active: true,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Other widgets after GridView
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerMenu(context) {
    final Uri _url = Uri.parse('https://trans-academia.cd');

    Future<void> launchUrlSite() async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }

    ToastContext().init(context);

    void showToast(String msg, {int? duration, int? gravity}) {
      Toast.show(msg, duration: duration, gravity: gravity);
    }

    return Drawer(
      backgroundColor: MyColors.myWhite,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              //  left: getProportionateScreenWidth(20),
              bottom: getProportionateScreenWidth(15),
            ),
            height: getProportionateScreenWidth(150),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    getProportionateScreenWidth(30),
                  ),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: 10),
                    child: SizedBox(
                      child: Row(
                        children: [
                          BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      // color: Color(0XFF055905),
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child:
                                      //  state.field!['photo'] == ''
                                      //     ?
                                      SvgPicture.asset(
                                    "assets/images/Avatar.svg",
                                    width: 40,
                                    // ignore: prefer_interpolation_to_compose_strings
                                  ));
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(10),
                            ),
                          ),
                          BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              return const Text(
                                "Teddy biringingwa",
                                // ignore: prefer_interpolation_to_compose_strings
                                // state.field!["prenom"].toString() +
                                //     " " +
                                //     state.field!["nom"].toString(),
                                style: TextStyle(
                                  color: Color(0XFF055905),
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                    height: 30, thickness: 5, color: Color(0XFF055905)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              return const Text(
                                "Agent terrain",
                                // ignore: prefer_interpolation_to_compose_strings
                                // state.field!["role"].toString() ==
                                //         'Point-Focaux'
                                //     ? "Point - Focal"
                                //     : state.field!["role"].toString(),
                                style: TextStyle(
                                  color: Color(0XFF055905),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //Liste title

          Container(
            margin: EdgeInsets.only(
              // left: getProportionateScreenWidth(20),
              bottom: getProportionateScreenWidth(20),
            ),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    getProportionateScreenWidth(30),
                  ),
                )),
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        // horizontal: getProportionateScreenWidth(10),
                        vertical: 30),
                    child: Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () async {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           const ActivityScreen()),
                              // );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(
                                  Icons.local_activity_outlined,
                                  color: Color(0XFF055905),
                                ),
                                SizedBox(
                                  width: 100.0,
                                  child: Text(
                                    "Nous contacter",
                                    style: TextStyle(
                                        // color: Colors.black87,
                                        // fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Divider(
                            height: 1,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () {
                              showToast("Bientôt disponible",
                                  duration: 3, gravity: Toast.bottom);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(
                                  Icons.help_outline_outlined,
                                  color: Color(0XFF055905),
                                ),
                                SizedBox(
                                  width: 100.0,
                                  child: Text(
                                    "A propos",
                                    style: TextStyle(
                                        // color: Colors.black87,
                                        // fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Divider(
                            height: 1,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () async {
                              BlocProvider.of<SignupCubit>(context).updateField(
                                  context,
                                  field: "phone",
                                  data: "");
                              BlocProvider.of<SignupCubit>(context).updateField(
                                  context,
                                  field: "motdepasse",
                                  data: "");
                              BlocProvider.of<SignupCubit>(context)
                                  .updateField(context, field: "nom", data: "");

                              BlocProvider.of<SignupCubit>(context).updateField(
                                  context,
                                  field: "postnom",
                                  data: "");
                              BlocProvider.of<SignupCubit>(context).updateField(
                                  context,
                                  field: "prenom",
                                  data: "");
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/login', (Route<dynamic> route) => false);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const LoginScreen()),
                              // );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(
                                  Icons.logout,
                                  color: Color(0XFF055905),
                                ),
                                SizedBox(
                                  width: 100.0,
                                  child: Text(
                                    "Déconnexion",
                                    style: TextStyle(
                                        // color: Colors.black87,
                                        // fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Divider(
                            height: 1,
                          ),
                          const SizedBox(
                            height: 130,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
