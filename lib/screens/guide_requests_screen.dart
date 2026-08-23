import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/guide_models.dart';
import 'guide_order_details_screen.dart';

class GuideRequestsScreen extends StatefulWidget {
  const GuideRequestsScreen({super.key});

  @override
  State<GuideRequestsScreen> createState() => _GuideRequestsScreenState();
}

class _GuideRequestsScreenState extends State<GuideRequestsScreen> {
  int _selectedTab = 0; // 0: الجديدة, 1: بإنتظار الرد, 2: مكتملة
  final List<GuideOrderModel> _orders = GuideOrderModel.getSampleOrders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // 1. الشريط العلوي
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // أيقونة التصفية
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
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

                  // أيقونة الإشعارات
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Stack(
                      children: [
                        const Icon(Icons.notifications_none_rounded, color: Color(0xFF1F2937), size: 20),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF6F00),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. التبويبات الثلاثة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    _buildTabButton(0, 'الجديدة', '3', const Color(0xFF5E35B1)),
                    _buildTabButton(1, 'بإنتظار الرد', '1', const Color(0xFFF59E0B)),
                    _buildTabButton(2, 'مكتملة', '8', const Color(0xFF10B981)),
                  ],
                ),
              ),
            ),

            // 3. قائمة الطلبات
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  final order = _orders[index];
                  return _buildOrderCard(order);
                },
              ),
            ),

            // 4. تنبيه مهم في الأسفل
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_rounded, color: Color(0xFF7E22CE), size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('تنبيه مهم', style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF581C87))),
                          Text(
                            'يرجى الرد على الطلبات في أقرب وقت ممكن لمزيد من فرص الحجز.',
                            style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF6B7280)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String title, String count, Color badgeColor) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF5E35B1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withOpacity(0.2) : badgeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  count,
                  style: GoogleFonts.cairo(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : badgeColor,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF4B5563),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(GuideOrderModel order) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GuideOrderDetailsScreen(order: order)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // رأس الكرت
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE7F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF5E35B1), shape: BoxShape.circle)),
                      const SizedBox(width: 4),
                      Text('جديد', style: GoogleFonts.cairo(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(order.tourTitle, style: GoogleFonts.cairo(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                        Row(
                          children: [
                            Text(order.location, style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF9CA3AF))),
                            const SizedBox(width: 2),
                            const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF9CA3AF)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(order.imageUrl, width: 46, height: 46, fit: BoxFit.cover),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // التفاصيل الأربعة
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailItem('السعر المقترح', '${order.proposedPrice.toInt()} ريال', Icons.wallet_outlined, const Color(0xFF5E35B1)),
                  _buildDetailItem('الأشخاص', '${order.personsCount} أشخاص', Icons.group_outlined, const Color(0xFF4B5563)),
                  _buildDetailItem('الوقت', order.time, Icons.access_time_rounded, const Color(0xFF4B5563)),
                  _buildDetailItem('التاريخ', order.date, Icons.calendar_today_rounded, const Color(0xFF4B5563)),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // لغة السائح ونوع السيارة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('نوع السيارة: ${order.carType}', style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280))),
                Row(
                  children: [
                    Text('لغة السائح: ${order.touristLanguage}', style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280))),
                    const SizedBox(width: 4),
                    const Icon(Icons.language_rounded, size: 14, color: Color(0xFF9CA3AF)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // أزرار القبول والرفض
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: const BorderSide(color: Color(0xFFFCA5A5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cancel_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text('رفض', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GuideOrderDetailsScreen(order: order)),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_rounded, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        Text('قبول', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon, Color valueColor) {
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
        const SizedBox(height: 2),
        Text(value, style: GoogleFonts.cairo(fontSize: 10.5, fontWeight: FontWeight.bold, color: valueColor)),
      ],
    );
  }
}
