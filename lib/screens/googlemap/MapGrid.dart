import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MapGrid extends StatefulWidget {
  const MapGrid({super.key});

  @override
  State<MapGrid> createState() => MapGridState();
}

class MapGridState extends State<MapGrid> {
  final CollectionReference routeCollection =
      FirebaseFirestore.instance.collection('route');
  final CollectionReference markersCollection =
      FirebaseFirestore.instance.collection('markers');
  final FirebaseApp app = Firebase.apps.first;
  bool isTracking = false;
  GoogleMapController? _controller;
  List<LatLng> routePoints = [];
  StreamSubscription<Position>? positionStream;
  List<Marker> markers = [];
  bool dangerPressed = false;

  @override
  void initState() {
    super.initState();
    fetchRouteFB();
    fetchMarkersFB();
  }

  Future<void> fetchRouteFB() async {
    final QuerySnapshot querySnapshot = await routeCollection.get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    final List<LatLng> points = [];
    for (final doc in docs) {
      final List<dynamic> geoPoints = doc['points'];
      for (final geoPoint in geoPoints) {
        points.add(LatLng(geoPoint.latitude, geoPoint.longitude));
      }
    }
    setState(() {
      routePoints = points;
    });
  }

  Future<void> fetchMarkersFB() async {
    final QuerySnapshot querySnapshot = await markersCollection.get();

    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    final List<Marker> fetchmarkers = [];

    for (final doc in docs) {
      final double latitude = doc['latitude'];
      final double longitude = doc['longitude'];
      final String iconPath = doc['iconPath'];

      final LatLng markersLatLng = LatLng(latitude, longitude);

      final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(32, 32)),
        iconPath,
      );

      final Marker marker = Marker(
        markerId: MarkerId('marker-${doc.id}'),
        position: markersLatLng,
        icon: icon,
      );
      fetchmarkers.add(marker);
    }

    setState(() {
      markers = fetchmarkers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            leading: const BackButton(
              color: Colors.white,
            ),
            backgroundColor: Color.fromARGB(255, 47, 47, 47),
            elevation: 0,
            centerTitle: true,
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 60),
                    child: Text(
                      'Road Conditions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: Stack(
        children: [
          Container(
            child: routePoints.isNotEmpty
                ? GoogleMap(
                    onMapCreated: (controller) {
                      _controller = controller;
                    },
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    padding:
                        EdgeInsets.only(bottom: 55, top: 0, right: 10, left: 0),
                    initialCameraPosition: CameraPosition(
                      target: routePoints.last,
                      zoom: 18.0,
                    ),
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId('route'),
                        visible: true,
                        points: routePoints,
                        color: Colors.blue,
                        width: 4,
                      ),
                    },
                    markers: markers.toSet(),
                  )
                : const Center(
                    child: Text('No route found'),
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: 400,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 40),
                height: 90,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 63, 62, 62),
                    borderRadius: BorderRadius.circular(70)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () {
                                    startTracking();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: isTracking
                                        ? Color.fromARGB(255, 92, 90, 90)
                                        : Color.fromARGB(255, 47, 47, 47),
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(5),
                                  ),
                                  child: isTracking
                                      ? Icon(Icons.stop,
                                          color: Colors.white, size: 40)
                                      : Icon(Icons.play_arrow,
                                          color: Colors.white, size: 40),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () {
                                    addWarningMarker("assets/warning_icon.png");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 47, 47, 47),
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(5),
                                  ),
                                  child: Icon(Icons.warning,
                                      color: Colors.yellow, size: 30),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () {
                                    addWarningMarker("assets/fixing_icon.png");
                                    ;
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 47, 47, 47),
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(5),
                                  ),
                                  child: Icon(Icons.remove_road,
                                      color: Colors.redAccent, size: 30),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void startTracking() async {
    if (!isTracking) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse ||
            permission != LocationPermission.always) {
          return;
        }
      }

      isTracking = true;

      final QuerySnapshot markersQuerySnapshot = await markersCollection.get();
      for (final DocumentSnapshot doc in markersQuerySnapshot.docs) {
        await doc.reference.delete();
      }
      setState(() {
        routePoints.clear();
        markers.clear();
      });

      positionStream = Geolocator.getPositionStream().listen((position) {
        if (!isTracking) return;
        final latLng = LatLng(position.latitude, position.longitude);
        setState(() {
          routePoints.add(latLng);
        });
        _controller?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 18.0));
      });
    } else {
      await stopTracking();
    }
  }

  Future<void> stopTracking() async {
    if (isTracking) {
      isTracking = false;
      positionStream?.cancel();

      final List<GeoPoint> geoPoints = routePoints
          .map((latLng) => GeoPoint(latLng.latitude, latLng.longitude))
          .toList();

      // Check if there is an existing document in the collection
      final QuerySnapshot querySnapshot = await routeCollection.get();
      if (querySnapshot.size > 0) {
        // Update the existing document with the new points
        final DocumentSnapshot doc = querySnapshot.docs[0];
        await doc.reference.update({'points': geoPoints});
      } else {
        // Add a new document with the points
        await routeCollection.add({'points': geoPoints});
      }

      //await routeCollection.add({'points': geoPoints});

      setState(() {});
    }
  }

  Future<void> addWarningMarker(String iconPath) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse ||
          permission != LocationPermission.always) {
        return;
      }
    }

    Position Markerposition = await Geolocator.getCurrentPosition();
    LatLng currentLatLngMarker =
        LatLng(Markerposition.latitude, Markerposition.longitude);

    setState(() {
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(32, 32)),
        iconPath,
      ).then((icon) async {
        markers.add(Marker(
          markerId: MarkerId('currentLocation${markers.length}'),
          position: currentLatLngMarker,
          icon: icon,
        ));

        await FirebaseFirestore.instance.collection('markers').add({
          'latitude': currentLatLngMarker.latitude,
          'longitude': currentLatLngMarker.longitude,
          'iconPath': iconPath,
        });
      });
    });
  }
}
