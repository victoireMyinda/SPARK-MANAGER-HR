import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:http/http.dart' as http;
import 'package:sparkmanagerRH/business_logic/cubit/signup/cubit/signup_cubit.dart';

class KelasiDropdown extends StatefulWidget {
  const KelasiDropdown(
      {super.key,
      this.controller,
      this.value,
      this.color,
      this.label,
      this.hintText,
      this.validator,
      this.items,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  final String? value;
  final String? items;
  @override
  // ignore: library_private_types_in_public_api
  _KelasiDropdownState createState() => _KelasiDropdownState();
}

class _KelasiDropdownState extends State<KelasiDropdown> {
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();
  String? labelForDropdown;

  @override
  void initState() {
    super.initState();

    if (widget.value == "universite") {
      labelForDropdown = "abreviation";
    } else if (widget.value == "departement") {
      labelForDropdown = "Departement";
    } else if (widget.value == "promotion") {
      labelForDropdown = "Promotion";
    } else if (widget.value == "abonnement") {
      labelForDropdown = "Type";
    } else if (widget.value == "province") {
      labelForDropdown = "labele";
    } else if (widget.value == "product") {
      labelForDropdown = "description";
    } else if (widget.value == "productBySite") {
      labelForDropdown = "product";
    } else if (widget.value == "volume") {
      labelForDropdown = "name";
    } else if (widget.value == "operationnature") {
      labelForDropdown = "label";
    } else if (widget.value == "operationreason") {
      labelForDropdown = "label";
    } else if (widget.value == "ville") {
      labelForDropdown = "labele";
    } else if (widget.value == "commune") {
      labelForDropdown = "labele";
    } else if (widget.value == "level") {
      labelForDropdown = "label";
    } else if (widget.value == "users") {
      labelForDropdown = "prenom";
    } else if (widget.value == "site") {
      labelForDropdown = "name";
    } else {
      labelForDropdown = "libele";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _dropdownFormKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        height: 50,
        //margin: const EdgeInsets.only(bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
                return DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 20.0),
                    label: Text(widget.label.toString()),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      // borderSide: const BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                  ),
                  // validator: (value) =>
                  //     value == null ? "Selectionner l'université" : null,
                  dropdownColor: AdaptiveTheme.of(context).mode.name == "dark"
                      ? Colors.black
                      : Colors.white,
                  value: selectedValue,
                  onChanged: (newValue) {
                    setState(() {
                      selectedValue = newValue!.toString();
                    });

                    if (widget.value == "product") {
                      BlocProvider.of<SignupCubit>(context).updateField(context,
                          field: "product", data: newValue.toString());
                    }

                    if (widget.value == "productBySite") {
                      BlocProvider.of<SignupCubit>(context).updateField(context,
                          field: "productBySite", data: newValue.toString());
                    }

                    if (widget.value == "volume") {
                      BlocProvider.of<SignupCubit>(context).updateField(context,
                          field: "volume", data: newValue.toString());
                    }

                    if (widget.value == "site") {
                      BlocProvider.of<SignupCubit>(context).updateField(context,
                          field: "site", data: newValue.toString());
                    }

                    if (widget.value == "operationnature") {
                      BlocProvider.of<SignupCubit>(context).updateField(context,
                          field: "operationnature", data: newValue.toString());
                    }
                    if (widget.value == "operationreason") {
                      BlocProvider.of<SignupCubit>(context).updateField(context,
                          field: "operationreason", data: newValue.toString());
                    }
                  },
                  // items: dropdownItems
                  // items: state.field![widget.items]
                  //     .map<DropdownMenuItem<String>>((item) {
                  //   return DropdownMenuItem(
                  //     value: item['id'].toString(),
                  //     child: Text(
                  //       item![labelForDropdown].toString(),
                  //       style: const TextStyle(
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //   );
                  // }).toList(),
                  items: state.field![widget.items]
                      .map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem(
                      value: widget.value == "productBySite"
                          ? item['ID_product'].toString()
                          : item['ID'].toString(),
                      child: SizedBox(
                        width: 200.0,
                        child: Text(
                          item![labelForDropdown].toString(),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// List<DropdownMenuItem<String>> get dropdownItems {
//   List<DropdownMenuItem<String>> menuItems = [
//     DropdownMenuItem(child: Text("UNIKIN"), value: "Unikin"),
//     DropdownMenuItem(child: Text("ISTA"), value: "ISTA"),
//     DropdownMenuItem(child: Text("ISC"), value: "ISC"),
//     DropdownMenuItem(child: Text("ABA"), value: "ABA"),
//   ];
//   return menuItems;
// }

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 1,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.black26,
        width: 1,
      ));
}
