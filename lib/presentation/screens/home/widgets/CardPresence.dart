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

  List<Map<String, dynamic>> dataAgent = []; // List of agents
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    Map<String, dynamic>? response = await SignUpRepository.getAllPresence();
    List<dynamic>? allAgent = response["data"];

    setState(() {
      if (allAgent != null) {
        dataAgent = List<Map<String, dynamic>>.from(
            allAgent); // Convert to list of maps
      }
      isLoading = false;
    });

    // Once you have dataAgent populated, update markers
    updateMarkers();
  }

  void updateMarkers() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.withOpacity(0.5),
        title: Text("Presences d'aujourd'hui"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    dataAgent[0]["location"]["lat"],
                    dataAgent[0]["location"]
                        ["lng"]), // Initial position based on first agent
                zoom: 14.0,
              ),
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
    );
  }
}
