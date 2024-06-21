// ignore_for_file: prefer_const_constructors

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location_agent/presentation/screens/abonnement/abonnement.dart';
import 'package:location_agent/presentation/screens/agentAdmin/agents/listeagent.dart';
import 'package:location_agent/presentation/screens/agentAdmin/sites/sites.dart';
// import 'package:location_agent/responsive.dart';
import 'package:location_agent/presentation/screens/home/home_screen.dart';
import 'package:location_agent/presentation/screens/horaire/horaire.dart';
import 'package:location_agent/presentation/screens/qrcode/qrcode.dart';
import 'package:location_agent/presentation/screens/setting/setting.dart';
import 'package:location_agent/sizeconfig.dart';
import 'package:location_agent/theme.dart';

class RouteStack extends StatefulWidget {
  const RouteStack({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RouteStackState createState() => _RouteStackState();
}

class _RouteStackState extends State<RouteStack>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ignore: prefer_final_fields
  List<Widget> _screens = [
    HomeScreen(),
    ListeAgentsScreen(backNavigation: false),
    HoraireAgentScreen(backNavigation: false),
    ListSitesScreen(backNavigation: false),
    SettingScreen(backNavigation: false),
  ];

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    super.build(context);
    return Scaffold(
        // backgroundColor: const Color(0xFFFFFFFF),
        body: PageView(
          controller: pageController,
          onPageChanged: _onPageChanged,
          children: _screens,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar:
            bottomNavigationBar(_selectedIndex, _onItemTapped, context));
  }

  @override
  bool get wantKeepAlive => true;
}

Widget bottomNavigationBar(_selectedIndex, _onItemTapped, context) {
  return Container(
    // color: Colors.grey.withOpacity(0.1),
    // padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    child: ClipRRect(
      // borderRadius: const BorderRadius.only(
      //   topRight: Radius.circular(30),
      //   topLeft: Radius.circular(30),
      //   bottomLeft: Radius.circular(30),
      //   bottomRight: Radius.circular(30),
      // ),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // backgroundColor: const Color(0xFFffffff),
          backgroundColor: Theme.of(context).accentColor,
          selectedItemColor: Colors.lightGreen.withOpacity(0.5),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            // ignore: prefer_const_constructors
            BottomNavigationBarItem(
                label: "Accueil",
                icon: SvgPicture.asset("assets/icons/accueil-trans-grey.svg",
                    width: 20,
                    color: _selectedIndex == 0
                        ? Colors.lightGreen.withOpacity(0.5)
                        : null)),
            BottomNavigationBarItem(
                label: "Agents",
                icon: SvgPicture.asset("assets/icons/user-adds.svg",
                    width: 20,
                    color: _selectedIndex == 1
                        ? Colors.lightGreen.withOpacity(0.5)
                        : null)),
            // BottomNavigationBarItem(
            //     label: "",
            //     // icon: Icon(Icons.add_circle_outline, size: 40,color: Colors.grey.withOpacity(0.5),)
            //     icon: Container(
            //         padding: const EdgeInsets.all(10.0),
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //                 width: 1,
            //                 color: _selectedIndex == 2
            //                     ? Colors.lightGreen.withOpacity(0.5)
            //                     : Colors.grey),
            //             borderRadius: BorderRadius.circular(50.0)),
            //         child: SvgPicture.asset(
            //           _selectedIndex == 2
            //               ? "assets/icons/qrcode-trans.svg"
            //               : "assets/icons/qrcode-trans-grey1.svg",
            //           width: 20,
            //         ))),
            BottomNavigationBarItem(
                label: "Horaire",
                icon: SvgPicture.asset("assets/icons/notif-trans-grey.svg",
                    width: 20,
                    color: _selectedIndex == 2
                        ? Colors.lightGreen.withOpacity(0.5)
                        : null)),
            BottomNavigationBarItem(
                label: "Site",
                // icon: Icon(Icons.add_circle_outline, size: 40,color: Colors.grey.withOpacity(0.5),)
                icon: SvgPicture.asset("assets/icons/site.svg",
                    width: 20,
                    color: _selectedIndex == 3
                        ? Colors.lightGreen.withOpacity(0.5)
                        : null)),
            BottomNavigationBarItem(
                label: "Réglage",
                // icon: Icon(Icons.add_circle_outline, size: 40,color: Colors.grey.withOpacity(0.5),)
                icon: SvgPicture.asset("assets/icons/setting-trans-grey.svg",
                    width: 20,
                    color: _selectedIndex == 4
                        ? Colors.lightGreen.withOpacity(0.5)
                        : null)),
            // const BottomNavigationBarItem(
            //   label: "favoris",
            //   icon: Icon(Icons.notifications_none)
            // ),
            // const BottomNavigationBarItem(
            //   label: "favoris",
            //   icon: CircleAvatar(
            //     radius: 24,
            //     backgroundColor:Color(0xFFe84673),
            //     child:CircleAvatar(
            //     radius: 22,
            //     backgroundColor:Colors.white,
            //     child: CircleAvatar(
            //       backgroundColor:Colors.grey ,
            //       radius: 20, backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Profil_Avatar_S.jpg/575px-Profil_Avatar_S.jpg"),
            //       ))
            //   )

            // ),
          ]),
    ),
  );
}
