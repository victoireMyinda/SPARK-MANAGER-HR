import 'package:flutter/material.dart';

class CardHoraire extends StatefulWidget {
  final Map? data;
  const CardHoraire({super.key, this.data});

  @override
  State<CardHoraire> createState() => _CardHoraireState();
}

class _CardHoraireState extends State<CardHoraire> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "https://i0.wp.com/www.possibility.fr/wp-content/uploads/2024/01/Horaires-et-productivite-scaled.jpg?fit=2560%2C1463&ssl=1",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Heure d'arriée : ${widget.data!["start"]}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Heure de cloture : ${widget.data!["end"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      InkWell(
                        child: Icon(Icons.edit,),
                      ),
                      InkWell(
                        child: Icon(Icons.delete, ),
                        // onPressed: onDelete,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
