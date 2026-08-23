import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/guide_header_banner.dart';
import 'guide_main_navigation_screen.dart';

class GuideApplicationSuccessScreen extends StatelessWidget {
  const GuideApplicationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          const GuideHeaderBanner(showBack: false),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // دائرة الصح الكبيرة
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5E35B1),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x335E35B1),
                          blurRadius: 18,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.check_rounded, color: Colors.white, size: 52),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'تم استلام طلبك بنجاح!',
                    style: GoogleFonts.cairo(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'شكراً لك على انضمامك إلى منصة أثر. سيتم مراجعة طلبك خلال 24 - 48 ساعة، وسنرسل لك إشعاراً فور قبول طلبك',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      color: const Color(0xFF6B7280),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // بطاقة ماذا يحدث الآن
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'ماذا يحدث الآن',
                            style: GoogleFonts.cairo(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildTimelineStep(
                          icon: Icons.access_time_rounded,
                          title: 'جاري المراجعة',
                          subtitle: 'يقوم فريقنا بمراجعة بياناتك ومستنداتك',
                          isFirst: true,
                        ),
                        _buildTimelineStep(
                          icon: Icons.notifications_none_rounded,
                          title: 'إشعار القبول',
                          subtitle: 'سيصلك إشعار القبول عبر التطبيق والبريد الإلكتروني',
                        ),
                        _buildTimelineStep(
                          icon: Icons.person_outline_rounded,
                          title: 'تفعيل حسابك',
                          subtitle: 'بعد القبول يمكنك تسجيل الدخول والبدء في استقبال الحجوزات',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // زر العودة للرئيسية
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF5E35B1),
                  side: const BorderSide(color: Color(0xFF5E35B1), width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const GuideMainNavigationScreen()),
                    (route) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.home_outlined, size: 20, color: Color(0xFF5E35B1)),
                    const SizedBox(width: 8),
                    Text(
                      'العودة للرئيسية',
                      style: GoogleFonts.cairo(
                        fontSize: 15.5,
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
    );
  }

  Widget _buildTimelineStep({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFF5E35B1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 36,
                color: const Color(0xFFD8B4FE),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.cairo(
                    fontSize: 11,
                    color: const Color(0xFF6B7280),
                    height: 1.3,
                  ),
                ),
                if (!isLast) const SizedBox(height: 14),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
