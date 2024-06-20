import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Map<String, dynamic>> restaurants = [];
  bool showMap = false;
  LatLng currentLocation = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchRestaurants();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _fetchRestaurants() async {
    setState(() {
      restaurants = [
        {"name": "Restaurante A", "latitude": -23.563210, "longitude": -46.654251},
        {"name": "Restaurante B", "latitude": -23.565110, "longitude": -46.651351},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurantes Próximos'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showMap = !showMap;
              });
            },
            icon: Icon(showMap ? Icons.list : Icons.map),
          ),
        ],
      ),
      body: showMap ? _buildMap() : _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(restaurants[index]['name']),
          subtitle:
          Text('Lat: ${restaurants[index]['latitude']}, Lng: ${restaurants[index]['longitude']}'),
          onTap: () {
            // Implementar ação ao clicar no restaurante, se necessário
          },
        );
      },
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      options: MapOptions(
        center: currentLocation,
        zoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: restaurants.map((restaurant) {
            return Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(restaurant['latitude'], restaurant['longitude']),
              builder: (ctx) => Container(
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

}
