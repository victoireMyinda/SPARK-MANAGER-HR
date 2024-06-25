import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_agent/data/repository/signUp_repository.dart';

class CardPresence extends StatefulWidget {
  CardPresence({Key? key}) : super(key: key);

  @override
  _CardPresenceState createState() => _CardPresenceState();
}

class _CardPresenceState extends State<CardPresence> {
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  BitmapDescriptor? agentIcon;

  @override
  void initState() {
    super.initState();
    // _loadCustomMarker();
    _fetchPresenceData();
  }

  // Future<void> _loadCustomMarker() async {
  //   agentIcon = await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(size: Size(48, 48)),
  //     'assets/images/user.jpg',
  //   );
  //   setState(() {});
  // }

  Future<void> _fetchPresenceData() async {
    try {
      final response = await SignUpRepository.getAllPresence();
      List? data = response["data"];

      if (data != null && data.isNotEmpty) {
        setState(() {
          for (var item in data) {
            if (item != null && item['location'] != null) {
              final double latitude = item['location']['lat'];
              final double longitude = item['location']['lng'];
              final String action = item['action'] ?? 'N/A';
              final String createdAt = item['created_at'] ?? 'N/A';
              final String markerId = item['_id'] ?? 'N/A';

              _markers.add(
                Marker(
                  markerId: MarkerId(markerId),
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(
                    title: action,
                    snippet: 'Pointé le: $createdAt',
                  ),
                  icon: agentIcon ?? BitmapDescriptor.defaultMarker,
                ),
              );
            }
          }
        });
      } else {
        print('Aucune donnée disponible.');
      }
    } catch (e) {
      print('Erreur lors de la récupération des données: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        _mapController = controller;
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(-4.3678433, 15.2520249), // Centrer la carte
        zoom: 14.0,
      ),
      markers: _markers,
    );
  }
}
