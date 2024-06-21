import 'package:flutter/material.dart';

// Classe pour représenter un agent
class Agent {
  final String nom;
  final String prenom;
  final String postnom;
  final String date;
  final String heureArrivee;
  final String heureCloture;
  final String photoUrl;

  Agent({
    required this.nom,
    required this.prenom,
    required this.postnom,
    required this.date,
    required this.heureArrivee,
    required this.heureCloture,
    required this.photoUrl,
  });
}

class HisoriquePresence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Historique de présence',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: HistoriquePresenceScreen(),
    );
  }
}

class HistoriquePresenceScreen extends StatelessWidget {
  // Liste statique d'agents pour l'exemple
  final List<Agent> agents = [
    Agent(
      nom: 'Doe',
      prenom: 'John',
      postnom: 'Smith',
      date: '2023-06-18',
      heureArrivee: '08:00',
      heureCloture: '17:00',
      photoUrl:
          'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg',
    ),
    Agent(
      nom: 'Doe',
      prenom: 'Jane',
      postnom: 'Smith',
      date: '2023-06-18',
      heureArrivee: '09:00',
      heureCloture: '18:00',
      photoUrl:
          'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg',
    ),
    Agent(
      nom: 'Doe',
      prenom: 'Jane',
      postnom: 'Smith',
      date: '2023-06-18',
      heureArrivee: '09:00',
      heureCloture: '18:00',
      photoUrl:
          'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg',
    ),
    Agent(
      nom: 'Doe',
      prenom: 'Jane',
      postnom: 'Smith',
      date: '2023-06-18',
      heureArrivee: '09:00',
      heureCloture: '18:00',
      photoUrl:
          'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg',
    ),
    Agent(
      nom: 'Doe',
      prenom: 'Jane',
      postnom: 'Smith',
      date: '2023-06-18',
      heureArrivee: '09:00',
      heureCloture: '18:00',
      photoUrl:
          'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg',
    ),
    Agent(
      nom: 'Doe',
      prenom: 'Jane',
      postnom: 'Smith',
      date: '2023-06-18',
      heureArrivee: '09:00',
      heureCloture: '18:00',
      photoUrl:
          'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg',
    ),
    Agent(
      nom: 'Doe',
      prenom: 'Jane',
      postnom: 'Smith',
      date: '2023-06-18',
      heureArrivee: '09:00',
      heureCloture: '18:00',
      photoUrl:
          'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg',
    ),
    Agent(
      nom: 'Doe',
      prenom: 'Jane',
      postnom: 'Smith',
      date: '2023-06-18',
      heureArrivee: '09:00',
      heureCloture: '18:00',
      photoUrl:
          'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg',
    ),
    Agent(
      nom: 'Doe',
      prenom: 'Jane',
      postnom: 'Smith',
      date: '2023-06-18',
      heureArrivee: '09:00',
      heureCloture: '18:00',
      photoUrl:
          'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg',
    ),
    Agent(
      nom: 'Doe',
      prenom: 'Jane',
      postnom: 'Smith',
      date: '2023-06-18',
      heureArrivee: '09:00',
      heureCloture: '18:00',
      photoUrl:
          'https://conflictresolutionmn.org/wp-content/uploads/2020/01/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg',
    ),
    // Ajoutez d'autres agents ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique de présence'),
        backgroundColor: Colors.lightGreen.withOpacity(0.8),
      ),
      body: ListView.builder(
        itemCount: agents.length,
        itemBuilder: (context, index) {
          final agent = agents[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(agent.photoUrl),
                  backgroundColor: Colors.grey[200],
                ),
                title: Text(
                  '${agent.nom} ${agent.prenom} ${agent.postnom}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Date : ${agent.date}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Heure d\'arrivée : ${agent.heureArrivee}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Heure de clôture : ${agent.heureCloture}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
