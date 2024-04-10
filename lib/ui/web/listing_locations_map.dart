import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ListingsLocationsMap extends StatelessWidget {
  final List<Map<String, dynamic>> listings;
  const ListingsLocationsMap({super.key, required this.listings});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: MapController(),
      options: MapOptions(
        initialZoom: 12,
        initialCenter: LatLng(
            listings[0]['location']['lat'], listings[0]['location']['lon']),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: listings
              .map<Marker>((entry) => Marker(
                  point: LatLng(
                      entry['location']['lat'], entry['location']['lon']),
                  width: 20,
                  height: 20,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.black,
                  )))
              .toList(),
        )
      ],
    );
  }
}
