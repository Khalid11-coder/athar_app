import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/map_landmark_model.dart';
import 'tour_details_screen.dart';

class ExploreMapScreen extends StatefulWidget {
  const ExploreMapScreen({super.key});

  @override
  State<ExploreMapScreen> createState() => _ExploreMapScreenState();
}

class _ExploreMapScreenState extends State<ExploreMapScreen> {
  final TransformationController _transformationController = TransformationController();
  final PageController _pageController = PageController(viewportFraction: 0.88);
  final TextEditingController _searchController = TextEditingController();

  List<MapLandmarkModel> _allLandmarks = [];
  List<MapLandmarkModel> _filteredLandmarks = [];
  String _selectedCategory = 'الكل';
  int _selectedLandmarkIndex = 0;
  bool _isSatelliteMode = false;

  final List<String> _categories = ['الكل', 'الدين', 'التاريخ', 'الطبيعة'];

  @override
  void initState() {
    super.initState();
    _allLandmarks = MapLandmarkModel.getMadinahLandmarks();
    _filteredLandmarks = List.from(_allLandmarks);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterLandmarks() {
    setState(() {
      final query = _searchController.text.trim().toLowerCase();
      _filteredLandmarks = _allLandmarks.where((landmark) {
        final matchesCat = _selectedCategory == 'الكل' || landmark.category == _selectedCategory;
        final matchesSearch = query.isEmpty ||
            landmark.title.toLowerCase().contains(query) ||
            landmark.address.toLowerCase().contains(query);
        return matchesCat && matchesSearch;
      }).toList();

      _selectedLandmarkIndex = 0;
    });
  }

  void _selectLandmark(int index) {
    if (index >= 0 && index < _filteredLandmarks.length) {
      setState(() {
        _selectedLandmarkIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _resetMapPosition() {
    _transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E7EB),
      body: Stack(
        children: [
          // ==========================================
          // 1. لوحة الخريطة التفاعلية (Interactive Canvas)
          // ==========================================
          InteractiveViewer(
            transformationController: _transformationController,
            boundaryMargin: const EdgeInsets.all(500),
            minScale: 0.6,
            maxScale: 3.5,
            child: SizedBox(
              width: 1200,
              height: 1200,
              child: Stack(
                children: [
                  // خلفية الخريطة وشوارع المدينة المنورة
                  CustomPaint(
                    size: const Size(1200, 1200),
                    painter: MadinahMapPainter(isSatellite: _isSatelliteMode),
                  ),

                  // نقطة موقع المستخدم الحالي (User Location Dot with Radar Effect)
                  const Positioned(
                    left: 580,
                    top: 610,
                    child: UserLocationRadarMarker(),
                  ),

                  // علامات المعالم (Landmark Pins)
                  ...List.generate(_filteredLandmarks.length, (index) {
                    final landmark = _filteredLandmarks[index];
                    final isSelected = _selectedLandmarkIndex == index;
                    final posX = landmark.mapX * 1200 - 24;
                    final posY = landmark.mapY * 1200 - 48;

                    return Positioned(
                      left: posX,
                      top: posY,
                      child: GestureDetector(
                        onTap: () => _selectLandmark(index),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 250),
                          scale: isSelected ? 1.25 : 1.0,
                          child: LandmarkMapPin(
                            landmark: landmark,
                            isSelected: isSelected,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // ==========================================
          // 2. شريط البحث والفلترة العلوي العائم
          // ==========================================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // حقل البحث
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => _filterLandmarks(),
                      decoration: InputDecoration(
                        hintText: 'ابحث عن معلم، مسجد، جبل، أو بئر تاريخي...',
                        hintStyle: GoogleFonts.cairo(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13,
                        ),
                        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF5E35B1)),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18, color: Color(0xFF9CA3AF)),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterLandmarks();
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // شريط التصنيفات الأفقية
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final isSelected = _selectedCategory == cat;
                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            setState(() => _selectedCategory = cat);
                            _filterLandmarks();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF5E35B1) : Colors.white.withOpacity(0.92),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFFE5E7EB),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                cat,
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                  color: isSelected ? Colors.white : const Color(0xFF374151),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // 3. أزرار التحكم الجانبية العائمة
          // ==========================================
          Positioned(
            left: 16,
            top: 150,
            child: Column(
              children: [
                _buildMapControlBtn(
                  icon: _isSatelliteMode ? Icons.map_rounded : Icons.satellite_alt_rounded,
                  tooltip: 'نوع الخريطة',
                  onTap: () => setState(() => _isSatelliteMode = !_isSatelliteMode),
                ),
                const SizedBox(height: 10),
                _buildMapControlBtn(
                  icon: Icons.my_location_rounded,
                  tooltip: 'موقعي الحالي',
                  iconColor: const Color(0xFF5E35B1),
                  onTap: _resetMapPosition,
                ),
              ],
            ),
          ),

          // ==========================================
          // 4. بطاقة معاينة المعلم المنبثقة في الأسفل (Sliding Carousel)
          // ==========================================
          if (_filteredLandmarks.isNotEmpty)
            Positioned(
              right: 0,
              left: 0,
              bottom: 24,
              child: SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _filteredLandmarks.length,
                  onPageChanged: (index) {
                    setState(() => _selectedLandmarkIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final landmark = _filteredLandmarks[index];
                    return MapLandmarkPreviewCard(
                      landmark: landmark,
                      onTapDetails: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TourDetailsScreen(tour: landmark.tour),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMapControlBtn({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: iconColor ?? const Color(0xFF374151)),
        tooltip: tooltip,
        onPressed: onTap,
      ),
    );
  }
}

/// ودجت دبوس المعلم على الخريطة
class LandmarkMapPin extends StatelessWidget {
  final MapLandmarkModel landmark;
  final bool isSelected;

  const LandmarkMapPin({
    super.key,
    required this.landmark,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // عنوان المعلم الصغير
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1F2937) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            landmark.title,
            style: GoogleFonts.cairo(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : const Color(0xFF1F2937),
            ),
          ),
        ),
        const SizedBox(height: 2),

        // رأس الدبوس
        Container(
          width: isSelected ? 44 : 36,
          height: isSelected ? 44 : 36,
          decoration: BoxDecoration(
            color: landmark.pinColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: landmark.pinColor.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            landmark.icon,
            color: Colors.white,
            size: isSelected ? 22 : 18,
          ),
        ),
      ],
    );
  }
}

/// ودجت موقع المستخدم بنبضات الرادار (Radar User Dot)
class UserLocationRadarMarker extends StatefulWidget {
  const UserLocationRadarMarker({super.key});

  @override
  State<UserLocationRadarMarker> createState() => _UserLocationRadarMarkerState();
}

class _UserLocationRadarMarkerState extends State<UserLocationRadarMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 32 + (24 * _animController.value),
              height: 32 + (24 * _animController.value),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF3B82F6).withOpacity(1.0 - _animController.value),
              ),
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.5),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// بطاقة المعاينة المنبثقة لمعلم الخريطة في الأسفل
class MapLandmarkPreviewCard extends StatelessWidget {
  final MapLandmarkModel landmark;
  final VoidCallback onTapDetails;

  const MapLandmarkPreviewCard({
    super.key,
    required this.landmark,
    required this.onTapDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // صورة المعلم
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              landmark.tour.imageUrl,
              width: 110,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // بيانات المعلم
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE7F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        landmark.category,
                        style: GoogleFonts.cairo(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5E35B1),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.near_me_rounded, size: 12, color: Color(0xFF6B7280)),
                        const SizedBox(width: 3),
                        Text(
                          landmark.distance,
                          style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                Text(
                  landmark.title,
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  landmark.address,
                  style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),

                // زر حجز الجولة والسعر
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${landmark.tour.price.toInt()} ',
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
                    SizedBox(
                      height: 34,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5E35B1),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: onTapDetails,
                        child: Text(
                          'تفاصيل وحجز',
                          style: GoogleFonts.cairo(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
    );
  }
}

/// الرسام المخصص لخريطة وطرق المدينة المنورة
class MadinahMapPainter extends CustomPainter {
  final bool isSatellite;

  MadinahMapPainter({this.isSatellite = false});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. لون أرضية الخريطة
    final bgPaint = Paint()
      ..color = isSatellite ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // 2. الجبال والمناطق الوعرة (جبل أحد شمالاً وجبل عير جنوباً)
    final mountainPaint = Paint()
      ..color = isSatellite ? const Color(0xFF374151) : const Color(0xFFE5E7EB)
      ..style = PaintingStyle.fill;

    // كتلة جبل أحد شمالاً
    final uhudPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.12)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.08, size.width * 0.8, size.height * 0.16)
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.28, size.width * 0.35, size.height * 0.26)
      ..close();
    canvas.drawPath(uhudPath, mountainPaint);

    // كتلة جبل عير جنوباً
    final eirPath = Path()
      ..moveTo(size.width * 0.1, size.height * 0.82)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.78, size.width * 0.45, size.height * 0.92)
      ..quadraticBezierTo(size.width * 0.2, size.height * 0.98, size.width * 0.05, size.height * 0.9)
      ..close();
    canvas.drawPath(eirPath, mountainPaint);

    // 3. المنطقة الخضراء والحدائق ومزارع النخيل
    final greenPaint = Paint()
      ..color = isSatellite ? const Color(0xFF064E3B).withOpacity(0.5) : const Color(0xFFDCFCE7)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.7, size.height * 0.55),
        width: 220,
        height: 160,
      ),
      greenPaint,
    );

    // 4. شبكة الطرق الدائرية والرئيسية (الدائري الأول، الثاني، طريق الهجرة والمطار)
    final roadPaint = Paint()
      ..color = isSatellite ? const Color(0xFF4B5563) : Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    final roadBorderPaint = Paint()
      ..color = isSatellite ? const Color(0xFF111827) : const Color(0xFFD1D5DB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18;

    final center = Offset(size.width * 0.5, size.height * 0.5);

    // الدائري الأول حول المنطقة المركزية
    canvas.drawCircle(center, 120, roadBorderPaint);
    canvas.drawCircle(center, 120, roadPaint);

    // الدائري الثاني
    canvas.drawCircle(center, 280, roadBorderPaint);
    canvas.drawCircle(center, 280, roadPaint);

    // الدائري الثالث
    canvas.drawCircle(center, 440, roadBorderPaint);
    canvas.drawCircle(center, 440, roadPaint);

    // طريق المطار وطريق الهجرة (محور شمال-جنوب)
    final highwayPath = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width * 0.5, size.height);
    canvas.drawPath(highwayPath, roadBorderPaint);
    canvas.drawPath(highwayPath, roadPaint);

    // طريق السلام (محور شرق-غرب)
    final highwayPath2 = Path()
      ..moveTo(0, size.height * 0.5)
      ..lineTo(size.width, size.height * 0.5);
    canvas.drawPath(highwayPath2, roadBorderPaint);
    canvas.drawPath(highwayPath2, roadPaint);

    // ساحة الحرم النبوي الشريف
    final haramPaint = Paint()
      ..color = isSatellite ? const Color(0xFF5E35B1).withOpacity(0.3) : const Color(0xFFEDE7F6)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 70, height: 70),
        const Radius.circular(16),
      ),
      haramPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
