import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/guide_models.dart';

class GuideOrderDetailsScreen extends StatelessWidget {
  final GuideOrderModel order;

  const GuideOrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1F2937), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'تفاصيل الطلب',
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          children: [
            // 1. بطاقة الجولة الأساسية
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              order.tourTitle,
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('التاريخ', style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF9CA3AF))),
                                    Text(order.date, style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('الوقت', style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF9CA3AF))),
                                    Text(order.time, style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('المدة', style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF9CA3AF))),
                                    Text('4 ساعات', style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _buildTag('داخل المدينة', const Color(0xFFEDE7F6), const Color(0xFF5E35B1)),
                                const SizedBox(width: 6),
                                _buildTag('جولة خاصة', const Color(0xFFF3E8FF), const Color(0xFF7E22CE)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // صورة الجبل مع الشارة
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.network(
                              order.imageUrl,
                              width: 90,
                              height: 85,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF5E35B1).withOpacity(0.9),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                order.badgeText,
                                style: GoogleFonts.cairo(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 2. معلومات السائح
            _buildSectionContainer(
              title: 'معلومات السائح',
              icon: Icons.person_outline_rounded,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEDE7F6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person_rounded, color: Color(0xFF5E35B1), size: 26),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.touristName,
                              style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                            ),
                            Text(
                              order.touristPhone,
                              style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMiniInfo('عدد الاشخاص', '${order.personsCount} أشخاص', Icons.groups_outlined),
                        _buildMiniInfo('اللغة', order.touristLanguage, Icons.language_rounded),
                        _buildMiniInfo('التقييم', '4.8 ⭐', Icons.star_outline_rounded),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 3. مكان الالتقاء
            _buildSectionContainer(
              title: 'مكان الالتقاء',
              icon: Icons.location_on_outlined,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.meetingLocation,
                          style: GoogleFonts.cairo(fontSize: 12.5, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                        ),
                        const SizedBox(height: 6),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF5E35B1),
                            side: const BorderSide(color: Color(0xFF5E35B1)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.open_in_new_rounded, size: 14),
                          label: Text('فتح في الخرائط', style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // صورة مصغرة للخريطة
                  Container(
                    width: 75,
                    height: 65,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7E57C2).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.map_rounded, color: Color(0xFF5E35B1), size: 36),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 4. ملاحظات السائح
            _buildSectionContainer(
              title: 'ملاحظات السائح',
              icon: Icons.note_alt_outlined,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E8FF).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  order.touristNotes,
                  style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF4B5563), height: 1.4),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 5. تفاصيل الحجز والمبلغ المستلم
            _buildSectionContainer(
              title: 'تفاصيل الحجز',
              icon: Icons.sell_outlined,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // المبلغ المستلم
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF86EFAC)),
                    ),
                    child: Column(
                      children: [
                        Text('المبلغ المستلم', style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF15803D), fontWeight: FontWeight.w600)),
                        Text(
                          '${order.netEarnings.toInt()} ر.س',
                          style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF16A34A)),
                        ),
                      ],
                    ),
                  ),

                  // العمولة
                  Column(
                    children: [
                      Text('العمولة (15%)', style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF6B7280))),
                      Text('${order.commissionAmount.toInt()} ر.س', style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                    ],
                  ),

                  // سعر الجولة
                  Column(
                    children: [
                      Text('سعر الجولة', style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF6B7280))),
                      Text('${order.tourBasePrice.toInt()} ر.س', style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // 6. أزرار القبول والرفض
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: const BorderSide(color: Color(0xFFFCA5A5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text('رفض', style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم قبول الطلب بنجاح وتم إضافته لجدول حجوزاتك ✅', style: GoogleFonts.cairo()),
                          backgroundColor: const Color(0xFF16A34A),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        Text('قبول', style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContainer({required String title, required IconData icon, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(title, style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
              const SizedBox(width: 6),
              Icon(icon, size: 18, color: const Color(0xFF5E35B1)),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color textC) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: GoogleFonts.cairo(fontSize: 9.5, fontWeight: FontWeight.bold, color: textC)),
    );
  }

  Widget _buildMiniInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: const Color(0xFF9CA3AF)),
            const SizedBox(width: 2),
            Text(label, style: GoogleFonts.cairo(fontSize: 9.5, color: const Color(0xFF9CA3AF))),
          ],
        ),
        Text(value, style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
      ],
    );
  }
}
