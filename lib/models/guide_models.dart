import 'package:flutter/material.dart';

/// نموذج بيانات الجولة السياحية للمرشد
class GuideTourItem {
  final String id;
  final String title;
  final String duration;
  final String imageUrl;
  final double minPrice;
  final double maxPrice;
  double selectedPrice;
  bool isSelected;

  GuideTourItem({
    required this.id,
    required this.title,
    required this.duration,
    required this.imageUrl,
    required this.minPrice,
    required this.maxPrice,
    required this.selectedPrice,
    this.isSelected = false,
  });

  static List<GuideTourItem> getDefaultTours() {
    return [
      GuideTourItem(
        id: '1',
        title: 'جبل أحد',
        duration: '2-3 ساعات',
        imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?w=800&auto=format&fit=crop&q=80',
        minPrice: 100,
        maxPrice: 180,
        selectedPrice: 150,
        isSelected: true,
      ),
      GuideTourItem(
        id: '2',
        title: 'المسجد النبوي ومعالمه',
        duration: '3-4 ساعات',
        imageUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=800&auto=format&fit=crop&q=80',
        minPrice: 150,
        maxPrice: 250,
        selectedPrice: 200,
        isSelected: true,
      ),
      GuideTourItem(
        id: '3',
        title: 'بئر غرس',
        duration: '2-3 ساعات',
        imageUrl: 'https://images.unsplash.com/photo-1542810634-71277d95dcbb?w=800&auto=format&fit=crop&q=80',
        minPrice: 80,
        maxPrice: 150,
        selectedPrice: 120,
        isSelected: true,
      ),
      GuideTourItem(
        id: '4',
        title: 'جبل عير',
        duration: '1-2 ساعات',
        imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&auto=format&fit=crop&q=80',
        minPrice: 100,
        maxPrice: 180,
        selectedPrice: 140,
        isSelected: false,
      ),
      GuideTourItem(
        id: '5',
        title: 'مزرعة طيبة',
        duration: '3-4 ساعات',
        imageUrl: 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&auto=format&fit=crop&q=80',
        minPrice: 120,
        maxPrice: 220,
        selectedPrice: 170,
        isSelected: false,
      ),
      GuideTourItem(
        id: '6',
        title: 'مزارع العيون',
        duration: '1-2 ساعات',
        imageUrl: 'https://images.unsplash.com/photo-1542810634-71277d95dcbb?w=800&auto=format&fit=crop&q=80',
        minPrice: 120,
        maxPrice: 220,
        selectedPrice: 180,
        isSelected: true,
      ),
    ];
  }
}

/// نموذج بيانات طلب الجولة الوارد للمرشد
class GuideOrderModel {
  final String id;
  final String tourTitle;
  final String location;
  final String touristName;
  final String touristPhone;
  final int personsCount;
  final String date;
  final String time;
  final double proposedPrice;
  final String touristLanguage;
  final String carType;
  final String meetingLocation;
  final String touristNotes;
  final double tourBasePrice;
  final double commissionPercent;
  final String status; // 'new', 'pending', 'completed'
  final String imageUrl;
  final String badgeText;

  GuideOrderModel({
    required this.id,
    required this.tourTitle,
    this.location = 'المدينة المنورة',
    required this.touristName,
    this.touristPhone = '+966 59 070 8382',
    required this.personsCount,
    required this.date,
    required this.time,
    required this.proposedPrice,
    required this.touristLanguage,
    required this.carType,
    this.meetingLocation = 'فندق دار الإيمان إنتركونتيننتال - المدينة المنورة',
    this.touristNotes = 'نرجو التوقف 10 دقائق في جبل أحد للتصوير، نود تجربة مطعم شعبي لتناول الغداء إن أمكن.',
    this.tourBasePrice = 450,
    this.commissionPercent = 15,
    this.status = 'new',
    required this.imageUrl,
    this.badgeText = 'حكاية جبلية',
  });

  double get commissionAmount => tourBasePrice * (commissionPercent / 100);
  double get netEarnings => tourBasePrice - commissionAmount;

  static List<GuideOrderModel> getSampleOrders() {
    return [
      GuideOrderModel(
        id: 'ord-1',
        tourTitle: 'جولة جبل أحد',
        touristName: 'أحمد العتيبي',
        personsCount: 6,
        date: 'غداً 11 مايو',
        time: '9:00 صباحاً',
        proposedPrice: 220,
        touristLanguage: 'العربية',
        carType: 'عائلية',
        imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?w=800&auto=format&fit=crop&q=80',
        badgeText: 'حكاية جبلية',
      ),
      GuideOrderModel(
        id: 'ord-2',
        tourTitle: 'جولة المسجد النبوي',
        touristName: 'علي القحطاني',
        personsCount: 2,
        date: 'غداً 11 مايو',
        time: '9:00 صباحاً',
        proposedPrice: 180,
        touristLanguage: 'الصينية',
        carType: 'سيدان',
        imageUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=800&auto=format&fit=crop&q=80',
        badgeText: 'معالم إيمانية',
      ),
      GuideOrderModel(
        id: 'ord-3',
        tourTitle: 'جولة جبل عير',
        touristName: 'إبراهيم السهلي',
        personsCount: 4,
        date: 'غداً 11 مايو',
        time: '9:00 صباحاً',
        proposedPrice: 250,
        touristLanguage: 'الإنجليزية',
        carType: 'SUV',
        imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&auto=format&fit=crop&q=80',
        badgeText: 'طبيعة وتاريخ',
      ),
    ];
  }
}

/// نموذج حجز المرشد المؤكد
class GuideBookingItem {
  final String id;
  final String tourTitle;
  final String touristName;
  final int personsCount;
  final String dateTimeString;
  final String location;
  final double price;
  final String timeRemainingBadge;
  final Color badgeColor;
  final String imageUrl;
  final String status; // 'today', 'upcoming', 'completed'

  GuideBookingItem({
    required this.id,
    required this.tourTitle,
    required this.touristName,
    required this.personsCount,
    required this.dateTimeString,
    required this.location,
    required this.price,
    required this.timeRemainingBadge,
    required this.badgeColor,
    required this.imageUrl,
    this.status = 'today',
  });

  static List<GuideBookingItem> getSampleBookings() {
    return [
      GuideBookingItem(
        id: 'b1',
        tourTitle: 'جولة جبل أحد',
        touristName: 'أحمد العتيبي',
        personsCount: 4,
        dateTimeString: '9:00 صباحاً - 17 مايو 2026',
        location: 'فندق دار الإيمان إنتركونتيننتال',
        price: 450,
        timeRemainingBadge: 'في خلال 2 ساعة',
        badgeColor: const Color(0xFF10B981),
        imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?w=800&auto=format&fit=crop&q=80',
      ),
      GuideBookingItem(
        id: 'b2',
        tourTitle: 'جولة المسجد النبوي',
        touristName: 'حازم الحارثي',
        personsCount: 4,
        dateTimeString: '9:00 صباحاً - 17 مايو 2026',
        location: 'فندق دار الإيمان إنتركونتيننتال',
        price: 400,
        timeRemainingBadge: 'في خلال 6 ساعة',
        badgeColor: const Color(0xFFFF9800),
        imageUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=800&auto=format&fit=crop&q=80',
      ),
      GuideBookingItem(
        id: 'b3',
        tourTitle: 'جولة جبل عير',
        touristName: 'عبد المحسن البرقاوي',
        personsCount: 4,
        dateTimeString: '9:00 صباحاً - 17 مايو 2026',
        location: 'فندق دار الإيمان إنتركونتيننتال',
        price: 350,
        timeRemainingBadge: 'في خلال 5 ساعة',
        badgeColor: const Color(0xFF8B5CF6),
        imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&auto=format&fit=crop&q=80',
      ),
      GuideBookingItem(
        id: 'b4',
        tourTitle: 'جولة بئر غرس',
        touristName: 'ريان محمد',
        personsCount: 4,
        dateTimeString: '9:00 صباحاً - 17 مايو 2026',
        location: 'فندق دار الإيمان إنتركونتيننتال',
        price: 500,
        timeRemainingBadge: 'في خلال 8 ساعة',
        badgeColor: const Color(0xFF0288D1),
        imageUrl: 'https://images.unsplash.com/photo-1542810634-71277d95dcbb?w=800&auto=format&fit=crop&q=80',
      ),
    ];
  }
}

/// نموذج المعاملات المالية للأرباح
class GuideTransactionItem {
  final String id;
  final String tourTitle;
  final String touristName;
  final int personsCount;
  final String date;
  final String time;
  final double amount;
  final bool isTransferred;
  final String imageUrl;

  GuideTransactionItem({
    required this.id,
    required this.tourTitle,
    required this.touristName,
    required this.personsCount,
    required this.date,
    this.time = '9:00 صباحاً',
    required this.amount,
    required this.isTransferred,
    required this.imageUrl,
  });

  static List<GuideTransactionItem> getSampleTransactions() {
    return [
      GuideTransactionItem(
        id: 't1',
        tourTitle: 'جولة جبل أحد',
        touristName: 'أحمد العتيبي',
        personsCount: 4,
        date: '17 مايو 2026',
        amount: 450,
        isTransferred: true,
        imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?w=800&auto=format&fit=crop&q=80',
      ),
      GuideTransactionItem(
        id: 't2',
        tourTitle: 'جولة المسجد النبوي',
        touristName: 'علي القحطاني',
        personsCount: 6,
        date: '14 مايو 2026',
        amount: 500,
        isTransferred: true,
        imageUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=800&auto=format&fit=crop&q=80',
      ),
      GuideTransactionItem(
        id: 't3',
        tourTitle: 'جولة جبل عير',
        touristName: 'إبراهيم السهلي',
        personsCount: 3,
        date: '5 مايو 2026',
        amount: 350,
        isTransferred: true,
        imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&auto=format&fit=crop&q=80',
      ),
      GuideTransactionItem(
        id: 't4',
        tourTitle: 'جولة بئر غرس',
        touristName: 'محمد العوفي',
        personsCount: 3,
        date: '8 مايو 2026',
        amount: 400,
        isTransferred: true,
        imageUrl: 'https://images.unsplash.com/photo-1542810634-71277d95dcbb?w=800&auto=format&fit=crop&q=80',
      ),
      GuideTransactionItem(
        id: 't5',
        tourTitle: 'جولة مزارع طيبة',
        touristName: 'عبد المحسن البرقاوي',
        personsCount: 6,
        date: '10 مايو 2026',
        amount: 520,
        isTransferred: true,
        imageUrl: 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&auto=format&fit=crop&q=80',
      ),
    ];
  }
}
