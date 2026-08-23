import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/guide_header_banner.dart';
import 'guide_vehicle_info_screen.dart';

class GuidePersonalInfoScreen extends StatefulWidget {
  const GuidePersonalInfoScreen({super.key});

  @override
  State<GuidePersonalInfoScreen> createState() => _GuidePersonalInfoScreenState();
}

class _GuidePersonalInfoScreenState extends State<GuidePersonalInfoScreen> {
  final _nameController = TextEditingController(text: 'عبد المحسن يعقوب البرقاوي');
  final _phoneController = TextEditingController(text: '0590708382');
  final _emailController = TextEditingController(text: 'hsonbrg@gmail.com');
  final _dobController = TextEditingController(text: '15/04/1996');
  final _licenseNumberController = TextEditingController(text: '789456123');

  String _selectedCity = 'المدينة المنورة';
  String _selectedGender = 'ذكر';
  List<String> _selectedLanguages = ['العربية', 'الانجليزية'];
  bool _agreedToTerms = true;
  bool _licenseUploaded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          const GuideHeaderBanner(currentStep: 1, totalSteps: 5),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'البيانات الشخصية',
                    style: GoogleFonts.cairo(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ادخل بياناتك الشخصية كما هي في الهوية الوطنية',
                    style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 16),

                  // صورة البروفايل والكاميرا
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEDE7F6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person_rounded, size: 50, color: Color(0xFF7E57C2)),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF5E35B1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt_rounded, size: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'أضف صورتك الشخصية',
                    style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF374151)),
                  ),
                  Text(
                    'ويفضل صورة واضحة بخلفية بيضاء',
                    style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF9CA3AF)),
                  ),
                  const SizedBox(height: 16),

                  // الحقول: الاسم والجوال
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          label: 'الاسم الكامل *',
                          controller: _nameController,
                          icon: Icons.person_outline_rounded,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildInputField(
                          label: 'رقم الجوال *',
                          controller: _phoneController,
                          icon: Icons.phone_outlined,
                          isPhone: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // البريد والمدينة
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          label: 'البريد الإلكتروني *',
                          controller: _emailController,
                          icon: Icons.email_outlined,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildDropdownField(
                          label: 'المدينة *',
                          value: _selectedCity,
                          items: ['المدينة المنورة', 'مكة المكرمة', 'الرياض', 'جدة'],
                          icon: Icons.location_on_outlined,
                          onChanged: (v) => setState(() => _selectedCity = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // تاريخ الميلاد والجنس
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          label: 'تاريخ الميلاد *',
                          controller: _dobController,
                          icon: Icons.calendar_month_outlined,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildDropdownField(
                          label: 'الجنس *',
                          value: _selectedGender,
                          items: ['ذكر', 'أنثى'],
                          icon: Icons.person_outline,
                          onChanged: (v) => setState(() => _selectedGender = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // اللغات
                  _buildDropdownField(
                    label: 'اختر اللغات التي تتحدثها *',
                    value: 'العربية، الانجليزية',
                    items: ['العربية، الانجليزية', 'العربية فقط', 'العربية، الفرنسية', 'العربية، الأردية'],
                    icon: Icons.language_rounded,
                    onChanged: (v) {},
                  ),
                  const SizedBox(height: 12),

                  // رقم الرخصة ورفع الصورة
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          label: 'رقم رخصة الارشاد السياحي *',
                          controller: _licenseNumberController,
                          icon: Icons.badge_outlined,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'رفع صورة الرخصة *',
                              style: GoogleFonts.cairo(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF374151)),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 60,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3E8FF).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFD8B4FE)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.cloud_upload_outlined, color: Color(0xFF7E22CE), size: 20),
                                  Text(
                                    'اضغط لرفع الصورة - حد أقصى 5MB',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(fontSize: 8.5, color: const Color(0xFF6B7280)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // تنبيه الأمان
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.verified_user_outlined, color: Color(0xFF5E35B1), size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'لن يتم عرض بياناتك الشخصية للسياح، تستخدم فقط للتحقق من هوية المرشد وضمان جودة الخدمة.',
                            style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF4B5563), height: 1.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // الإقرار
                  Row(
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        activeColor: const Color(0xFF5E35B1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
                      ),
                      Expanded(
                        child: Text(
                          'أوافق على الشروط والأحكام وسياسة الخصوصية *',
                          style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF6B7280)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // الزر السفلي التالي
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GuideVehicleInfoScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'التالي',
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isPhone = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF374151)),
        ),
        const SizedBox(height: 4),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.cairo(fontSize: 12, color: const Color(0xFF1F2937)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(icon, size: 18, color: const Color(0xFF5E35B1)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF374151)),
        ),
        const SizedBox(height: 4),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF5E35B1), size: 20),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.cairo(fontSize: 12)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
