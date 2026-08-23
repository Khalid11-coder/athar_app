import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/guide_models.dart';
import '../widgets/guide_header_banner.dart';
import 'guide_pricing_screen.dart';

class GuideTourSelectionScreen extends StatefulWidget {
  const GuideTourSelectionScreen({super.key});

  @override
  State<GuideTourSelectionScreen> createState() => _GuideTourSelectionScreenState();
}

class _GuideTourSelectionScreenState extends State<GuideTourSelectionScreen> {
  late List<GuideTourItem> _tours;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tours = GuideTourItem.getDefaultTours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          const GuideHeaderBanner(currentStep: 3, totalSteps: 5),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'اختر الجولات التي تقدمها',
                    style: GoogleFonts.cairo(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'اختر الجولات التي تريد ان تقدمها للسياح في مدينتك',
                    style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 12),

                  // مربع التنبيه البنفسجي الفاتح
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE9D5FF)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded, color: Color(0xFF7E22CE), size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'ستظهر الجولات التي تقدمها في ملفك الشخصي وسيتمكن السياح من حجزها معك',
                            style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF581C87), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // شريط البحث والفلترة
                  Row(
                    children: [
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.tune_rounded, size: 16, color: Color(0xFF5E35B1)),
                            const SizedBox(width: 4),
                            Text('تصفية', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.search_rounded, size: 18, color: Color(0xFF9CA3AF)),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(fontSize: 11.5),
                                  decoration: InputDecoration(
                                    hintText: 'ابحث عن جولة',
                                    hintStyle: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF9CA3AF)),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // عنوان الجولات المتاحة
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'الجولات المتاحة',
                      style: GoogleFonts.cairo(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // شبكة الجولات المتاحة (2 أعمدة)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.05,
                    ),
                    itemCount: _tours.length,
                    itemBuilder: (context, index) {
                      final tour = _tours[index];
                      return GestureDetector(
                        onTap: () => setState(() => tour.isSelected = !tour.isSelected),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: tour.isSelected ? const Color(0xFF5E35B1) : const Color(0xFFE5E7EB),
                              width: tour.isSelected ? 2 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // صورة الجولة مع مربع التحديد
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                                      child: Image.network(
                                        tour.imageUrl,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          color: const Color(0xFFEDE7F6),
                                          child: const Center(
                                            child: Icon(Icons.explore_rounded, color: Color(0xFF5E35B1)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // مربع الاختيار
                                    Positioned(
                                      top: 6,
                                      left: 6,
                                      child: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          color: tour.isSelected ? const Color(0xFF5E35B1) : Colors.white.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: tour.isSelected ? const Color(0xFF5E35B1) : const Color(0xFF9CA3AF),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: tour.isSelected
                                            ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // عنوان الجولة والمدة
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tour.title,
                                      style: GoogleFonts.cairo(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1F2937),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time_rounded, size: 12, color: Color(0xFF7E22CE)),
                                        const SizedBox(width: 4),
                                        Text(
                                          tour.duration,
                                          style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF6B7280)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // نصيحة سفلية
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.lightbulb_outline_rounded, color: Color(0xFF5E35B1), size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'نصيحة: يمكنك تعديل الجولات لاحقاً من لوحة الملف الشخصي',
                            style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF5E35B1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // الزر السفلي التالي
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E35B1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  final selectedTours = _tours.where((t) => t.isSelected).toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuidePricingScreen(selectedTours: selectedTours)),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'التالي',
                      style: GoogleFonts.cairo(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
