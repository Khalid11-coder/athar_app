import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/guide_models.dart';
import 'guide_order_details_screen.dart';

class GuideDashboardScreen extends StatefulWidget {
  final Function(int)? onTabChange;

  const GuideDashboardScreen({super.key, this.onTabChange});

  @override
  State<GuideDashboardScreen> createState() => _GuideDashboardScreenState();
}

class _GuideDashboardScreenState extends State<GuideDashboardScreen> {
  final List<GuideOrderModel> _orders = GuideOrderModel.getSampleOrders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              // 1. الرأس العلوي والترحيب بالمرشد
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE9D5FF), Color(0xFFF8F9FA)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // أيقونة الإشعارات
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          const Icon(Icons.notifications_none_rounded, color: Color(0xFF1F2937), size: 22),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF6F00),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // اسم المرشد والترحيب والصورة
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'مرحباً، عبد المحسن',
                              style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                            Text(
                              'نتمنى لك يوماً موفقاً',
                              style: GoogleFonts.cairo(fontSize: 12, color: const Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE7F6),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF5E35B1), width: 1.5),
                          ),
                          child: const Icon(Icons.person_rounded, color: Color(0xFF5E35B1), size: 30),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 2. بطاقة حالة الحساب (حسابك مفعل)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(14),
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
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.verified_user_rounded, color: Color(0xFF16A34A), size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'حسابك مفعل',
                                  style: GoogleFonts.cairo(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF16A34A),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 16),
                              ],
                            ),
                            Text(
                              'انت جاهز لاستقبال الحجوزات',
                              style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // 3. شبكة الإحصائيات الأربعة (Row of 4)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        title: 'الأرباح هذا الشهر',
                        value: '3,250',
                        unit: 'ريال',
                        icon: Icons.account_balance_wallet_rounded,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildMetricCard(
                        title: 'الحجوزات القادمة',
                        value: '5',
                        unit: 'حجوزات',
                        icon: Icons.calendar_month_rounded,
                        color: const Color(0xFF0288D1),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildMetricCard(
                        title: 'متوسط التقييم',
                        value: '4.8',
                        unit: 'من 5',
                        icon: Icons.star_rounded,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildMetricCard(
                        title: 'الجولات النشطة',
                        value: '4',
                        unit: 'جولة',
                        icon: Icons.location_on_rounded,
                        color: const Color(0xFF8B5CF6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 4. الطلبات الجديدة (1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE7F6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '1',
                            style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'الطلبات الجديدة',
                          style: GoogleFonts.cairo(fontSize: 14.5, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // كرت الطلب الجديد
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // تفاصيل الطلب
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF5E35B1),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'جولة جبل أحد',
                                          style: GoogleFonts.cairo(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today_rounded, size: 12, color: Color(0xFF6B7280)),
                                        const SizedBox(width: 3),
                                        Text('غداً | 9:00 صباحاً', style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF6B7280))),
                                        const SizedBox(width: 6),
                                        const Icon(Icons.group_outlined, size: 12, color: Color(0xFF6B7280)),
                                        const SizedBox(width: 3),
                                        Text('4 أشخاص', style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF6B7280))),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text('السعر المقترح: ', style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280))),
                                        Text('220 ريال', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              // صورة الجبل
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?w=200&auto=format&fit=crop&q=80',
                                  width: 80,
                                  height: 65,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // أزرار قبول ورفض
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
                                      MaterialPageRoute(builder: (context) => GuideOrderDetailsScreen(order: _orders[0])),
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
                    const SizedBox(height: 6),

                    TextButton(
                      onPressed: () {
                        if (widget.onTabChange != null) widget.onTabChange!(1); // انتقال لتبويب الطلبات
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.keyboard_arrow_left_rounded, size: 18, color: Color(0xFF5E35B1)),
                          Text('عرض كل الطلبات', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 5. الحجوزات القادمة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.calendar_month_rounded, size: 18, color: Color(0xFF5E35B1)),
                        const SizedBox(width: 6),
                        Text(
                          'الحجوزات القادمة',
                          style: GoogleFonts.cairo(fontSize: 14.5, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // حجز 1
                    _buildUpcomingBookingItem(
                      title: 'جولة المسجد النبوي',
                      badge: 'مؤكدة',
                      badgeColor: const Color(0xFF16A34A),
                      details: '4 أشخاص | اليوم - 4:00 م',
                      imageUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=200&auto=format&fit=crop&q=80',
                    ),
                    const SizedBox(height: 8),

                    // حجز 2
                    _buildUpcomingBookingItem(
                      title: 'جولة جبل عير',
                      badge: 'قيد الانتظار',
                      badgeColor: const Color(0xFF0288D1),
                      details: 'شخصان | غداً - 8:30 ص',
                      imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=200&auto=format&fit=crop&q=80',
                    ),
                    const SizedBox(height: 6),

                    TextButton(
                      onPressed: () {
                        if (widget.onTabChange != null) widget.onTabChange!(2); // انتقال للحجوزات
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.keyboard_arrow_left_rounded, size: 18, color: Color(0xFF5E35B1)),
                          Text('عرض جميع الحجوزات', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: GoogleFonts.cairo(fontSize: 8.5, color: const Color(0xFF6B7280)),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          Text(
            value,
            style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
          ),
          Text(
            unit,
            style: GoogleFonts.cairo(fontSize: 8.5, color: const Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingBookingItem({
    required String title,
    required String badge,
    required Color badgeColor,
    required String details,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          const Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Color(0xFF9CA3AF)),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge,
                      style: GoogleFonts.cairo(fontSize: 9.5, fontWeight: FontWeight.bold, color: badgeColor),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                details,
                style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF6B7280)),
              ),
            ],
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
