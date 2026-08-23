import 'tour_model.dart';

enum BookingStatus {
  upcoming,   // قادم ومؤكد
  completed,  // مكتمل وسابق
  cancelled,  // ملغي
}

class BookingModel {
  final String id;
  final String ticketNumber;
  final TourModel tour;
  final DateTime bookingDate;
  final String timeSlot;
  final int personsCount;
  final double totalAmount;
  final BookingStatus status;
  final String guestName;
  final String paymentMethod;
  final String qrCodeData;

  BookingModel({
    required this.id,
    required this.ticketNumber,
    required this.tour,
    required this.bookingDate,
    required this.timeSlot,
    required this.personsCount,
    required this.totalAmount,
    required this.status,
    required this.guestName,
    this.paymentMethod = 'مدى (Mada) - منتهي بـ 4291',
    required this.qrCodeData,
  });

  static List<BookingModel> getSampleBookings() {
    final sampleTours = TourModel.getSampleTours();

    return [
      BookingModel(
        id: 'b1',
        ticketNumber: 'ATH-2026-8942',
        tour: sampleTours[0], // جبل أحد
        bookingDate: DateTime.now().add(const Duration(days: 2)),
        timeSlot: '04:30 مساءً',
        personsCount: 3,
        totalAmount: 360,
        status: BookingStatus.upcoming,
        guestName: 'خالد بن عبدالله',
        qrCodeData: 'ATHAR-TICKET-8942-JABAL-UHUD-3PAX',
      ),
      BookingModel(
        id: 'b2',
        ticketNumber: 'ATH-2026-5120',
        tour: sampleTours[1], // بئر غرس
        bookingDate: DateTime.now().add(const Duration(days: 5)),
        timeSlot: '08:00 صباحاً',
        personsCount: 2,
        totalAmount: 190,
        status: BookingStatus.upcoming,
        guestName: 'خالد بن عبدالله',
        qrCodeData: 'ATHAR-TICKET-5120-GHARS-WELL-2PAX',
      ),
      BookingModel(
        id: 'b3',
        ticketNumber: 'ATH-2026-3310',
        tour: sampleTours[2], // المسجد النبوي
        bookingDate: DateTime.now().subtract(const Duration(days: 12)),
        timeSlot: '06:30 صباحاً',
        personsCount: 4,
        totalAmount: 560,
        status: BookingStatus.completed,
        guestName: 'خالد بن عبدالله',
        qrCodeData: 'ATHAR-TICKET-3310-HARAM-4PAX',
      ),
      BookingModel(
        id: 'b4',
        ticketNumber: 'ATH-2026-1189',
        tour: sampleTours[4], // مزرعة طيبة
        bookingDate: DateTime.now().subtract(const Duration(days: 30)),
        timeSlot: '04:30 مساءً',
        personsCount: 2,
        totalAmount: 320,
        status: BookingStatus.cancelled,
        guestName: 'خالد بن عبدالله',
        qrCodeData: 'ATHAR-TICKET-1189-FARM-CANCELLED',
      ),
    ];
  }
}
