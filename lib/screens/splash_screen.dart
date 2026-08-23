import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const _logoUrl =
      'https://www.figma.com/api/mcp/asset/e0e02860-b356-4390-8fde-6d2155ec0e66.png';
  static const _bgMountainsUrl =
      'https://www.figma.com/api/mcp/asset/6540f202-c1f2-46df-8314-4912df7e0853.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFF),
      body: Stack(
        children: [
          // الخلفية الزخرفية لمعالم المدينة المنورة وجبالها
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.network(
              _bgMountainsUrl,
              height: 420,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 380,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFEDE7F6), Color(0xFFF8F9FA)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // اختيار اللغة
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.language_rounded, size: 16, color: Color(0xFF5E35B1)),
                          const SizedBox(width: 6),
                          Text('العربية', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold)),
                          const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF6B7280)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // شعار تطبيق أثر الأصلي من فيجما
                  Image.network(
                    _logoUrl,
                    width: 220,
                    height: 220,
                    errorBuilder: (_, __, ___) => Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE7F6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Icon(Icons.terrain_rounded, size: 80, color: Color(0xFF5E35B1)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'أثر',
                    style: GoogleFonts.cairo(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5E35B1),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'استكشف المعالم التاريخية واحجز مع مرشدين\nسياحيين مرخصين بكل سهولة.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 14.5,
                      color: const Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),

                  // زر إبدأ رحلتك
                  Padding(
                    padding: const EdgeInsets.only(bottom: 36),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5E35B1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 3,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'إبدأ رحلتك',
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
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
        ],
      ),
    );
  }
}
