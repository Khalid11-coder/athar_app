import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'guide_welcome_screen.dart';
import '../main.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  String _selectedType = 'tourist'; // 'tourist' or 'guide'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF5E35B1), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Text(
                'اختر نوع الحساب',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'اختر كيف ترغب في استخدام تطبيق أثر للمتابعة',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(fontSize: 13, color: const Color(0xFF6B7280)),
              ),
              const SizedBox(height: 32),

              // 1. بطاقة السائح
              _buildRoleCard(
                type: 'tourist',
                title: 'أنا سائح / زائر',
                badge: 'استكشاف وحجز',
                description: 'استكشف معالم المدينة المنورة التاريخية، احجز جولاتك بسهولة، وتتبع رحلاتك مع تذاكر QR الرقمية والخريطة التفاعلية.',
                icon: Icons.explore_rounded,
                color: const Color(0xFF5E35B1),
              ),
              const SizedBox(height: 18),

              // 2. بطاقة المرشد
              _buildRoleCard(
                type: 'guide',
                title: 'أنا مرشد سياحي',
                badge: 'تقديم الجولات والأرباح',
                description: 'انضم كمرشد سياحي معتمد، حدد أسعارك وجولاتك، استقبل طلبات السياح المباشرة وأدر أرباحك وجدول رحلاتك بكل سهولة.',
                icon: Icons.school_rounded,
                color: const Color(0xFFFF6F00),
              ),

              const Spacer(),

              // زر المتابعة
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5E35B1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                    ),
                    onPressed: () {
                      if (_selectedType == 'tourist') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const GuideWelcomeScreen()),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'المتابعة كـ ${_selectedType == 'tourist' ? 'سائح' : 'مرشد سياحي'}',
                          style: GoogleFonts.cairo(fontSize: 15.5, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
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

  Widget _buildRoleCard({
    required String type,
    required String title,
    required String badge,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _selectedType == type;

    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFFE5E7EB),
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected ? const Color(0xFF5E35B1).withOpacity(0.12) : Colors.black.withOpacity(0.03),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // راديو بوتن
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF5E35B1) : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFF9CA3AF),
                      width: 2,
                    ),
                  ),
                  child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
                ),
                const Spacer(),
                // الشارة
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge,
                    style: GoogleFonts.cairo(fontSize: 10.5, fontWeight: FontWeight.bold, color: color),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280), height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
