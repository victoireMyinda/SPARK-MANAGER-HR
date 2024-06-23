import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location_agent/presentation/screens/agentAdmin/agents/localisation.dart';
import 'package:location_agent/presentation/widgets/appbarkelasi.dart';

class DetailHistoriqueAgent extends StatefulWidget {
  Map? data;
  DetailHistoriqueAgent({super.key, required this.data});

  @override
  State<DetailHistoriqueAgent> createState() => _DetailHistoriqueAgentState();
}

class _DetailHistoriqueAgentState extends State<DetailHistoriqueAgent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          backgroundColor: Colors.white,
          title: "Detail agent",
          leftIcon: "assets/icons/rowback-icon.svg",
          sizeleftIcon: 11,
          onTapFunction: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/avatarkelasi.svg",
                      color: const Color(0XFF055905),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(20),
                  // color: Colors.grey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.data!["firstname"]} ${widget.data!["lastname"]} ${widget.data!["as_user"]["username"]}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0XFF055905),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Téléphone",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text(widget.data!["as_user"]["mobile_no"].toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Grade",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text(widget.data!["grade"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Poste",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(widget.data!["poste"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color(0XFF055905),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.my_location,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LocalisationScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Obtenir sa localisation",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
