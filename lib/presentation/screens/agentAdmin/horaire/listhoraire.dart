import 'package:flutter/material.dart';
import 'package:sparkmanager_rh/data/repository/signUp_repository.dart';
import 'package:sparkmanager_rh/presentation/screens/agentAdmin/agents/widget/cardplaceholderagent.dart';
import 'package:sparkmanager_rh/presentation/screens/agentAdmin/horaire/signuphoraire.dart';
import 'package:sparkmanager_rh/presentation/screens/agentAdmin/horaire/widget/cardhoraire.dart';
import 'package:lottie/lottie.dart';

class HorairesScreen extends StatefulWidget {
  bool? backNavigation = false;
  HorairesScreen({
    super.key,
    required this.backNavigation,
  });

  @override
  State<HorairesScreen> createState() => _HorairesScreenState();
}

class _HorairesScreenState extends State<HorairesScreen> {
  List? dataHoraire = [];
  bool isLoading = true;
  int dataHoraireLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? idParent = prefs.getString("parentId");
    Map? response = await SignUpRepository.getHoraire();
    List? horaires = response["data"];

    // print(response["data"]);
    setState(() {
      dataHoraire = horaires;
      isLoading = false;
      dataHoraireLength = horaires!.length;
      // dataHoraire = Horaires.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen.withOpacity(0.5),
          title: const Text("Horaires de travail"),
          
        ),
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  SignupHoraireScreen()),
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0XFF055905),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:const [
                    Text(
                      "Horaire officiel de travail",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    
                  ],
                ),
              ),
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
                  : dataHoraireLength == 0
                      ? Column(
                          children: [
                            Lottie.asset("assets/images/last-transaction.json",
                                height: 200),
                            const Text("Aucun agent n'a été enregistré.")
                          ],
                        )
                      : Flexible(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: dataHoraire!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CardHoraire(data: dataHoraire![index]);
                              }),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
