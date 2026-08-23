import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuideEditProfileScreen extends StatefulWidget {
  const GuideEditProfileScreen({super.key});

  @override
  State<GuideEditProfileScreen> createState() => _GuideEditProfileScreenState();
}

class _GuideEditProfileScreenState extends State<GuideEditProfileScreen> {
  final _nameController = TextEditingController(text: 'عبد المحسن البرقاوي');
  final _bioController = TextEditingController(
    text: 'مرشد سياحي معتمد متخصص في معالم السيرة النبوية والمواقع التاريخية بالمدينة المنورة بخبرة أكثر من 5 سنوات.',
  );
  final _phoneController = TextEditingController(text: '0590708382');
  final _cityController = TextEditingController(text: 'المدينة المنورة');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1F2937), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'تعديل الملف الشخصي',
          style: GoogleFonts.cairo(fontSize: 17, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                children: [
                  Text(
                    'قم بتحديث بياناتك الشخصية ليتمكن السياح من التعرف عليك بشكل أفضل',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 16),

                  // صورة المرشد والكاميرا
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE7F6),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF5E35B1), width: 2),
                        ),
                        child: const Center(
                          child: Icon(Icons.person_rounded, size: 55, color: Color(0xFF5E35B1)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Color(0xFF5E35B1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt_rounded, size: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // بطاقة النموذج
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputField('الاسم الكامل', _nameController, Icons.person_outline_rounded),
                        const SizedBox(height: 12),
                        _buildInputField('رقم الجوال', _phoneController, Icons.phone_outlined),
                        const SizedBox(height: 12),
                        _buildInputField('المدينة', _cityController, Icons.location_on_outlined),
                        const SizedBox(height: 12),
                        Text(
                          'نبذة تعريفية',
                          style: GoogleFonts.cairo(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF374151)),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: TextField(
                            controller: _bioController,
                            maxLines: 3,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF1F2937)),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // زر الحفظ السفلي
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم حفظ التعديلات بنجاح ✅', style: GoogleFonts.cairo()),
                      backgroundColor: const Color(0xFF16A34A),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'حفظ التعديلات',
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

  Widget _buildInputField(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF374151)),
        ),
        const SizedBox(height: 4),
        Container(
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
}
