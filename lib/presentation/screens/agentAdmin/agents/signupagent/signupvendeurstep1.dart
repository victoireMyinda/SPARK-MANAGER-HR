import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkmanager_rh/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:sparkmanager_rh/constants/my_colors.dart';
import 'package:sparkmanager_rh/presentation/screens/agentAdmin/agents/signupagent/signupvendeurstep2.dart';
import 'package:sparkmanager_rh/presentation/widgets/appbarkelasi.dart';
import 'package:sparkmanager_rh/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:sparkmanager_rh/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:sparkmanager_rh/presentation/widgets/inputs/dateField.dart';
import 'package:sparkmanager_rh/presentation/widgets/inputs/dropdownSexe.dart';
import 'package:sparkmanager_rh/presentation/widgets/inputs/nameField.dart';
import 'package:sparkmanager_rh/presentation/widgets/inputs/passwordTextField.dart';
import 'package:sparkmanager_rh/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:sparkmanager_rh/presentation/widgets/stepIndicator.dart';
import 'package:sparkmanager_rh/sizeconfig.dart';

class SingupVendeurStep1 extends StatefulWidget {
  const SingupVendeurStep1({super.key});

  @override
  State<SingupVendeurStep1> createState() => _SingupVendeurStep1State();
}

class _SingupVendeurStep1State extends State<SingupVendeurStep1> {
  TextEditingController dateNaissanceController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "nom", data: "");

    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "postnom", data: "");
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "prenom", data: "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          title: "Enregistrement de l'agent",
          backgroundColor: Colors.white,
          leftIcon: "assets/icons/rowback-icon.svg",
          onTapFunction: () => Navigator.of(context).pop(),
          
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            //padding: const EdgeInsets.all(3),
            color: const Color(0xffF2F2F2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).mode.name != "dark"
                              ? Colors.white
                              : Colors.black,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        // height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
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
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const SizedBox(height: 40),
                                  const Text(
                                    "Veuillez renseigner l'identité de l'agent",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const TransAcademiaDropdownSexe(
                              value: "sexe",
                              label: "Choisir le sexe",
                              hintText: "choisir le sexe",
                            ),
                            const SizedBox(height: 20),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      // controller: phoneController,
                                      // isError: state.field!["prenomError"],
                                      hintText: "Prenom",
                                      field: "prenom",
                                      label: "Prenom",
                                      fieldValue: state.field!["prenom"],
                                    ),
                                  ));
                            }),

                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(
                                      bottom: 15, top: 20),
                                  child: SizedBox(
                                    height: 50.0,
                                    child: TransAcademiaPhoneNumber(
                                      number: 20,
                                      // controller: phoneController,
                                      hintText: "Numéro de téléphone",
                                      field: "phone",
                                      fieldValue: state.field!["phone"],
                                    ),
                                  ));
                            }),
                            const SizedBox(height: 15),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: SizedBox(
                                      height: 45.0,
                                      child: TransAcademiaPasswordField(
                                        isError: state.field!["passwordError"],
                                        label: "Mot de passe",
                                        hintText: "Mot de passe",
                                        field: "password",
                                        fieldValue: state.field!["password"],
                                      ),
                                    ));
                              },
                            ),
                            const SizedBox(height: 15),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: SizedBox(
                                      height: 45.0,
                                      child: TransAcademiaPasswordField(
                                        isError: state
                                            .field!["confirmPasswordError"],
                                        label: "Confirmer mot de passe",
                                        hintText: "Confirmer mot de passe",
                                        field: "confirmPassword",
                                        fieldValue:
                                            state.field!["confirmPassword"],
                                      ),
                                    ));
                              },
                            ),
                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                StepIndicatorWidget(
                                  color: Color(0XFF055905),
                                ),
                               
                                SizedBox(
                                  width: 10.0,
                                ),
                                StepIndicatorWidget(
                                  color: Colors.black26,
                                ),
                              ],
                            ),

                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<SignupCubit, SignupState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: ButtonTransAcademia(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          title: "Precedent"),
                                    );
                                  }),
                                  BlocBuilder<SignupCubit, SignupState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {

                                        if (state.field!["prenom"] == "") {
                                          BlocProvider.of<SignupCubit>(context)
                                              .updateField(context,
                                                  field: "prenomError",
                                                  data: "error");
                                          ValidationDialog.show(context,
                                              "Veuillez renseigner le prénom.",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }

                                        
                                        if (state.field!["phone"] == "") {
                                          BlocProvider.of<SignupCubit>(context)
                                              .updateField(context,
                                                  field: "phoneError",
                                                  data: "error");
                                          ValidationDialog.show(context,
                                              "Veuillez renseigner le numero du telephone.",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }
                                          
                                        if (state.field!["password"] == "") {
                                          BlocProvider.of<SignupCubit>(context)
                                              .updateField(context,
                                                  field: "password",
                                                  data: "error");
                                          ValidationDialog.show(context,
                                              "Veuillez renseigner le mot de passe.",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }
                                        if (state.field!["confirmPassword"] == "") {
                                          BlocProvider.of<SignupCubit>(context)
                                              .updateField(context,
                                                  field: "confirmPassword",
                                                  data: "error");
                                          ValidationDialog.show(context,
                                              "Veuillez confirmer le mot de passe.",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignupVendeurStep2()),
                                        );
                                      },
                                      child: ButtonTransAcademia(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          title: "Suivant"),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(30),
                            ),

                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.20,
                            // ),
                            //
                            // Text("A propos",style:GoogleFonts.montserrat(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
