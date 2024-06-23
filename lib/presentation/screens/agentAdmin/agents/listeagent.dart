import 'package:flutter/material.dart';
import 'package:location_agent/data/repository/signUp_repository.dart';
import 'package:location_agent/presentation/screens/agentAdmin/agents/widget/cardagent.dart';
import 'package:location_agent/presentation/screens/agentAdmin/agents/widget/cardplaceholderagent.dart';
import 'package:location_agent/presentation/screens/signupagent/signupagent.dart';
import 'package:location_agent/presentation/widgets/appbarkelasi.dart';
import 'package:lottie/lottie.dart';

class ListeAgentsScreen extends StatefulWidget {
  bool? backNavigation = false;
  ListeAgentsScreen({
    super.key,
    required this.backNavigation,
  });

  @override
  State<ListeAgentsScreen> createState() => _ListeAgentsScreenState();
}

class _ListeAgentsScreenState extends State<ListeAgentsScreen> {
  List? dataAgent = [];
  bool isLoading = true;
  int dataAgentLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? idParent = prefs.getString("parentId");
    Map? response = await SignUpRepository.gettAllAgent();
    List? allAgent = response["data"];

    // print(response["data"]);
    setState(() {
      dataAgent = allAgent;
      isLoading = false;
      dataAgentLength = allAgent!.length;
      // dataAgent = allAgent.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen.withOpacity(0.5),
          title: const Text("Tous mes agents",)
         
        ),
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupAgent()),
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
                  children: [
                    const Text(
                      "Nombre d'agents",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      dataAgent!.length.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w500),
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
                  : dataAgentLength == 0
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
                              itemCount: dataAgent!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CartdAgent(data: dataAgent![index]);
                              }),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
