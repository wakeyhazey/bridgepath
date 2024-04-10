import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HousingLocationMap extends StatelessWidget {
  final double latitude;
  final double longitude;
  const HousingLocationMap(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 400,
      child: FlutterMap(
        mapController: MapController(),
        options: MapOptions(
          initialZoom: 12,
          initialCenter: LatLng(latitude, longitude),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(markers: [
            Marker(
                point: LatLng(latitude, longitude),
                width: 20,
                height: 20,
                child: const Icon(
                  Icons.my_location_rounded,
                  color: Colors.green,
                ))
          ])
        ],
      ),
    );
  }
}
