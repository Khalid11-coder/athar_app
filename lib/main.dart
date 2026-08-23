import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/tour_details_screen.dart';
import 'screens/bookings_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';
import 'models/tour_model.dart';

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
          secondary: const Color(0xFFFF6F00),
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.cairoTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF1F2937)),
        ),
      ),
      home: const SplashScreen(), // البداية بشاشة الترحيب والشعار الأصلي
    );
  }
}

/// الشاشة الرئيسية لتطبيق السائح (5 تبويبات تفاعلية)
class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelect(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onTabChange: _onTabSelect), // 1. الرئيسية
      const ExploreToursScreen(),             // 2. استكشف الجولات
      const ExploreMapScreen(),               // 3. الخريطة التفاعلية
      const BookingsScreen(),                 // 4. حجوزاتي وتذاكر QR
      const ProfileScreen(),                  // 5. حسابي والإعدادات
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabSelect,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: const Color(0xFF5E35B1),
              unselectedItemColor: const Color(0xFF9CA3AF),
              selectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 11.5),
              unselectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.w500, fontSize: 11),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: 'الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore_outlined),
                  activeIcon: Icon(Icons.explore),
                  label: 'استكشف',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined),
                  activeIcon: Icon(Icons.map_rounded),
                  label: 'الخريطة',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.confirmation_number_outlined),
                  activeIcon: Icon(Icons.confirmation_number_rounded),
                  label: 'حجوزاتي',
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

/// شاشة استكشف الجولات - متطابقة 100% مع فيجما
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 42,
                    height: 42,
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
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Color(0xFF1F2937)),
                      onPressed: () {},
                    ),
                  ),
                  Text(
                    'استكشف الجولات',
                    style: GoogleFonts.cairo(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  Container(
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
                ],
              ),
            ),

            // حقل البحث
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
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Icon(Icons.search_rounded, color: Color(0xFF9CA3AF), size: 22),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => _applyFilter(),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'إلى أين تريد الذهاب؟',
                          hintStyle: GoogleFonts.cairo(color: const Color(0xFF9CA3AF), fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // التصنيفات
            Container(
              height: 48,
              margin: const EdgeInsets.symmetric(vertical: 6),
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
                      setState(() => _selectedCategory = cat['title']);
                      _applyFilter();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF5E35B1) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(cat['icon'], size: 18, color: isSelected ? Colors.white : const Color(0xFF5E35B1)),
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

            // قائمة الجولات المطابقة لفيجما
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                itemCount: _filteredTours.length,
                itemBuilder: (context, index) {
                  final tour = _filteredTours[index];
                  return TourCardWidget(
                    tour: tour,
                    onFavoriteTap: () {
                      setState(() => tour.isFavorite = !tour.isFavorite);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TourDetailsScreen(tour: tour)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// بطاقة الجولة السياحية
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
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الصورة يسار
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
                          child: const Icon(Icons.image, color: Color(0xFF5E35B1)),
                        ),
                      ),
                    ),
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
                            style: GoogleFonts.cairo(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
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
                // البيانات يمين
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tour.title,
                          style: GoogleFonts.cairo(fontSize: 15.5, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                          maxLines: 1,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF9CA3AF)),
                            const SizedBox(width: 4),
                            Text(tour.location, style: GoogleFonts.cairo(fontSize: 12, color: const Color(0xFF6B7280))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tour.description,
                          style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280), height: 1.3),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded, size: 13, color: Color(0xFF6B7280)),
                            const SizedBox(width: 3),
                            Text(tour.duration, style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF4B5563))),
                            const SizedBox(width: 8),
                            const Icon(Icons.group_outlined, size: 13, color: Color(0xFF6B7280)),
                            const SizedBox(width: 3),
                            Text('حتى ${tour.maxPersons} أشخاص', style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF4B5563))),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFB300)),
                                const SizedBox(width: 3),
                                Text('${tour.rating}', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Text(
                              'ابتداءً من ${tour.price.toInt()} ريال',
                              style: GoogleFonts.cairo(fontSize: 12.5, fontWeight: FontWeight.bold, color: const Color(0xFFFF6F00)),
                            ),
                          ],
                        ),
                      ],
                    ),
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
