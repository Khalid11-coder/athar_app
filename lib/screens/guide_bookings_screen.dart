import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/guide_models.dart';

class GuideBookingsScreen extends StatefulWidget {
  const GuideBookingsScreen({super.key});

  @override
  State<GuideBookingsScreen> createState() => _GuideBookingsScreenState();
}

class _GuideBookingsScreenState extends State<GuideBookingsScreen> {
  int _selectedTab = 0; // 0: اليوم, 1: القادمة, 2: المكتملة
  final List<GuideBookingItem> _bookings = GuideBookingItem.getSampleBookings();
  final TextEditingController _searchController = TextEditingController();

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
                        Text('فلترة', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: const Icon(Icons.notifications_none_rounded, color: Color(0xFF1F2937), size: 20),
                  ),
                ],
              ),
            ),

            // 2. التبويبات الثلاثة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    _buildTab(0, 'اليوم', Icons.calendar_today_rounded),
                    _buildTab(1, 'القادمة', Icons.calendar_month_outlined),
                    _buildTab(2, 'المكتملة', Icons.check_circle_outline_rounded),
                  ],
                ),
              ),
            ),

            // 3. شريط البحث
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.search_rounded, color: Color(0xFF9CA3AF), size: 18),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cairo(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: 'ابحث عن حجز أو سائح',
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

            // 4. رأس قسم اليوم
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '4 حجوزات',
                      style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                    ),
                  ),
                  Text(
                    'اليوم - 16 مايو 2026',
                    style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                  ),
                ],
              ),
            ),

            // 5. قائمة كروت الحجوزات
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                itemCount: _bookings.length,
                itemBuilder: (context, index) {
                  final item = _bookings[index];
                  return _buildBookingCard(item);
                },
              ),
            ),

            // 6. ملاحظة النهاية
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_month_outlined, size: 14, color: Color(0xFF7E22CE)),
                  const SizedBox(width: 4),
                  Text(
                    'لا توجد حجوزات أخرى لليوم',
                    style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String title, IconData icon) {
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
              Icon(icon, size: 14, color: isSelected ? Colors.white : const Color(0xFF6B7280)),
              const SizedBox(width: 4),
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

  Widget _buildBookingCard(GuideBookingItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // زر السعر مع سهم
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: item.badgeColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.timeRemainingBadge,
                      style: GoogleFonts.cairo(fontSize: 10, fontWeight: FontWeight.bold, color: item.badgeColor),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Icon(Icons.arrow_back_ios_new_rounded, size: 12, color: Color(0xFF5E35B1)),
                      const SizedBox(width: 4),
                      Text(
                        '${item.price.toInt()} ر.س',
                        style: GoogleFonts.cairo(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),

              // بيانات الجولة والسائح
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item.tourTitle,
                    style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(item.touristName, style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF4B5563))),
                      const SizedBox(width: 4),
                      const Icon(Icons.person_outline_rounded, size: 13, color: Color(0xFF5E35B1)),
                    ],
                  ),
                  Row(
                    children: [
                      Text('${item.personsCount} أشخاص', style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF6B7280))),
                      const SizedBox(width: 4),
                      const Icon(Icons.group_outlined, size: 13, color: Color(0xFF6B7280)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(item.dateTimeString, style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF6B7280))),
                      const SizedBox(width: 4),
                      const Icon(Icons.access_time_rounded, size: 12, color: Color(0xFF6B7280)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(item.location, style: GoogleFonts.cairo(fontSize: 9.5, color: const Color(0xFF9CA3AF))),
                      const SizedBox(width: 4),
                      const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF9CA3AF)),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 10),

              // صورة الجولة مع شارة اليوم
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.imageUrl,
                      width: 68,
                      height: 68,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Container(width: 5, height: 5, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
                          const SizedBox(width: 3),
                          Text('اليوم', style: GoogleFonts.cairo(fontSize: 9, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
