import 'package:flutter/material.dart';
import 'package:location_agent/presentation/screens/agentAdmin/historiquepresence/detailhistoriqueagent.dart';

class CardHistoriquePresence extends StatefulWidget {
  final Map? data;
  const CardHistoriquePresence({super.key, this.data});

  @override
  State<CardHistoriquePresence> createState() => _CardHistoriquePresenceState();
}

class _CardHistoriquePresenceState extends State<CardHistoriquePresence> {
  @override
  Widget build(BuildContext context) {
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
            backgroundImage: const NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9inRqaFfeNmYbm_Z_AwaICGOVqcRE-Of5Lw&s"),
            backgroundColor: Colors.grey[200],
          ),
          title: Text(
            "${widget.data!["firstname"]} ${widget.data!["lastname"]} ${widget.data!["as_user"]["username"]}",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Grade : ${widget.data!["grade"]}',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 4),
              Text(
                'Poste : ${widget.data!["poste"]}',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 4),
              Text(
                'Téléphone : ${widget.data!["as_user"]["mobile_no"].toString()}',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailHistoriqueAgent(
                          data: widget.data,
                        )),
              );
            },
          ),
        ),
      ),
    );
  }
}
