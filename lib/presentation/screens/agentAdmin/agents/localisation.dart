import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatelessWidget {
  final String agentName;
  final String action;
  final String date;
  final double latitude;
  final double longitude;

  LocationScreen(
      {required this.agentName,
      required this.latitude,
      required this.longitude,
      required this.action,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.withOpacity(0.5),
        title: Text(
          'Localisation de $agentName',
          style: const TextStyle(fontSize: 14),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId(agentName),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: " agent ${agentName} : ${action} (${date})"),
          ),
        },
      ),
    );
  }
}
