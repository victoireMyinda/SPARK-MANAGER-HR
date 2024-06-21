import 'package:flutter/material.dart';
import 'package:location_agent/constants/my_colors.dart';
import 'package:location_agent/presentation/screens/agentAdmin/sites/signupsite.dart';
import 'package:location_agent/presentation/widgets/appbarkelasi.dart';

class DetailSitesScreen extends StatefulWidget {
  Map? data;
  DetailSitesScreen({
    super.key, required this.data
  });

  @override
  State<DetailSitesScreen> createState() => _DetailSitesScreenState();
}

class _DetailSitesScreenState extends State<DetailSitesScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          backgroundColor: Colors.white,
          title: "Detail site",
          leftIcon: "assets/icons/rowback-icon.svg",
          sizeleftIcon: 11,
          onTapFunction: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/site.jpg'),
                        fit: BoxFit.cover,
                      ),
                   
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  // color: Colors.grey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.data!["name"]}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: MyColors.myBrown,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.delete_outlined,
                                color: MyColors.myBrown,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupSite()),
                                  );
                                },
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: MyColors.myBrown,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Localisation",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text("${widget.data!["location"]}",
                              style: const TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Province",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text("Kinshasa",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Ville",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("Kinshasa",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Commune",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("Masina",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                     
                        const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Agent affecté",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("Victoire myinda",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Date de mise à jour",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("${widget.data!["updated_at"]}",
                              style: const TextStyle(fontWeight: FontWeight.w300))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
