class TourModel {
  final String id;
  final String title;
  final String location;
  final String description;
  final String imageUrl;
  final List<String> gallery;
  final String duration;
  final int maxPersons;
  final double rating;
  final int reviewsCount;
  final double price;
  final String? badgeText;
  final String category;
  final String meetingPoint;
  final List<String> highlights;
  final List<String> includes;
  final List<String> availableTimeSlots;
  bool isFavorite;

  TourModel({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.imageUrl,
    this.gallery = const [],
    required this.duration,
    required this.maxPersons,
    required this.rating,
    this.reviewsCount = 128,
    required this.price,
    this.badgeText,
    required this.category,
    this.meetingPoint = 'مواقف الزوار الرئيسية',
    this.highlights = const [],
    this.includes = const [],
    this.availableTimeSlots = const ['08:00 صباحاً', '04:30 مساءً', '07:00 مساءً'],
    this.isFavorite = false,
  });

  static List<TourModel> getSampleTours() {
    return [
      TourModel(
        id: '1',
        title: 'جبل أحد التاريخي',
        location: 'المدينة المنورة',
        description: 'اكتشف أحد أشهر المعالم التاريخية في المدينة المنورة وموقع غزوة أحد، وتعرف على قصص البطولة وجبل الرماة ومقبرة الشهداء مع مرشد مرخص يقدم شرحاً تاريخياً وإيمانياً عميقاً.',
        imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?w=800&auto=format&fit=crop&q=80',
        gallery: [
          'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?w=800&auto=format&fit=crop&q=80',
          'https://images.unsplash.com/photo-1542810634-71277d95dcbb?w=800&auto=format&fit=crop&q=80',
        ],
        duration: 'ساعتان',
        maxPersons: 4,
        rating: 4.8,
        reviewsCount: 245,
        price: 120,
        badgeText: 'الأكثر حجزاً',
        category: 'التاريخ',
        meetingPoint: 'ساحة شهداء أحد - بوابة رقم 1',
        highlights: [
          'الصعود إلى جبل الرماة واستشعار تفاصيل غزوة أحد',
          'زيارة مقبرة شهداء أحد ومسجد سيد الشهداء حمزة رضي الله عنه',
          'شرح تاريخي موثق مع مرشد سياحي معتمد من وزارة السياحة',
          'فرصة لالتقاط صور تذكارية بانورامية لجبل أحد',
        ],
        includes: [
          'مرشد سياحي سعودي مرخص ومختص بالتاريخ الإسلامي',
          'مياه شرب وضيافة المدينة (تمر عجوة وقهوة سعودية)',
          'سماعات صوتية لاسلكية للشرح الواضح',
        ],
        availableTimeSlots: ['07:30 صباحاً', '04:30 مساءً', '06:30 مساءً'],
        isFavorite: false,
      ),
      TourModel(
        id: '2',
        title: 'بئر غرس ومعالم السيرة',
        location: 'المدينة المنورة',
        description: 'جولة روحانية وإثرائية لزيارة بئر غرس التاريخية، أحد الآبار المباركة التي ارتبطت بحياة النبي ﷺ ووضوئه ومسجد قباء ومزارع قباء الغناء.',
        imageUrl: 'https://images.unsplash.com/photo-1542810634-71277d95dcbb?w=800&auto=format&fit=crop&q=80',
        gallery: [
          'https://images.unsplash.com/photo-1542810634-71277d95dcbb?w=800&auto=format&fit=crop&q=80',
        ],
        duration: 'ساعة ونصف',
        maxPersons: 5,
        rating: 4.9,
        reviewsCount: 189,
        price: 95,
        badgeText: 'مميز',
        category: 'الدين',
        meetingPoint: 'ساحة بئر غرس التراثية - قباء',
        highlights: [
          'التعرف على تاريخ بئر غرس وإعادة تأهيلها الحديثة',
          'سرد قصص نبوية موثقة ارتبطت بالمكان المبارك',
          'المرور بمسار قباء والمزارع المجاورة',
        ],
        includes: [
          'مرشد تاريخي معتمد',
          'ضيافة وتمر عجوة المدينة',
          'كتيب رقمي تفاعلي عن معالم السيرة',
        ],
        availableTimeSlots: ['08:00 صباحاً', '05:00 مساءً'],
        isFavorite: true,
      ),
      TourModel(
        id: '3',
        title: 'المسجد النبوي ومعالمه',
        location: 'المدينة المنورة',
        description: 'جولة إيمانية شاملة نتعرف فيها على معالم المسجد النبوي الشريف، البقيع، السقيفة، والأبواب التاريخية مع إيضاحات لأهم مراحل التوسعة والعمارة عبر العصور.',
        imageUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=800&auto=format&fit=crop&q=80',
        gallery: [
          'https://images.unsplash.com/photo-1564769625905-50e93615e769?w=800&auto=format&fit=crop&q=80',
        ],
        duration: 'ساعتان ونصف',
        maxPersons: 6,
        rating: 4.8,
        reviewsCount: 310,
        price: 140,
        badgeText: 'الأكثر حجزاً',
        category: 'الدين',
        meetingPoint: 'الساحة الشمالية للحرم النبوي - بوابة 21',
        highlights: [
          'شرح تاريخي لأروقة ومآذن وقباب الحرم النبوي الشريف',
          'التعريف بمعالم الساحة المحيطة وسقيفة بني ساعدة ومقبرة البقيع',
          'معلومات حصرية وموثقة عن مراحل العمارة الإسلامية',
        ],
        includes: [
          'مرشد وباحث في تاريخ المدينة المنورة',
          'جهاز صوتي نقي لكل زائر',
          'مشروبات باردة وقهوة سعودية',
        ],
        availableTimeSlots: ['06:30 صباحاً', '04:00 مساءً', '08:30 مساءً'],
        isFavorite: false,
      ),
      TourModel(
        id: '4',
        title: 'جبل عير والآثار القديمة',
        location: 'المدينة المنورة',
        description: 'جولة استكشافية تجمع بين الطبيعة البرية والتاريخ في جبل عير، الحد الجنوبي لحرم المدينة المنورة، واستكشاف المسارات الجيولوجية والآثار القديمة.',
        imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&auto=format&fit=crop&q=80',
        duration: 'ثلاث ساعات',
        maxPersons: 6,
        rating: 4.8,
        reviewsCount: 94,
        price: 130,
        badgeText: 'الأكثر حجزاً',
        category: 'الطبيعة',
        meetingPoint: 'مركز نقطة تجمع المسار الجنوبي',
        highlights: [
          'الاستمتاع بإطلالات بانورامية على جنوب المدينة المنورة',
          'التعرف على حدود الحرم النبوي الشريف التاريخية',
          'مسار مشي خفيف واستكشاف الطبيعة الصخرية',
        ],
        includes: [
          'سيارة دفع رباعي مريحة للتنقل',
          'مرشد مسارات جبلية وتاريخية',
          'وجبة خفيفة ومشروبات منعشة',
        ],
        availableTimeSlots: ['06:00 صباحاً', '04:00 مساءً'],
        isFavorite: false,
      ),
      TourModel(
        id: '5',
        title: 'مزرعة طيبة للنخيل',
        location: 'المدينة المنورة',
        description: 'عش تجربة ريفية فريدة بين نخيل المدينة العريقة، وتعرف على طريقة جني التمور وأنواعها الشهيرة وتناول وجبة ضيافة مدينية أصيلة في قلب المزرعة.',
        imageUrl: 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&auto=format&fit=crop&q=80',
        duration: 'ثلاث ساعات',
        maxPersons: 6,
        rating: 4.8,
        reviewsCount: 156,
        price: 160,
        badgeText: 'الأكثر حجزاً',
        category: 'الطبيعة',
        meetingPoint: 'بوابة مزرعة طيبة التراثية',
        highlights: [
          'جولة في بساتين النخيل والتعرف على تمور العجوة والمجدول',
          'جلسة ريفية تراثية مع مأكولات ومشروبات مدينية طازجة',
          'فعاليات تفاعلية وتجربة قطف وجني المحصول',
        ],
        includes: [
          'تذوق أصناف متعددة من التمور الفاخرة',
          'وجبة إفطار أو عشاء مديني تراثي',
          'هدية عبوة تمر عجوة المدينة لكل زائر',
        ],
        availableTimeSlots: ['08:30 صباحاً', '04:30 مساءً'],
        isFavorite: false,
      ),
    ];
  }
}
