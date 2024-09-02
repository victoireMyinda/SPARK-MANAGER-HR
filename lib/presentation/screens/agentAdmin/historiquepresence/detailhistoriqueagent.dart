import 'dart:convert';
import 'dart:io';
import 'package:sparkmanager_rh/presentation/screens/agentAdmin/agents/localisation.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

class DetailHistoriqueAgent extends StatefulWidget {
  DetailHistoriqueAgent({super.key, this.data});
  final Map? data;

  @override
  _DetailHistoriqueAgentState createState() => _DetailHistoriqueAgentState();
}

class _DetailHistoriqueAgentState extends State<DetailHistoriqueAgent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    // Récupération des données pointings
    List<dynamic> pointings = widget.data?['pointings'] ?? [];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  color: Colors.lightGreen.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.arrow_back_outlined,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${widget.data!["firstname"]} ${widget.data!["lastname"]} ${widget.data!["as_user"]["username"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

               const  SizedBox(height: 40,),
                pointings.isEmpty
                    ? Expanded(
                        child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Lottie.asset("assets/images/last-transaction.json",
                              height: 200),
                          const Text("Aucune donnée trouvée.")
                        ],
                      ))
                    : Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView.builder(
                              itemCount: pointings.length,
                              itemBuilder: (context, index) {
                                final pointing = pointings[index];
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  elevation: 2,
                                  child: ListTile(
                                    leading: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LocationScreen(
                                              agentName:
                                                  '${widget.data!["as_user"]["username"]}',
                                              latitude: pointing["location"]
                                                  ["lat"],
                                              longitude: pointing["location"]
                                                  ["lng"],
                                              action: pointing["action"],
                                              date: pointing["created_at"],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.green,
                                      ),
                                    ),
                                    title:
                                        Text('Action: ${pointing["action"]}'),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Location: Lat ${pointing["location"]["lat"]}, Lng ${pointing["location"]["lng"]}'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            const Positioned(
              top: 60,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/user.jpg'),
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
