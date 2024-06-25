// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location_agent/business_logic/cubit/signup/cubit/signup_cubit.dart';

class CardPresenceByAgent extends StatefulWidget {
  final Map? data;
  const CardPresenceByAgent({super.key, this.data});

  @override
  State<CardPresenceByAgent> createState() => _CardPresenceByAgentState();
}

class _CardPresenceByAgentState extends State<CardPresenceByAgent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => DetailAgentScreen(data: widget.data,)),
      //   );
      // },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 100,
          // width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                // widget.data!["photo_url"] == null
                //     ? SvgPicture.asset(
                //         "assets/icons/avatarkelasi.svg",
                //         width: 50,
                //       ) :
                SvgPicture.asset(
                  "assets/icons/avatarkelasi.svg",
                  width: 50,
                  color: Color(0XFF055905),
                )
              ]),
              const Spacer(),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text("Nom",style: TextStyle(fontSize: 12),),
                        BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                              
                                Text(
                                  '${state.field!["data"]["firstname"]} ${state.field!["data"]["lastname"]}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Action pointage",style: TextStyle(fontSize: 12),),
                        BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return Text(
                              widget.data!["action"],
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 11),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date",style: TextStyle(fontSize: 12),),
                        Text(widget.data!["created_at"],
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
