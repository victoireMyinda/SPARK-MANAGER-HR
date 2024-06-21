import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_agent/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:location_agent/constants/my_colors.dart';
import 'package:location_agent/data/repository/signUp_repository.dart';
import 'package:location_agent/presentation/screens/agentAdmin/sites/sites.dart';
import 'package:location_agent/presentation/widgets/appbarkelasi.dart';
import 'package:location_agent/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:location_agent/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:location_agent/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:location_agent/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:location_agent/presentation/widgets/dialog/loading.dialog.dart';
import 'package:location_agent/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:location_agent/presentation/widgets/inputs/nameField.dart';
import 'package:location_agent/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:location_agent/sizeconfig.dart';

class SignupSite extends StatefulWidget {
  const SignupSite({super.key});

  @override
  State<SignupSite> createState() => _SignupSiteState();
}

class _SignupSiteState extends State<SignupSite> {
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color(0xffF2F2F2),
          child: Column(
            children: [
              AppBarKelasi(
                title: "Enregistrement du site",
                leftIcon: "assets/icons/rowback-icon.svg",
                backgroundColor: Colors.white,
                onTapFunction: () => Navigator.of(context).pop(),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).mode.name != "dark"
                              ? Colors.white
                              : Colors.black,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/icc.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Color(0XFF055905), width: 1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(height: 30),
                                  Text(
                                    "Vueillez renseigner les informations du site",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(height: 10),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      hintText: "Nom du site",
                                      field: "nomsite",
                                      label: "Nom du site",
                                      fieldValue: state.field!["nomsite"],
                                    ),
                                  ));
                            }),
                            const SizedBox(height: 10),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      hintText: "Localisation",
                                      field: "localisationsite",
                                      label: "Localisation",
                                      fieldValue:
                                          state.field!["localisationsite"],
                                    ),
                                  ));
                            }),
                            const SizedBox(height: 10),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  // margin: const EdgeInsets.only(bottom: 15, top: 20),
                                  child: SizedBox(
                                    height: 50.0,
                                    child: TransAcademiaPhoneNumber(
                                      number: 20,
                                      controller: phoneController,
                                      hintText: "Numéro de téléphone",
                                      field: "phone",
                                      fieldValue: state.field!["phone"],
                                    ),
                                  ));
                            }),
                            const SizedBox(height: 10),
                            const TransAcademiaDropdown(
                              items: "provinceData",
                              value: "province",
                              label: "Choisir la province",
                              hintText: "Choisir la province",
                            ),
                            const SizedBox(height: 10),
                            const TransAcademiaDropdown(
                              items: "villeData",
                              value: "ville",
                              label: "Choisir la ville",
                              hintText: "Choisir la ville",
                            ),
                            const SizedBox(height: 10),
                            const TransAcademiaDropdown(
                              items: "communeData",
                              value: "commune",
                              label: "Choisir la commune",
                              hintText: "Choisir la commune",
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<SignupCubit, SignupState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () async {
                                         Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/home',
                                                    (Route<dynamic> route) =>
                                                        false);
                                //         if (state.field!["nomsite"] == "") {
                                //           BlocProvider.of<SignupCubit>(context)
                                //               .updateField(context,
                                //                   field: "nomsiteError",
                                //                   data: "error");
                                //           ValidationDialog.show(context,
                                //               "Veuillez renseigner le nom du site",
                                //               () {
                                //             if (kDebugMode) {
                                //               print("modal");
                                //             }
                                //           });
                                //           return;
                                //         }

                                //         if (state.field!["localisationsite"] ==
                                //             "") {
                                //           BlocProvider.of<SignupCubit>(context)
                                //               .updateField(context,
                                //                   field:
                                //                       "localisationsiteError",
                                //                   data: "error");
                                //           ValidationDialog.show(context,
                                //               "Veuillez indiquer le nom de la localisation",
                                //               () {
                                //             if (kDebugMode) {
                                //               print("modal");
                                //             }
                                //           });
                                //           return;
                                //         }
                                //        if (state.field!["phone"] == "") {
                                //   ValidationDialog.show(context,
                                //       "Veuillez saisir le numéro de téléphone",
                                //       () {
                                //     if (kDebugMode) {
                                //       print("modal");
                                //     }
                                //   });
                                //   return;
                                // }

                                // if (state.field!["phone"].substring(0, 1) ==
                                //         "0" ||
                                //     state.field!["phone"].substring(0, 1) ==
                                //         "+") {
                                //   ValidationDialog.show(context,
                                //       "Veuillez saisir le numéro avec le format valide, par exemple: (816644420).",
                                //       () {
                                //     print("modal");
                                //   });
                                //   return;
                                // }

                                // if (state.field!["phone"]
                                //             .substring(0, 1) ==
                                //         "1" ||
                                //     state.field!["phone"]
                                //             .substring(0, 1) ==
                                //         "2" ||
                                //     state.field!["phone"]
                                //             .substring(0, 1) ==
                                //         "3" ||
                                //     state.field!["phone"]
                                //             .substring(0, 1) ==
                                //         "4" ||
                                //     state.field!["phone"]
                                //             .substring(0, 1) ==
                                //         "5" ||
                                //     state.field!["phone"].substring(0, 1) ==
                                //         "6" ||
                                //     state.field!["phone"].substring(0, 1) ==
                                //         "7") {
                                //   ValidationDialog.show(context,
                                //       "Veuillez saisir le numéro avec le format valide, par exemple: (816644420).",
                                //       () {
                                //     print("modal");
                                //   });
                                //   return;
                                // }

                                //         Map data = {
                                //           "name": state.field!["nomsite"],
                                //           "location":
                                //               state.field!["localisationsite"],
                                //           "contacts": state.field!["phone"],
                                //           "ID_province": 1,
                                //           "ID_commune": 2,
                                //           "ID_ville": 1,
                                //           "ID_user_created_at":
                                //               state.field!["idUser"],
                                //         };

                                //         Map? response = await SignUpRepository
                                //             .createSiteCream(data);
                                //         // print(response);

                                //         int status = response["status"];
                                //         String? message = response["message"];

                                //         if (status == 201) {
                                //           TransAcademiaDialogSuccess.stop(
                                //                 context);
                                //           String? messageSucces =
                                //               "Site crée avec succès";
                                //           TransAcademiaDialogSuccess.show(
                                //               context, messageSucces, "Signup");

                                //           Future.delayed(
                                //               const Duration(
                                //                   milliseconds: 4000),
                                //               () async {
                                //             TransAcademiaDialogSuccess.stop(
                                //                 context);
                                //             Navigator.of(context)
                                //                 .pushNamedAndRemoveUntil(
                                //                     '/home',
                                //                     (Route<dynamic> route) =>
                                //                         false);
                                //           });
                                //         } else {
                                //           TransAcademiaLoadingDialog.stop(
                                //               context);
                                //           TransAcademiaDialogError.show(
                                //               context, message, "site");
                                //         }
                                      },
                                      child: const ButtonTransAcademia(
                                          width: 300, title: "Enregistrer"),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
