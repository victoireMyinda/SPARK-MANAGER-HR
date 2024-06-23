// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardHomeAgent extends StatefulWidget {
  String? icon;
  String? title;
  bool? active, isNotShadow;
  CardHomeAgent(
      {super.key,
      this.icon,
      this.title,
      required this.active,
      this.isNotShadow});

  @override
  State<CardHomeAgent> createState() => _CardHomeAgentState();
}

class _CardHomeAgentState extends State<CardHomeAgent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 225, 225, 225).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            widget.icon.toString(),
            color: Color.fromARGB(255, 131, 105, 95),
            height: 30,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.title.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

}
