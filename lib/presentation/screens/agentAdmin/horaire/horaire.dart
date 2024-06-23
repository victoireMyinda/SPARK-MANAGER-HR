import 'package:flutter/material.dart';
import 'package:location_agent/data/repository/signUp_repository.dart';


class HoraireScreen extends StatefulWidget {
  final bool? backNavigation;

  HoraireScreen({super.key, this.backNavigation});

  @override
  _HoraireScreenState createState() => _HoraireScreenState();
}

class _HoraireScreenState extends State<HoraireScreen> {
  // Liste des horaires
  List<Map<String, String>> schedules = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSchedules(); // Récupère les horaires lors de l'initialisation
  }

  // Fonction pour récupérer les horaires depuis l'API
  Future<void> _fetchSchedules() async {
    try {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic> result = await SignUpRepository.getHoraire();
      
      if (result['status'] == 200) {
        setState(() {
          schedules = List<Map<String, String>>.from(result['data'].map((item) {
            return {
              'arrival': item['start'],
              'departure': item['end'],
            };
          }));
        });
      } else {
        // TransAcademiaDialogError.show(context, "Erreur lors de la récupération des horaires", "login");
      }
    } catch (error) {
      // TransAcademiaDialogError.show(context, "Erreur: $error", "login");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fonction pour ajouter un nouvel horaire
  Future<void> _addSchedule(String arrival, String departure) async {
    Map<String, dynamic> dataHoraire = {
      "start": arrival,
      "end": departure,
      "action": "DEPART",
    };

    // TransAcademiaLoadingDialog.show(context);
    Map<String, dynamic> result = await SignUpRepository.createHoraire(dataHoraire);
    // TransAcademiaLoadingDialog.stop(context);

    if (result['status'] == 201) {
      _fetchSchedules(); // Actualise les horaires après l'ajout
    } else {
      // TransAcademiaDialogError.show(context, "Erreur lors de la création de l'horaire", "login");
    }
  }

  // Fonction pour mettre à jour les horaires
  Future<void> _updateSchedule(int index, String newArrival, String newDeparture) async {
    // Ici, ajoutez la logique pour mettre à jour l'horaire via l'API, si nécessaire.
    setState(() {
      schedules[index]['arrival'] = newArrival;
      schedules[index]['departure'] = newDeparture;
    });
  }

  // Fonction pour supprimer un horaire
  Future<void> _deleteSchedule(int index) async {
    // Ici, ajoutez la logique pour supprimer l'horaire via l'API, si nécessaire.
    setState(() {
      schedules.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horaires de Travail'),
        backgroundColor: Colors.lightGreen.withOpacity(0.5),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator()) // Affiche un indicateur de chargement si les données sont en cours de chargement
            : schedules.isEmpty
                ? Center(child: Text('Aucun horaire disponible.'))
                : ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: ListTile(
                          title: Text('Arrivée: ${schedules[index]['arrival']}'),
                          subtitle: Text('Clôture: ${schedules[index]['departure']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditDialog(context, index);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _showDeleteConfirmDialog(context, index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        tooltip: 'Ajouter un Horaire',
        backgroundColor: Colors.lightGreen.withOpacity(0.5),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    TextEditingController arrivalController = TextEditingController();
    TextEditingController departureController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter un horaire'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: arrivalController,
                decoration: const InputDecoration(labelText: 'Heure d\'Arrivée'),
              ),
              TextField(
                controller: departureController,
                decoration: const InputDecoration(labelText: 'Heure de Clôture'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Ferme le dialog
                await _addSchedule(arrivalController.text, departureController.text);
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    TextEditingController arrivalController = TextEditingController(text: schedules[index]['arrival']);
    TextEditingController departureController = TextEditingController(text: schedules[index]['departure']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier l\'Horaire'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: arrivalController,
                decoration: const InputDecoration(labelText: 'Heure d\'Arrivée'),
              ),
              TextField(
                controller: departureController,
                decoration: const InputDecoration(labelText: 'Heure de Clôture'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Ferme le dialog
                await _updateSchedule(index, arrivalController.text, departureController.text);
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmer la Suppression'),
          content: const Text('Voulez-vous vraiment supprimer cet horaire ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Ferme le dialog
                await _deleteSchedule(index);
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }
}
