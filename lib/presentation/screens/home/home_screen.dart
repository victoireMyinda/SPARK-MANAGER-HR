// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_agent/presentation/screens/setting/setting.dart';
import 'package:location_agent/presentation/widgets/imageview.dart';
import 'package:location_agent/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'widgets/cardMenu.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(
                height: 20,
              ),

              CardMenu(),

              // Other widgets after GridView
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}
