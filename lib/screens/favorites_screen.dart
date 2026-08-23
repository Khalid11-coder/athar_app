import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/tour_model.dart';
import 'tour_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<TourModel> _favoriteTours;

  @override
  void initState() {
    super.initState();
    // جلب الجولات التي تم وضعها في المفضلة افتراضياً
    _favoriteTours = TourModel.getSampleTours().where((t) => t.isFavorite || t.id == '1' || t.id == '2').toList();
  }

  void _removeFavorite(TourModel tour) {
    setState(() {
      tour.isFavorite = false;
      _favoriteTours.removeWhere((t) => t.id == tour.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          'تمت إزالة الجولة من قائمة المفضلة',
          style: GoogleFonts.cairo(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الجولات المفضلة',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              Text(
                '${_favoriteTours.length} جولات محفوظة للزيارة',
                style: GoogleFonts.cairo(fontSize: 12.5, color: const Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
      ),
      body: _favoriteTours.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEDE7F6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      size: 52,
                      color: Color(0xFF5E35B1),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'قائمة المفضلة فارغة حالياً',
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'اضغط على رمز القلب ❤️ في أي جولة لحفظها هنا والعودة إليها لاحقاً',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(fontSize: 13, color: const Color(0xFF9CA3AF)),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: _favoriteTours.length,
              itemBuilder: (context, index) {
                final tour = _favoriteTours[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TourDetailsScreen(tour: tour),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // صورة الجولة
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    tour.imageUrl,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 6,
                                  left: 6,
                                  child: GestureDetector(
                                    onTap: () => _removeFavorite(tour),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.favorite_rounded,
                                        color: Color(0xFFEF4444),
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 14),

                            // تفاصيل الجولة
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tour.title,
                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1F2937),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined, size: 13, color: Color(0xFF9CA3AF)),
                                      const SizedBox(width: 4),
                                      Text(
                                        tour.location,
                                        style: GoogleFonts.cairo(fontSize: 12, color: const Color(0xFF6B7280)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time_rounded, size: 13, color: Color(0xFF6B7280)),
                                      const SizedBox(width: 3),
                                      Text(tour.duration, style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF4B5563))),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.star_rounded, size: 15, color: Color(0xFFFFB300)),
                                      const SizedBox(width: 3),
                                      Text(
                                        '${tour.rating}',
                                        style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  // السعر وزر الحجز السريع
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${tour.price.toInt()} ',
                                              style: GoogleFonts.cairo(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFFFF6F00),
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'ريال',
                                              style: GoogleFonts.cairo(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF5E35B1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEDE7F6),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'احجز الآن',
                                          style: GoogleFonts.cairo(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF5E35B1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
