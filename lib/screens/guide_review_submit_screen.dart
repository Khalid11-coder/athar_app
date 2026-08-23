import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/guide_models.dart';
import '../widgets/guide_header_banner.dart';
import 'guide_application_success_screen.dart';

class GuideReviewSubmitScreen extends StatefulWidget {
  final List<GuideTourItem> tours;

  const GuideReviewSubmitScreen({super.key, required this.tours});

  @override
  State<GuideReviewSubmitScreen> createState() => _GuideReviewSubmitScreenState();
}

class _GuideReviewSubmitScreenState extends State<GuideReviewSubmitScreen> {
  bool _confirmAccuracy = true;
  bool _confirmTerms = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          const GuideHeaderBanner(currentStep: 5, totalSteps: 5),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'مراجعة وإرسال الطلب',
                    style: GoogleFonts.cairo(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'تأكد من صحة بياناتك قبل إرسال الطلب للمراجعة.',
                    style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 14),

                  // 1. بطاقة البيانات الشخصية
                  _buildReviewSection(
                    title: 'البيانات الشخصية',
                    icon: Icons.person_outline_rounded,
                    onEdit: () => Navigator.pop(context),
                    children: [
                      _buildInfoRow('الاسم الكامل', 'عبد المحسن يعقوب البرقاوي'),
                      const Divider(height: 12, color: Color(0xFFF3F4F6)),
                      _buildInfoRow('اللغات', 'العربية - الانجليزية'),
                      const Divider(height: 12, color: Color(0xFFF3F4F6)),
                      _buildInfoRow('رقم الجوال', '0590708382', icon: Icons.phone_outlined),
                      const Divider(height: 12, color: Color(0xFFF3F4F6)),
                      _buildInfoRow('البريد الإلكتروني', 'hsonbrg@gmail.com', icon: Icons.email_outlined),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 2. بطاقة بيانات السيارة
                  _buildReviewSection(
                    title: 'بيانات السيارة',
                    icon: Icons.directions_car_filled_outlined,
                    onEdit: () => Navigator.pop(context),
                    children: [
                      _buildInfoRow('نوع السيارة', 'SUV'),
                      const Divider(height: 12, color: Color(0xFFF3F4F6)),
                      _buildInfoRow('الشركة والموديل', 'تويوتا لاند كروزر'),
                      const Divider(height: 12, color: Color(0xFFF3F4F6)),
                      _buildInfoRow('سنة الصنع', '2023'),
                      const Divider(height: 12, color: Color(0xFFF3F4F6)),
                      _buildInfoRow('اللون', 'أبيض'),
                      const Divider(height: 12, color: Color(0xFFF3F4F6)),
                      _buildInfoRow('عدد المقاعد', '6 مقاعد'),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 3. بطاقة الجولات المختارة
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFEDE7F6),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              ),
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.edit_outlined, size: 14, color: Color(0xFF5E35B1)),
                              label: Text('تعديل', style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                            ),
                            Row(
                              children: [
                                Text('الجولات المختارة', style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                                const SizedBox(width: 6),
                                const Icon(Icons.location_on_outlined, size: 18, color: Color(0xFF5E35B1)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.end,
                          children: widget.tours.map((tour) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDE7F6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    tour.title,
                                    style: GoogleFonts.cairo(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.check_circle_rounded, size: 16, color: Color(0xFF5E35B1)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // الإقرارات
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _confirmAccuracy,
                              activeColor: const Color(0xFF5E35B1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              onChanged: (v) => setState(() => _confirmAccuracy = v ?? false),
                            ),
                            Expanded(
                              child: Text(
                                'أتعهد بأن جميع البيانات المذكورة أعلاه صحيحة *',
                                style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF4B5563)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _confirmTerms,
                              activeColor: const Color(0xFF5E35B1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              onChanged: (v) => setState(() => _confirmTerms = v ?? false),
                            ),
                            Expanded(
                              child: Text(
                                'أوافق على الشروط والأحكام وسياسة الخصوصية *',
                                style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF4B5563)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // الزر السفلي (إرسال الطلب)
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E35B1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const GuideApplicationSuccessScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'إرسال الطلب',
                      style: GoogleFonts.cairo(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _buildReviewSection({
    required String title,
    required IconData icon,
    required VoidCallback onEdit,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFEDE7F6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                ),
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, size: 14, color: Color(0xFF5E35B1)),
                label: Text('تعديل', style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
              ),
              Row(
                children: [
                  Text(title, style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                  const SizedBox(width: 6),
                  Icon(icon, size: 18, color: const Color(0xFF5E35B1)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {IconData? icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: const Color(0xFF5E35B1)),
              const SizedBox(width: 4),
            ],
            Text(
              value,
              style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
            ),
          ],
        ),
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
        ),
      ],
    );
  }
}
