import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late final MapController _mapController;
  double _currentZoom = 13.0;
  final LatLng _initialPosition = const LatLng(41.052165, 29.010980);

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  // Zoom In
  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(1.0, 18.0);
      _mapController.move(_initialPosition, _currentZoom);
    });
  }

  // Zoom Out
  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(1.0, 18.0);
      _mapController.move(_initialPosition, _currentZoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Yıldız Teknik Anısına'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _initialPosition, // Başlangıç merkezi
              initialZoom: _currentZoom, // Başlangıç zoom seviyesi
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all, // Kullanıcı etkileşimleri aktif
              ),
            ),
            children: [
              // OpenStreetMap Katmanı
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              // Marker Katmanı
              MarkerLayer(
                markers: [
                  Marker(
                    point: _initialPosition,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_pin,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Zoom Butonları
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoomIn',
                  onPressed: _zoomIn,
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'zoomOut',
                  onPressed: _zoomOut,
                  child: const Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
