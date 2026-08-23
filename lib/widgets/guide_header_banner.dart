import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuideHeaderBanner extends StatelessWidget {
  final String? stepText;
  final int? currentStep;
  final int totalSteps;
  final VoidCallback? onBack;
  final bool showBack;

  const GuideHeaderBanner({
    super.key,
    this.stepText,
    this.currentStep,
    this.totalSteps = 5,
    this.onBack,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 190,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFE9D5FF), // Soft purple top
                Color(0xFFF3E8FF),
                Color(0xFFF8F9FA),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              // رسم توضيحي لمعالم المدينة والجبال والمآذن بالخلفية
              Positioned.fill(
                child: CustomPaint(
                  painter: _MadinahSkylinePainter(),
                ),
              ),

              // أزرار التحكم العلوية (زر الرجوع + زر اختيار اللغة)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // سهم الرجوع في اليسار
                      if (showBack)
                        IconButton(
                          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF5E35B1), size: 26),
                          onPressed: onBack ?? () => Navigator.maybePop(context),
                        )
                      else
                        const SizedBox(width: 48),

                      // اختيار اللغة في اليمين (العربية)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.language_rounded, color: Color(0xFF5E35B1), size: 18),
                            const SizedBox(width: 6),
                            Text(
                              'العربية',
                              style: GoogleFonts.cairo(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6B7280), size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // مؤشر الخطوات (إذا كان محدداً)
        if (currentStep != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                Text(
                  stepText ?? 'الخطوة $currentStep من $totalSteps',
                  style: GoogleFonts.cairo(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(totalSteps, (index) {
                    final isCurrent = index + 1 == currentStep;
                    final isPassed = index + 1 < currentStep!;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isCurrent ? 24 : 14,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isCurrent || isPassed
                            ? const Color(0xFF5E35B1)
                            : const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _MadinahSkylinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final mountainPaint = Paint()
      ..color = const Color(0xFFC084FC).withOpacity(0.28)
      ..style = PaintingStyle.fill;

    final minaretPaint = Paint()
      ..color = const Color(0xFF7E22CE).withOpacity(0.35)
      ..style = PaintingStyle.fill;

    // رسم جبال أحد بالخلفية
    final path = Path();
    path.moveTo(0, size.height * 0.85);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.45, size.width * 0.5, size.height * 0.55);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.35, size.width, size.height * 0.65);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, mountainPaint);

    // رسم القبة والمآذن
    final center = Offset(size.width * 0.45, size.height * 0.82);
    // قبة المسجد
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 60, height: 50),
      3.14,
      3.14,
      true,
      minaretPaint,
    );

    // مئذنة يسار
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.28, size.height * 0.45, 6, size.height * 0.45),
      minaretPaint,
    );
    // مئذنة يمين
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.44, size.height * 0.35, 7, size.height * 0.55),
      minaretPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
