import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import '../models/tour_model.dart';

class TourDetailsScreen extends StatefulWidget {
  final TourModel tour;

  const TourDetailsScreen({super.key, required this.tour});

  @override
  State<TourDetailsScreen> createState() => _TourDetailsScreenState();
}

class _TourDetailsScreenState extends State<TourDetailsScreen> {
  int _personsCount = 1;
  int _selectedDateIndex = 0;
  String _selectedTimeSlot = '';
  bool _isFavorite = false;

  late List<DateTime> _availableDates;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.tour.isFavorite;
    if (widget.tour.availableTimeSlots.isNotEmpty) {
      _selectedTimeSlot = widget.tour.availableTimeSlots.first;
    }
    // إنشاء تواريخ الأيام السبعة القادمة للحجز
    _availableDates = List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  }

  void _confirmBooking() {
    final selectedDate = _availableDates[_selectedDateIndex];
    final formattedDate = intl.DateFormat('EEEE، d MMMM', 'ar').format(selectedDate);
    final totalPrice = widget.tour.price * _personsCount;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildBookingConfirmationSheet(formattedDate, totalPrice),
    );
  }

  Widget _buildBookingConfirmationSheet(String formattedDate, double totalPrice) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // رأس التذكرة
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE7F6),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: Color(0xFF5E35B1), size: 40),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'تفاصيل حجز الجولة',
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Center(
            child: Text(
              'راجع تفاصيل حجزك قبل المتابعة لخطوة الدفع',
              style: GoogleFonts.cairo(fontSize: 13, color: const Color(0xFF6B7280)),
            ),
          ),
          const SizedBox(height: 20),

          // ملخص الحجز
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              children: [
                _buildSummaryRow('الجولة', widget.tour.title, isBold: true),
                const Divider(height: 20),
                _buildSummaryRow('الموعد', '$formattedDate - $_selectedTimeSlot'),
                const Divider(height: 20),
                _buildSummaryRow('عدد الأشخاص', '$_personsCount أشخاص'),
                const Divider(height: 20),
                _buildSummaryRow('نقطة التجمع', widget.tour.meetingPoint),
                const Divider(height: 20),
                _buildSummaryRow(
                  'المبلغ الإجمالي',
                  '${totalPrice.toInt()} ريال سعودي',
                  isBold: true,
                  valueColor: const Color(0xFFFF6F00),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // زر الانتقال للدفع
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5E35B1),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF2E7D32),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    content: Text(
                      'تم تسجيل طلب الحجز بنجاح! 🎉',
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
              child: Text(
                'متابعة الحجز والدفع',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 13,
            color: const Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: GoogleFonts.cairo(
              fontSize: 13.5,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: valueColor ?? const Color(0xFF1F2937),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice = widget.tour.price * _personsCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // شريط التطبيق العلوي مع الصورة التفاعلية
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: const Color(0xFF5E35B1),
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.4),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: _isFavorite ? const Color(0xFFEF4444) : Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                        widget.tour.isFavorite = _isFavorite;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: IconButton(
                    icon: const Icon(Icons.share_outlined, color: Colors.white, size: 20),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.tour.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  // تدرج لوني لضمان وضوح الأزرار والشارات
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  // الشارة وعنوان الجولة في أسفل الصورة
                  Positioned(
                    bottom: 24,
                    right: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.tour.badgeText != null)
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6F00),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.tour.badgeText!,
                              style: GoogleFonts.cairo(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        Text(
                          widget.tour.title,
                          style: GoogleFonts.cairo(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded, color: Colors.white70, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              widget.tour.location,
                              style: GoogleFonts.cairo(fontSize: 13, color: Colors.white70),
                            ),
                            const Spacer(),
                            const Icon(Icons.star_rounded, color: Color(0xFFFFB300), size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.tour.rating}',
                              style: GoogleFonts.cairo(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              ' (${widget.tour.reviewsCount} تقييم)',
                              style: GoogleFonts.cairo(fontSize: 12, color: Colors.white70),
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

          // المحتوى الداخلي لتفاصيل الجولة والحجز
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // بطاقات الإحصائيات السريعة (المدة، السعة، نقطة التجمع)
                  Row(
                    children: [
                      _buildQuickStatCard(
                        icon: Icons.access_time_filled_rounded,
                        title: 'المدة',
                        value: widget.tour.duration,
                      ),
                      const SizedBox(width: 10),
                      _buildQuickStatCard(
                        icon: Icons.people_alt_rounded,
                        title: 'السعة',
                        value: 'حتى ${widget.tour.maxPersons} أشخاص',
                      ),
                      const SizedBox(width: 10),
                      _buildQuickStatCard(
                        icon: Icons.language_rounded,
                        title: 'اللغة',
                        value: 'العربية / الإنجليزية',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // نبذة عن الجولة
                  Text(
                    'عن الجولة',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.tour.description,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: const Color(0xFF4B5563),
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // نقطة التجمع
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE7F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.place_rounded, color: Color(0xFF5E35B1), size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'نقطة التجمع والانطلاق',
                                style: GoogleFonts.cairo(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1F2937),
                                ),
                              ),
                              Text(
                                widget.tour.meetingPoint,
                                style: GoogleFonts.cairo(fontSize: 12, color: const Color(0xFF6B7280)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // أبرز محطات الجولة
                  if (widget.tour.highlights.isNotEmpty) ...[
                    Text(
                      'أبرز المحطات والتجارب',
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...widget.tour.highlights.map((highlight) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Icon(Icons.stars_rounded, color: Color(0xFFFF6F00), size: 18),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  highlight,
                                  style: GoogleFonts.cairo(fontSize: 13.5, color: const Color(0xFF374151), height: 1.4),
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                  ],

                  // ماذا تشمل الجولة
                  if (widget.tour.includes.isNotEmpty) ...[
                    Text(
                      'ماذا تشمل الجولة؟',
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        children: widget.tour.includes
                            .map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF2E7D32), size: 18),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: GoogleFonts.cairo(fontSize: 13, color: const Color(0xFF374151)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],

                  // ==============================
                  // قسم تحديد الحجز (التاريخ والوقت والأشخاص)
                  // ==============================
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_month_rounded, color: Color(0xFF5E35B1), size: 22),
                            const SizedBox(width: 8),
                            Text(
                              'اختر موعد الجولة',
                              style: GoogleFonts.cairo(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // روزنامة الأيام الأفقية
                        SizedBox(
                          height: 75,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _availableDates.length,
                            separatorBuilder: (context, index) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final date = _availableDates[index];
                              final isSelected = _selectedDateIndex == index;
                              final dayName = intl.DateFormat('E', 'ar').format(date);
                              final dayNum = intl.DateFormat('d', 'ar').format(date);

                              return InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () => setState(() => _selectedDateIndex = index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 62,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFFF9FAFB),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFFE5E7EB),
                                      width: 1.2,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dayName,
                                        style: GoogleFonts.cairo(
                                          fontSize: 12,
                                          color: isSelected ? Colors.white70 : const Color(0xFF6B7280),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        dayNum,
                                        style: GoogleFonts.cairo(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? Colors.white : const Color(0xFF1F2937),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        // اختيار وقت الجولة
                        Text(
                          'الأوقات المتاحة',
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF374151),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.tour.availableTimeSlots.map((slot) {
                            final isSelected = _selectedTimeSlot == slot;
                            return ChoiceChip(
                              label: Text(slot),
                              selected: isSelected,
                              selectedColor: const Color(0xFFEDE7F6),
                              backgroundColor: const Color(0xFFF9FAFB),
                              side: BorderSide(
                                color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFFE5E7EB),
                              ),
                              labelStyle: GoogleFonts.cairo(
                                color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFF4B5563),
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                fontSize: 12.5,
                              ),
                              onSelected: (_) => setState(() => _selectedTimeSlot = slot),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // عداد الأشخاص / التذاكر
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'عدد الأشخاص',
                                  style: GoogleFonts.cairo(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF374151),
                                  ),
                                ),
                                Text(
                                  'السعة المتبقية: ${widget.tour.maxPersons} مقاعد',
                                  style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF9CA3AF)),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_rounded, size: 20),
                                    onPressed: _personsCount > 1
                                        ? () => setState(() => _personsCount--)
                                        : null,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      '$_personsCount',
                                      style: GoogleFonts.cairo(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1F2937),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_rounded, size: 20),
                                    onPressed: _personsCount < widget.tour.maxPersons
                                        ? () => setState(() => _personsCount++)
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100), // مساحة للشريط السفلي الثابت
                ],
              ),
            ),
          ),
        ],
      ),

      // شريط الحجز السفلي الثابت
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // السعر الإجمالي
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الإجمالي ($_personsCount أشخاص)',
                    style: GoogleFonts.cairo(fontSize: 12, color: const Color(0xFF6B7280)),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${totalPrice.toInt()} ',
                          style: GoogleFonts.cairo(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF6F00), // لون برتقالي حيوي للهوية
                          ),
                        ),
                        TextSpan(
                          text: 'ريال',
                          style: GoogleFonts.cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF5E35B1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),

              // زر احجز الآن
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5E35B1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _confirmBooking,
                    child: Text(
                      'احجز الآن',
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStatCard({required IconData icon, required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF5E35B1), size: 22),
            const SizedBox(height: 6),
            Text(
              title,
              style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cairo(
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
