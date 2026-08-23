import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/guide_models.dart';
import 'guide_transactions_screen.dart';

class GuideEarningsScreen extends StatefulWidget {
  const GuideEarningsScreen({super.key});

  @override
  State<GuideEarningsScreen> createState() => _GuideEarningsScreenState();
}

class _GuideEarningsScreenState extends State<GuideEarningsScreen> {
  bool _showBalance = true;
  int _selectedChartPeriod = 0; // 0: أسبوع, 1: شهر

  final List<GuideTransactionItem> _transactions = GuideTransactionItem.getSampleTransactions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              // 1. الشريط العلوي
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        _showBalance ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: const Color(0xFF5E35B1),
                      ),
                      onPressed: () => setState(() => _showBalance = !_showBalance),
                    ),
                    const Icon(Icons.calendar_month_outlined, color: Color(0xFF5E35B1), size: 24),
                  ],
                ),
              ),

              // 2. بطاقة إجمالي الأرباح الكبيرة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEDE7F6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF5E35B1), size: 36),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('إجمالي الارباح', style: GoogleFonts.cairo(fontSize: 12, color: const Color(0xFF6B7280))),
                          Text(
                            _showBalance ? '12,450 ر.س' : '•••••• ر.س',
                            style: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                          ),
                          Row(
                            children: [
                              Text('عن الشهر الماضي', style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF6B7280))),
                              const SizedBox(width: 4),
                              Text('^ 12%', style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF16A34A))),
                              Text('حتى ', style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF6B7280))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // 3. الإحصائيات الأربعة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatBadge('عدد الجولات', '42 جولة', Icons.auto_awesome_rounded, const Color(0xFFFF9800)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildStatBadge('هذا الشهر', '7,800 ر.س', Icons.calendar_month_rounded, const Color(0xFF7E22CE)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildStatBadge('هذا الأسبوع', '2,100 ر.س', Icons.calendar_today_rounded, const Color(0xFF0288D1)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildStatBadge('اليوم', '350 ر.س', Icons.wb_sunny_outlined, const Color(0xFF10B981)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // 4. الرسم البياني التفاعلي
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ر.س', style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF9CA3AF))),
                          Row(
                            children: [
                              _buildPeriodChip(1, 'شهر'),
                              const SizedBox(width: 6),
                              _buildPeriodChip(0, 'أسبوع'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // رسم بياني كود أصيل
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: _EarningsChartPainter(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 5. سجل العمليات
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.tune_rounded, size: 14, color: Color(0xFF5E35B1)),
                            const SizedBox(width: 4),
                            Text('تصفية', style: GoogleFonts.cairo(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                          ],
                        ),
                        Text(
                          'سجل العمليات',
                          style: GoogleFonts.cairo(fontSize: 14.5, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _transactions.take(4).length,
                      itemBuilder: (context, index) {
                        final tx = _transactions[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Row(
                            children: [
                              // السعر والحالة
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '+${tx.amount.toInt()} ر.س',
                                    style: GoogleFonts.cairo(fontSize: 12.5, fontWeight: FontWeight.bold, color: const Color(0xFF16A34A)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: tx.isTransferred ? const Color(0xFFDCFCE7) : const Color(0xFFE0F2FE),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          tx.isTransferred ? Icons.check_circle_rounded : Icons.sync_rounded,
                                          size: 10,
                                          color: tx.isTransferred ? const Color(0xFF16A34A) : const Color(0xFF0288D1),
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          tx.isTransferred ? 'تم التحويل' : 'قيد التحويل',
                                          style: GoogleFonts.cairo(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: tx.isTransferred ? const Color(0xFF16A34A) : const Color(0xFF0288D1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),

                              // اسم الجولة والتاريخ
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(tx.tourTitle, style: GoogleFonts.cairo(fontSize: 12.5, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                                  Text(tx.date, style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF9CA3AF))),
                                ],
                              ),
                              const SizedBox(width: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(tx.imageUrl, width: 44, height: 44, fit: BoxFit.cover),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF5E35B1),
                          side: const BorderSide(color: Color(0xFF5E35B1)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GuideTransactionsScreen()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.arrow_back_ios_new_rounded, size: 14),
                            const SizedBox(width: 6),
                            Text('عرض جميع العمليات', style: GoogleFonts.cairo(fontSize: 12.5, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBadge(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.cairo(fontSize: 8.5, color: const Color(0xFF6B7280)), maxLines: 1),
          Text(value, style: GoogleFonts.cairo(fontSize: 10.5, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
        ],
      ),
    );
  }

  Widget _buildPeriodChip(int index, String label) {
    final isSelected = _selectedChartPeriod == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedChartPeriod = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEDE7F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFF9CA3AF),
          ),
        ),
      ),
    );
  }
}

class _EarningsChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF5E35B1)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF5E35B1)
      ..style = PaintingStyle.fill;

    final shadowDotPaint = Paint()
      ..color = const Color(0xFFEDE7F6)
      ..style = PaintingStyle.fill;

    // نقاط الأيام من السبت إلى الجمعة
    final points = [
      Offset(size.width * 0.05, size.height * 0.85), // السبت: 350
      Offset(size.width * 0.20, size.height * 0.72), // الأحد: 650
      Offset(size.width * 0.35, size.height * 0.50), // الاثنين: 1350
      Offset(size.width * 0.50, size.height * 0.55), // الثلاثاء: 1050
      Offset(size.width * 0.65, size.height * 0.30), // الأربعاء: 1800
      Offset(size.width * 0.80, size.height * 0.45), // الخميس: 1400
      Offset(size.width * 0.95, size.height * 0.20), // الجمعة: 2050
    ];

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, linePaint);

    for (var point in points) {
      canvas.drawCircle(point, 6, shadowDotPaint);
      canvas.drawCircle(point, 3.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
