import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import '../models/booking_model.dart';
import 'tour_details_screen.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<BookingModel> _bookings = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _bookings = BookingModel.getSampleBookings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<BookingModel> _getBookingsByStatus(BookingStatus status) {
    return _bookings.where((b) => b.status == status).toList();
  }

  void _openDigitalTicketModal(BookingModel booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DigitalTicketModal(booking: booking),
    );
  }

  @override
  Widget build(BuildContext context) {
    final upcomingCount = _getBookingsByStatus(BookingStatus.upcoming).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'حجوزاتي وتذاكري',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              Text(
                'إدارة التذاكر الرقمية ومواعيد الجولات',
                style: GoogleFonts.cairo(
                  fontSize: 12.5,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE7F6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.confirmation_number_rounded, size: 16, color: Color(0xFF5E35B1)),
                  const SizedBox(width: 6),
                  Text(
                    '$upcomingCount جولات نشطة',
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5E35B1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB).withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              labelColor: const Color(0xFF5E35B1),
              unselectedLabelColor: const Color(0xFF6B7280),
              labelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 13),
              unselectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.w600, fontSize: 13),
              tabs: const [
                Tab(text: 'القادمة'),
                Tab(text: 'المكتملة'),
                Tab(text: 'الملغاة'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsList(BookingStatus.upcoming),
          _buildBookingsList(BookingStatus.completed),
          _buildBookingsList(BookingStatus.cancelled),
        ],
      ),
    );
  }

  Widget _buildBookingsList(BookingStatus status) {
    final list = _getBookingsByStatus(status);

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFEDE7F6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                status == BookingStatus.upcoming
                    ? Icons.airplane_ticket_outlined
                    : Icons.history_rounded,
                size: 48,
                color: const Color(0xFF5E35B1),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              status == BookingStatus.upcoming
                  ? 'لا توجد لديك حجوزات قادمة'
                  : 'لا توجد حجوزات في هذا القسم',
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'استكشف الجولات المميزة في المدينة المنورة واحجز الآن',
              style: GoogleFonts.cairo(fontSize: 12.5, color: const Color(0xFF9CA3AF)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final booking = list[index];
        return BookingTicketCard(
          booking: booking,
          onViewTicket: () => _openDigitalTicketModal(booking),
          onTapTour: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TourDetailsScreen(tour: booking.tour),
              ),
            );
          },
        );
      },
    );
  }
}

/// بطاقة التذكرة بتصميم القصاصة والتخريم الأنيق (Perforated Ticket Card)
class BookingTicketCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback onViewTicket;
  final VoidCallback onTapTour;

  const BookingTicketCard({
    super.key,
    required this.booking,
    required this.onViewTicket,
    required this.onTapTour,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = intl.DateFormat('EEEE، d MMMM yyyy', 'ar').format(booking.bookingDate);

    Color statusBg;
    Color statusTextColor;
    String statusText;
    IconData statusIcon;

    switch (booking.status) {
      case BookingStatus.upcoming:
        statusBg = const Color(0xFFE8F5E9);
        statusTextColor = const Color(0xFF2E7D32);
        statusText = 'مؤكد وجاهز';
        statusIcon = Icons.check_circle_rounded;
        break;
      case BookingStatus.completed:
        statusBg = const Color(0xFFF3F4F6);
        statusTextColor = const Color(0xFF4B5563);
        statusText = 'مكتمل';
        statusIcon = Icons.task_alt_rounded;
        break;
      case BookingStatus.cancelled:
        statusBg = const Color(0xFFFFEBEE);
        statusTextColor = const Color(0xFFC62828);
        statusText = 'ملغي';
        statusIcon = Icons.cancel_rounded;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // الجزء العلوي من التذكرة
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة الجولة
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    booking.tour.imageUrl,
                    width: 85,
                    height: 85,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                // تفاصيل الجولة ورقم التذكرة
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(statusIcon, size: 12, color: statusTextColor),
                                const SizedBox(width: 4),
                                Text(
                                  statusText,
                                  style: GoogleFonts.cairo(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    color: statusTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            booking.ticketNumber,
                            style: GoogleFonts.cairo(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: onTapTour,
                        child: Text(
                          booking.tour.title,
                          style: GoogleFonts.cairo(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1F2937),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 13, color: Color(0xFF6B7280)),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              booking.tour.meetingPoint,
                              style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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

          // خط التخريم الفاصل (Perforated Divider)
          const TicketDottedDivider(),

          // الجزء السفلي من التذكرة (الموعد والمقاعد وزر العرض)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // التاريخ والوقت
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFF5E35B1)),
                        const SizedBox(width: 6),
                        Text(
                          '$formattedDate - ${booking.timeSlot}',
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                    // عدد التذاكر
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE7F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${booking.personsCount} تذاكر',
                        style: GoogleFonts.cairo(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5E35B1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // أزرار التفاعل مع التذكرة
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5E35B1),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: onViewTicket,
                          icon: const Icon(Icons.qr_code_rounded, size: 18, color: Colors.white),
                          label: Text(
                            'عرض التذكرة ورمز QR',
                            style: GoogleFonts.cairo(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.directions_rounded, size: 20, color: Color(0xFF374151)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'جاري فتح اتجاهات نقطة التجمع: ${booking.tour.meetingPoint}',
                                style: GoogleFonts.cairo(),
                              ),
                            ),
                          );
                        },
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

/// فاصل تخريم التذاكر الكلاسيكي
class TicketDottedDivider extends StatelessWidget {
  const TicketDottedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // فتحة نصف دائرية في اليمين
        Container(
          width: 12,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
        ),
        // خط متقطع
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              const dashWidth = 5.0;
              const dashSpace = 4.0;
              final dashCount = (constraints.constrainWidth() / (dashWidth + dashSpace)).floor();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(dashCount, (_) {
                  return const SizedBox(
                    width: dashWidth,
                    height: 1.5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xFFE5E7EB)),
                    ),
                  );
                }),
              );
            },
          ),
        ),
        // فتحة نصف دائرية في اليسار
        Container(
          width: 12,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}

/// نافذة بطاقة الصعود والتذكرة الرقمية الكاملة (Digital Boarding Pass)
class DigitalTicketModal extends StatelessWidget {
  final BookingModel booking;

  const DigitalTicketModal({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final formattedDate = intl.DateFormat('EEEE، d MMMM yyyy', 'ar').format(booking.bookingDate);

    return Container(
      margin: const EdgeInsets.only(top: 60),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // مقبض السحب
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 6),
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            // شريط العنوان
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'بطاقة الصعود الرقمية',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Color(0xFF6B7280)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // جسم التذكرة
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF5FF),
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: const Color(0xFFE9D5FF), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5E35B1).withOpacity(0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // رأس التذكرة الفاخر
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color(0xFF5E35B1),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تطبيق أثر السياحي',
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'تذكرة جولة معتمدة - المدينة المنورة',
                                  style: GoogleFonts.cairo(fontSize: 11, color: Colors.white70),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.verified_rounded, color: Colors.white, size: 24),
                            ),
                          ],
                        ),
                      ),

                      // تفاصيل التذكرة
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // اسم الجولة
                            Row(
                              children: [
                                const Icon(Icons.explore_rounded, color: Color(0xFF5E35B1), size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    booking.tour.title,
                                    style: GoogleFonts.cairo(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1F2937),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // شبكة البيانات
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildTicketInfoItem('اسم الزائر', booking.guestName),
                                _buildTicketInfoItem('رقم الحجز', booking.ticketNumber),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildTicketInfoItem('التاريخ', formattedDate),
                                _buildTicketInfoItem('الوقت المحدد', booking.timeSlot),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildTicketInfoItem('عدد الأشخاص', '${booking.personsCount} أفراد'),
                                _buildTicketInfoItem(
                                  'المبلغ المدفوع',
                                  '${booking.totalAmount.toInt()} ريال',
                                  highlightColor: const Color(0xFFFF6F00),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTicketInfoItem('نقطة التجمع', booking.tour.meetingPoint),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // خط القطع الفاصل
                      const TicketDottedDivider(),

                      // رمز الاستجابة السريعة (QR Code) والباركود
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // محاكاة رمز QR برسم متقن
                                  const CustomQrCodeWidget(),
                                  const SizedBox(height: 10),
                                  Text(
                                    booking.qrCodeData,
                                    style: GoogleFonts.robotoMono(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF6B7280),
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'يرجى إبراز هذا الرمز للمرشد السياحي عند نقطة التجمع',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cairo(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF5E35B1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // أزرار الإجراءات السريعة (حفظ في المحفظة ومشاركة)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              content: Text('تمت إضافة التذكرة إلى Apple Wallet بنجاح 📱', style: GoogleFonts.cairo()),
                            ),
                          );
                        },
                        icon: const Icon(Icons.wallet_rounded, color: Colors.white, size: 20),
                        label: Text(
                          'إضافة إلى Apple Wallet',
                          style: GoogleFonts.cairo(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.share_rounded, color: Color(0xFF5E35B1)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            content: Text('جاري مشاركة التذكرة الرقمية...', style: GoogleFonts.cairo()),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketInfoItem(String label, String value, {Color? highlightColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: highlightColor ?? const Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}

/// ودجت رسم رمز الاستجابة السريعة (Custom QR Simulation)
class CustomQrCodeWidget extends StatelessWidget {
  const CustomQrCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomPaint(
        painter: QrPatternPainter(),
      ),
    );
  }
}

class QrPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1F2937)
      ..style = PaintingStyle.fill;

    // رسم زوايا الـ QR الثلاث الكبرى (Position Markers)
    _drawMarker(canvas, const Offset(0, 0), 40, paint);
    _drawMarker(canvas, Offset(size.width - 40, 0), 40, paint);
    _drawMarker(canvas, Offset(0, size.height - 40), 40, paint);

    // رسم نقاط الماتريكس الداخلية
    final dotPaint = Paint()..color = const Color(0xFF5E35B1);
    final centerOffset = size.width / 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(centerOffset, centerOffset), width: 28, height: 28),
        const Radius.circular(6),
      ),
      dotPaint,
    );

    // نقاط متفرقة
    final randomDots = [
      Offset(size.width * 0.2, size.height * 0.5),
      Offset(size.width * 0.35, size.height * 0.3),
      Offset(size.width * 0.65, size.height * 0.3),
      Offset(size.width * 0.8, size.height * 0.5),
      Offset(size.width * 0.5, size.height * 0.7),
      Offset(size.width * 0.3, size.height * 0.75),
      Offset(size.width * 0.7, size.height * 0.75),
      Offset(size.width * 0.85, size.height * 0.85),
    ];

    for (var dot in randomDots) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: dot, width: 8, height: 8),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  void _drawMarker(Canvas canvas, Offset offset, double size, Paint paint) {
    // إطار خارجي
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(offset.dx, offset.dy, size, size),
        const Radius.circular(8),
      ),
      paint,
    );
    // فراغ أبيض داخلي
    final whitePaint = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(offset.dx + 6, offset.dy + 6, size - 12, size - 12),
        const Radius.circular(4),
      ),
      whitePaint,
    );
    // نقطة مركزية
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(offset.dx + 12, offset.dy + 12, size - 24, size - 24),
        const Radius.circular(3),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
