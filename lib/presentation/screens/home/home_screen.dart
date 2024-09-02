// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkmanager_rh/data/repository/signUp_repository.dart';
import 'package:sparkmanager_rh/presentation/screens/agentAdmin/agents/widget/cardplaceholderagent.dart';
import 'package:sparkmanager_rh/presentation/screens/home/widgets/CardPresence.dart';
import 'package:sparkmanager_rh/presentation/screens/home/widgets/cardPresenceToday.dart';
import 'package:sparkmanager_rh/presentation/screens/setting/setting.dart';
import 'package:sparkmanager_rh/presentation/widgets/imageview.dart';
import 'package:sparkmanager_rh/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:lottie/lottie.dart';
import 'widgets/cardMenu.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List? dataAgent = [];
  bool isLoading = true;
  int dataAgentLength = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    Map<String, dynamic>? response = await SignUpRepository.getAllPresence();
    List<dynamic>? allAgent = response["data"];

    setState(() {
      dataAgent = allAgent;
      isLoading = false;
      dataAgentLength = allAgent?.length ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.white,
      color: Colors.lightGreen.withOpacity(0.5),
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        loadData();
      },
      child: Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CardPresence()),
            );
          },
          child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0XFF055905),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: const Center(
                child: Text(
                  "Voir la carte",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )),
        ),
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
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return const Text("Admin");
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
                const SizedBox(height: 20),
                CardMenu(),
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Prensences du jour",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
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
                              Lottie.asset(
                                  "assets/images/last-transaction.json",
                                  height: 200),
                              const Text(
                                "Aucune presence renseignée.",
                              )
                            ],
                          )
                        : Flexible(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: dataAgent!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CardPresenceToday(
                                      data: dataAgent![index]);
                                }),
                          ),

                // Other widgets after GridView
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}
