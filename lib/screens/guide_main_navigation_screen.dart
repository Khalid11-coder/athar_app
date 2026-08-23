import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'guide_dashboard_screen.dart';
import 'guide_requests_screen.dart';
import 'guide_bookings_screen.dart';
import 'guide_earnings_screen.dart';
import 'guide_profile_screen.dart';

class GuideMainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const GuideMainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<GuideMainNavigationScreen> createState() => _GuideMainNavigationScreenState();
}

class _GuideMainNavigationScreenState extends State<GuideMainNavigationScreen> {
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
      GuideDashboardScreen(onTabChange: _onTabSelect), // 1. الرئيسية
      const GuideRequestsScreen(),                     // 2. الطلبات
      const GuideBookingsScreen(),                     // 3. الحجوزات
      const GuideEarningsScreen(),                     // 4. الأرباح
      const GuideProfileScreen(),                      // 5. الحساب
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
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabSelect,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: const Color(0xFF5E35B1),
              unselectedItemColor: const Color(0xFF9CA3AF),
              selectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 11),
              unselectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.w500, fontSize: 10.5),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: 'الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_outlined),
                  activeIcon: Icon(Icons.assignment_rounded),
                  label: 'الطلبات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  activeIcon: Icon(Icons.calendar_month_rounded),
                  label: 'الحجوزات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  activeIcon: Icon(Icons.account_balance_wallet_rounded),
                  label: 'الأرباح',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  activeIcon: Icon(Icons.person_rounded),
                  label: 'الحساب',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
