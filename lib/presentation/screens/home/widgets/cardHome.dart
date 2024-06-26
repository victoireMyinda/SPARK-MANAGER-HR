// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CardLocalisation extends StatefulWidget {
  final String? label, title;
  const CardLocalisation({super.key, this.title, this.label});

  @override
  State<CardLocalisation> createState() => _CardLocalisationState();
}

class _CardLocalisationState extends State<CardLocalisation> {
  late GoogleMapController mapController;
  final Map<String, Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      
      // padding: const EdgeInsets.all(20),
      // decoration: const BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: const BorderRadius.all(
      //     Radius.circular(20),
      //   ),
      // ),
      child: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(4.0383, 21.7587),
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        // Ajoutez votre clé d'API ici
        // Le paramètre 'mapType' spécifie le type de carte (par défaut, normal)
        // Le paramètre 'myLocationEnabled' active le bouton pour afficher la position actuelle de l'utilisateur sur la carte
        // Le paramètre 'compassEnabled' active le bouton de la boussole pour l'orientation de la carte
        // Le paramètre 'zoomControlsEnabled' active les boutons de zoom sur la carte
        // Vous pouvez également définir d'autres options selon vos besoins
        markers: Set<Marker>.of(markers.values),
        onCameraMove: _onCameraMove,
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    // Mettre à jour la position de la caméra
  }
}
