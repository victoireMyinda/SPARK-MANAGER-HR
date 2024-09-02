import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sparkmanagerRH/data/repository/signUp_repository.dart';

class CardPresence extends StatefulWidget {
  CardPresence({Key? key}) : super(key: key);

  @override
  _CardPresenceState createState() => _CardPresenceState();
}

class _CardPresenceState extends State<CardPresence> {
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;

  List<Map<String, dynamic>> dataAgent = []; // List of agents
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    Map<String, dynamic>? response = await SignUpRepository.getAllPresence();
    List<dynamic>? allAgent = response?["data"];

    setState(() {
      if (allAgent != null) {
        dataAgent = List<Map<String, dynamic>>.from(allAgent);
        // Log all coordinates
        printCoordinates();
      }
      isLoading = false;
    });

    // Update markers after data is loaded
    updateMarkers();
  }

  void printCoordinates() {
    for (var agent in dataAgent) {
      double latitude = agent["location"]["lat"];
      double longitude = agent["location"]["lng"];
      print('Agent ID: ${agent["_id"]}, Latitude: $latitude, Longitude: $longitude');
    }
  }

  void updateMarkers() {
    setState(() {
      _markers.clear(); // Clear existing markers
      for (int i = 0; i < dataAgent.length; i++) {
        Map<String, dynamic> agent = dataAgent[i];
        String id = agent["_id"];
        double latitude = agent["location"]["lat"];
        double longitude = agent["location"]["lng"];
        String firstname = agent["agent"]["firstname"];
        String lastname = agent["agent"]["lastname"];
        String action = agent["action"];
        String createdat = agent["created_at"];

        // Create a marker for each agent
        _markers.add(
          Marker(
            markerId: MarkerId(id),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: "Agent $firstname $lastname",
              snippet: "$action ($createdat)",
            ),
          ),
        );
      }

      // Adjust the map to show all markers
      _showAllMarkers();
    });
  }

  void _showAllMarkers() {
    if (_markers.isNotEmpty) {
      LatLngBounds bounds;
      List<LatLng> positions = _markers.map((marker) {
        return marker.position;
      }).toList();

      LatLng northeast = LatLng(
        positions.map((pos) => pos.latitude).reduce((a, b) => a > b ? a : b),
        positions.map((pos) => pos.longitude).reduce((a, b) => a > b ? a : b),
      );

      LatLng southwest = LatLng(
        positions.map((pos) => pos.latitude).reduce((a, b) => a < b ? a : b),
        positions.map((pos) => pos.longitude).reduce((a, b) => a < b ? a : b),
      );

      bounds = LatLngBounds(northeast: northeast, southwest: southwest);

      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.white,
      color: Colors.lightGreen.withOpacity(0.5),
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        loadData();
        updateMarkers();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen.withOpacity(0.5),
          title: Text("Presences d'aujourd'hui"),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: dataAgent.isNotEmpty
                      ? LatLng(dataAgent[0]["location"]["lat"], dataAgent[0]["location"]["lng"])
                      : LatLng(0, 0), // Fallback to (0,0) if dataAgent is empty
                  zoom: 14.0,
                ),
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                  _showAllMarkers(); // Adjust map to show all markers
                },
              ),
      ),
    );
  }
}
