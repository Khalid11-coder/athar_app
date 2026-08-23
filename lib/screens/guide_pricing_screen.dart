import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/guide_models.dart';
import '../widgets/guide_header_banner.dart';
import 'guide_review_submit_screen.dart';

class GuidePricingScreen extends StatefulWidget {
  final List<GuideTourItem> selectedTours;

  const GuidePricingScreen({super.key, required this.selectedTours});

  @override
  State<GuidePricingScreen> createState() => _GuidePricingScreenState();
}

class _GuidePricingScreenState extends State<GuidePricingScreen> {
  late List<GuideTourItem> _tours;

  @override
  void initState() {
    super.initState();
    _tours = widget.selectedTours.isNotEmpty
        ? widget.selectedTours
        : GuideTourItem.getDefaultTours().where((t) => t.isSelected).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          const GuideHeaderBanner(currentStep: 4, totalSteps: 5),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'حدد أسعارك',
                    style: GoogleFonts.cairo(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'اختر السعر الذي ترغب بتقديمه لكل جولة ضمن النطاق المقترح',
                    style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 14),

                  // شارة عدد الجولات المختارة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'يمكنك تعديل السعر لاحقاً من لوحة التحكم',
                        style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF9CA3AF)),
                      ),
                      Row(
                        children: [
                          Text(
                            'الجولات التي اخترتها',
                            style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDE7F6),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${_tours.length}',
                              style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // قائمة كروت تحديد الأسعار بالسلايدر
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _tours.length,
                    itemBuilder: (context, index) {
                      final tour = _tours[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // صورة الجولة
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    tour.imageUrl,
                                    width: 70,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 70,
                                      height: 60,
                                      color: const Color(0xFFEDE7F6),
                                      child: const Icon(Icons.image, color: Color(0xFF5E35B1)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // اسم الجولة والنطاق
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tour.title,
                                        style: GoogleFonts.cairo(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                                      ),
                                      Text(
                                        'النطاق المقترح: ${tour.minPrice.toInt()}-${tour.maxPrice.toInt()} ريال',
                                        style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF7E22CE), fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                // السعر الحالي
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'سعرك',
                                      style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF6B7280)),
                                    ),
                                    Text(
                                      '${tour.selectedPrice.toInt()} ريال',
                                      style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // سلايدر السعر التفاعلي
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: const Color(0xFF5E35B1),
                                inactiveTrackColor: const Color(0xFFEDE7F6),
                                thumbColor: const Color(0xFF5E35B1),
                                trackHeight: 4,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                              ),
                              child: Slider(
                                value: tour.selectedPrice,
                                min: tour.minPrice,
                                max: tour.maxPrice,
                                divisions: ((tour.maxPrice - tour.minPrice) / 10).round(),
                                label: '${tour.selectedPrice.toInt()} ريال',
                                onChanged: (val) {
                                  setState(() => tour.selectedPrice = val);
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${tour.minPrice.toInt()}', style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF9CA3AF))),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF5E35B1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '${tour.selectedPrice.toInt()} ريال',
                                    style: GoogleFonts.cairo(fontSize: 9.5, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text('${tour.maxPrice.toInt()}', style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF9CA3AF))),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // نصيحة سفلية
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.lightbulb_outline_rounded, color: Color(0xFF5E35B1), size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'نصيحة: السعر المناسب يزيد من فرص ظهورك للسياح، اختر سعراً تنافسياً وواقعياً.',
                            style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF5E35B1), height: 1.3),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuideReviewSubmitScreen(tours: _tours)),
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
