import 'package:flutter/material.dart';
import 'tour_model.dart';

class MapLandmarkModel {
  final String id;
  final String title;
  final String category;
  final double latitude;
  final double longitude;
  final double mapX; // إحداثيات نسبية داخل خريطة العرض (0.0 إلى 1.0)
  final double mapY;
  final String distance;
  final String address;
  final IconData icon;
  final Color pinColor;
  final TourModel tour;

  MapLandmarkModel({
    required this.id,
    required this.title,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.mapX,
    required this.mapY,
    required this.distance,
    required this.address,
    required this.icon,
    required this.pinColor,
    required this.tour,
  });

  static List<MapLandmarkModel> getMadinahLandmarks() {
    final tours = TourModel.getSampleTours();

    return [
      MapLandmarkModel(
        id: 'm1',
        title: 'المسجد النبوي الشريف',
        category: 'الدين',
        latitude: 24.4672,
        longitude: 39.6111,
        mapX: 0.50,
        mapY: 0.48,
        distance: '0.8 كم',
        address: 'المنطقة المركزية، المدينة المنورة',
        icon: Icons.mosque_rounded,
        pinColor: const Color(0xFF5E35B1),
        tour: tours[2],
      ),
      MapLandmarkModel(
        id: 'm2',
        title: 'جبل أحد وجبل الرماة',
        category: 'التاريخ',
        latitude: 24.5034,
        longitude: 39.6125,
        mapX: 0.52,
        mapY: 0.20,
        distance: '4.2 كم',
        address: 'طريق المطار، شمال المدينة المنورة',
        icon: Icons.landscape_rounded,
        pinColor: const Color(0xFFFF6F00),
        tour: tours[0],
      ),
      MapLandmarkModel(
        id: 'm3',
        title: 'بئر غرس التاريخية',
        category: 'الدين',
        latitude: 24.4450,
        longitude: 39.6240,
        mapX: 0.65,
        mapY: 0.65,
        distance: '2.5 كم',
        address: 'حي قباء، بالقرب من مسار قباء',
        icon: Icons.water_drop_rounded,
        pinColor: const Color(0xFF0288D1),
        tour: tours[1],
      ),
      MapLandmarkModel(
        id: 'm4',
        title: 'مسجد قباء ومسار الهجرة',
        category: 'الدين',
        latitude: 24.4392,
        longitude: 39.6172,
        mapX: 0.46,
        mapY: 0.72,
        distance: '3.1 كم',
        address: 'شارع الهجرة، قباء',
        icon: Icons.temple_buddhist_rounded,
        pinColor: const Color(0xFF2E7D32),
        tour: tours[1],
      ),
      MapLandmarkModel(
        id: 'm5',
        title: 'جبل عير والحد الجنوبي',
        category: 'الطبيعة',
        latitude: 24.4100,
        longitude: 39.5700,
        mapX: 0.25,
        mapY: 0.85,
        distance: '7.8 كم',
        address: 'جنوب المدينة المنورة',
        icon: Icons.terrain_rounded,
        pinColor: const Color(0xFFD97706),
        tour: tours[3],
      ),
      MapLandmarkModel(
        id: 'm6',
        title: 'مزرعة طيبة التراثية',
        category: 'الطبيعة',
        latitude: 24.4520,
        longitude: 39.6350,
        mapX: 0.75,
        mapY: 0.52,
        distance: '3.8 كم',
        address: 'بساتين النخيل، شرق المدينة',
        icon: Icons.park_rounded,
        pinColor: const Color(0xFF059669),
        tour: tours[4],
      ),
    ];
  }
}
