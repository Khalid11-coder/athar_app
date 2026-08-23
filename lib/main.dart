import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/tour_model.dart';
import 'screens/tour_details_screen.dart';
import 'screens/bookings_screen.dart';
import 'screens/map_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const AtharApp());
}

class AtharApp extends StatelessWidget {
  const AtharApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق أثر السياحي',
      debugShowCheckedModeBanner: false,
      // دعم كامل للغة العربية والاتجاه من اليمين لليسار (RTL)
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        primaryColor: const Color(0xFF5E35B1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5E35B1),
          primary: const Color(0xFF5E35B1),
          secondary: const Color(0xFFFF6F00), // البرتقالي المميز لهوية أثر
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF1F2937)),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

/// الشاشة الرئيسية التي تضم شريط التنقل السفلي والصفحات
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ExploreToursScreen(), // 1. شاشة استكشف الجولات المتطابقة مع فيجما
    ExploreMapScreen(),   // 2. شاشة الخريطة التفاعلية للمواقع التاريخية
    BookingsScreen(),     // 3. شاشة الحجوزات والتذاكر الرقمية
    FavoritesScreen(),    // 4. شاشة الجولات المفضلة
    ProfileScreen(),      // 5. شاشة الملف الشخصي والإعدادات
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: const Color(0xFF5E35B1),
              unselectedItemColor: const Color(0xFF9CA3AF),
              selectedLabelStyle: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              unselectedLabelStyle: GoogleFonts.cairo(
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore_outlined),
                  activeIcon: Icon(Icons.explore),
                  label: 'استكشف',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined),
                  activeIcon: Icon(Icons.map),
                  label: 'الخريطة',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.confirmation_number_outlined),
                  activeIcon: Icon(Icons.confirmation_number),
                  label: 'حجوزاتي',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_rounded),
                  activeIcon: Icon(Icons.favorite_rounded),
                  label: 'المفضلة',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  activeIcon: Icon(Icons.person_rounded),
                  label: 'حسابي',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// شاشة استكشف الجولات - مطابقة لتصميم Figma بدقة
class ExploreToursScreen extends StatefulWidget {
  const ExploreToursScreen({super.key});

  @override
  State<ExploreToursScreen> createState() => _ExploreToursScreenState();
}

class _ExploreToursScreenState extends State<ExploreToursScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<TourModel> _allTours = [];
  List<TourModel> _filteredTours = [];
  String _selectedCategory = 'الكل';

  final List<Map<String, dynamic>> _categories = [
    {'title': 'الكل', 'icon': Icons.grid_view_rounded},
    {'title': 'التاريخ', 'icon': Icons.menu_book_rounded},
    {'title': 'الطبيعة', 'icon': Icons.landscape_rounded},
    {'title': 'الدين', 'icon': Icons.mosque_rounded},
    {'title': 'الثقافة', 'icon': Icons.fort_rounded},
    {'title': 'العائلات', 'icon': Icons.groups_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _allTours = TourModel.getSampleTours();
    _filteredTours = List.from(_allTours);
  }

  void _applyFilter() {
    setState(() {
      final query = _searchController.text.trim().toLowerCase();
      _filteredTours = _allTours.where((tour) {
        final matchesCategory = _selectedCategory == 'الكل' || tour.category == _selectedCategory;
        final matchesSearch = query.isEmpty ||
            tour.title.toLowerCase().contains(query) ||
            tour.description.toLowerCase().contains(query) ||
            tour.location.toLowerCase().contains(query);
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void _toggleFavorite(TourModel tour) {
    setState(() {
      tour.isFavorite = !tour.isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          tour.isFavorite ? 'تمت الإضافة للمفضلة ❤️' : 'تمت الإزالة من المفضلة',
          style: GoogleFonts.cairo(),
        ),
      ),
    );
  }

  void _openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'تصفية نتائج الجولات',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 16),
              Text('نطاق السعر (ريال سعودي)', style: GoogleFonts.cairo(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              RangeSlider(
                values: const RangeValues(50, 200),
                min: 0,
                max: 300,
                divisions: 6,
                activeColor: const Color(0xFF5E35B1),
                inactiveColor: const Color(0xFFEDE7F6),
                labels: const RangeLabels('50 ر.س', '200 ر.س'),
                onChanged: (val) {},
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5E35B1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'تطبيق الفلتر',
                    style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xFF1F2937)),
            ),
            onPressed: () {},
          ),
        ),
        title: Text(
          'استكشف الجولات',
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: _openFilterBottomSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.tune_rounded, size: 18, color: Color(0xFF5E35B1)),
                    const SizedBox(width: 6),
                    Text(
                      'الفلتر',
                      style: GoogleFonts.cairo(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF5E35B1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط البحث المخصص
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => _applyFilter(),
                decoration: InputDecoration(
                  hintText: 'إلى أين تريد الذهاب؟',
                  hintStyle: GoogleFonts.cairo(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF9CA3AF)),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18, color: Color(0xFF9CA3AF)),
                          onPressed: () {
                            _searchController.clear();
                            _applyFilter();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // قائمة التصنيفات الأفقية (Category Chips)
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat['title'];
                return InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    setState(() {
                      _selectedCategory = cat['title'];
                    });
                    _applyFilter();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF5E35B1) : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFFE5E7EB),
                        width: 1.2,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF5E35B1).withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              )
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          cat['icon'],
                          size: 18,
                          color: isSelected ? Colors.white : const Color(0xFF5E35B1),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          cat['title'],
                          style: GoogleFonts.cairo(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? Colors.white : const Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // قائمة بطاقات الجولات السياحية
          Expanded(
            child: _filteredTours.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 12),
                        Text(
                          'لا توجد جولات مطابقة لبحثك',
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            color: const Color(0xFF6B7280),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    itemCount: _filteredTours.length,
                    itemBuilder: (context, index) {
                      final tour = _filteredTours[index];
                      return TourCardWidget(
                        tour: tour,
                        onFavoriteTap: () => _toggleFavorite(tour),
                        onTap: () {
                          // الانتقال لشاشة تفاصيل الجولة والحجز
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TourDetailsScreen(tour: tour),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// ودجت بطاقة الجولة السياحية المتوافقة مع فيجما
class TourCardWidget extends StatelessWidget {
  final TourModel tour;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  const TourCardWidget({
    super.key,
    required this.tour,
    required this.onFavoriteTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة الجولة مع الشارة وزر المفضلة
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        tour.imageUrl,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 130,
                          height: 130,
                          color: const Color(0xFFEDE7F6),
                          child: const Icon(Icons.image_not_supported_rounded, color: Color(0xFF5E35B1)),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 130,
                            height: 130,
                            color: const Color(0xFFF3F4F6),
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                      ),
                    ),
                    // شارة (الأكثر حجزاً / مميز)
                    if (tour.badgeText != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5E35B1).withOpacity(0.92),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tour.badgeText!,
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    // زر المفضلة
                    Positioned(
                      top: 8,
                      left: 8,
                      child: GestureDetector(
                        onTap: onFavoriteTap,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            tour.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color: tour.isFavorite ? const Color(0xFFEF4444) : Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                // عمود تفاصيل وبيانات الجولة
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // اسم الجولة
                      Text(
                        tour.title,
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // الموقع الجغرافي
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF9CA3AF)),
                          const SizedBox(width: 4),
                          Text(
                            tour.location,
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              color: const Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // نبذة عن الجولة
                      Text(
                        tour.description,
                        style: GoogleFonts.cairo(
                          fontSize: 11.5,
                          color: const Color(0xFF6B7280),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // بيانات المدة، السعة، والتقييم
                      Row(
                        children: [
                          // المدة
                          const Icon(Icons.access_time_rounded, size: 13, color: Color(0xFF6B7280)),
                          const SizedBox(width: 3),
                          Text(
                            tour.duration,
                            style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF4B5563)),
                          ),
                          const SizedBox(width: 8),
                          // السعة
                          const Icon(Icons.group_outlined, size: 13, color: Color(0xFF6B7280)),
                          const SizedBox(width: 3),
                          Text(
                            'حتى ${tour.maxPersons} أشخاص',
                            style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF4B5563)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // السعر والتقييم
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // التقييم
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFB300)),
                              const SizedBox(width: 3),
                              Text(
                                '${tour.rating}',
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1F2937),
                                ),
                              ),
                            ],
                          ),
                          // السعر مع البرتقالي المميز
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'ابتداءً من ',
                                  style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280)),
                                ),
                                TextSpan(
                                  text: '${tour.price.toInt()} ',
                                  style: GoogleFonts.cairo(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFF6F00), // لون برتقالي حيوي للهوية
                                  ),
                                ),
                                TextSpan(
                                  text: 'ريال',
                                  style: GoogleFonts.cairo(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF5E35B1),
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
