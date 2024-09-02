// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sparkmanagerRH/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:sparkmanagerRH/presentation/screens/agentAdmin/agents/listeagent.dart';
import 'package:sparkmanagerRH/presentation/screens/agentAdmin/historiquepresence/historiquepresence.dart';
import 'package:sparkmanagerRH/presentation/screens/agentAdmin/horaire/listhoraire.dart';

class CardMenu extends StatefulWidget {
  CardMenu({
    super.key,
  });

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.lightGreen.withOpacity(0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
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
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: Colors.green),
                          shape: BoxShape.circle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/user-add.svg",
                              width: 25,
                              // color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Agents",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HorairesScreen(backNavigation: false),
                          ),
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                           color: Colors.white,
                          // border: Border.all(color: Colors.green),
                          shape: BoxShape.circle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/notif-trans-grey.svg",
                              width: 25,
                              // color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Horaire",
                      style: TextStyle(
                         fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoriquePresence(backNavigation: false),
                          ),
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration:const BoxDecoration(
                           color: Colors.white,
                          // border: Border.all(color: Colors.green),
                          shape: BoxShape.circle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/site.svg",
                              width: 25,
                              // color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Historique presence",
                      style: TextStyle(
                         fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
