import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/guide_header_banner.dart';
import 'guide_tour_selection_screen.dart';

class GuideVehicleInfoScreen extends StatefulWidget {
  const GuideVehicleInfoScreen({super.key});

  @override
  State<GuideVehicleInfoScreen> createState() => _GuideVehicleInfoScreenState();
}

class _GuideVehicleInfoScreenState extends State<GuideVehicleInfoScreen> {
  String _selectedType = 'SUV';
  String _selectedCompany = 'تويوتا';
  String _selectedModel = 'لاند كروزر';
  String _selectedYear = '2023';
  String _selectedColor = 'أبيض';
  String _selectedSeats = '6 مقاعد';
  bool _agreedToVehicleTerms = true;

  final List<Map<String, dynamic>> _vehicleTypes = [
    {'title': 'فاخرة', 'icon': Icons.directions_car_filled_rounded},
    {'title': 'عائلية', 'icon': Icons.airport_shuttle_rounded},
    {'title': 'SUV', 'icon': Icons.electric_car_rounded},
    {'title': 'سيدان', 'icon': Icons.directions_car_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          const GuideHeaderBanner(currentStep: 2, totalSteps: 5),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'بيانات السيارة',
                    style: GoogleFonts.cairo(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ادخل معلومات سيارتك كما هي في الواقع',
                    style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 14),

                  // كروت اختيار نوع السيارة (4 كروت)
                  Row(
                    children: _vehicleTypes.map((type) {
                      final isSelected = _selectedType == type['title'];
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedType = type['title']),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF5E35B1) : const Color(0xFFE5E7EB),
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected
                                      ? const Color(0xFF5E35B1).withOpacity(0.15)
                                      : Colors.black.withOpacity(0.02),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  type['icon'],
                                  color: const Color(0xFF5E35B1),
                                  size: 26,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  type['title'],
                                  style: GoogleFonts.cairo(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1F2937),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // الشركة والموديل
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelectField(
                          label: 'الشركة *',
                          value: _selectedCompany,
                          items: ['تويوتا', 'لكزس', 'هيونداي', 'مرسيدس', 'فورد'],
                          icon: Icons.business_rounded,
                          onChanged: (v) => setState(() => _selectedCompany = v!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildSelectField(
                          label: 'الموديل *',
                          value: _selectedModel,
                          items: ['لاند كروزر', 'برادو', 'كامري', 'هايلاندر', 'سيكويا'],
                          icon: Icons.directions_car_rounded,
                          onChanged: (v) => setState(() => _selectedModel = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // سنة الصنع واللون
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelectField(
                          label: 'سنة الصنع *',
                          value: _selectedYear,
                          items: ['2024', '2023', '2022', '2021', '2020'],
                          icon: Icons.edit_calendar_rounded,
                          onChanged: (v) => setState(() => _selectedYear = v!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildSelectField(
                          label: 'اللون *',
                          value: _selectedColor,
                          items: ['أبيض', 'أسود', 'فضي', 'رمادي', 'كحلي'],
                          icon: Icons.color_lens_outlined,
                          onChanged: (v) => setState(() => _selectedColor = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // عدد المقاعد
                  _buildSelectField(
                    label: 'عدد المقاعد المتاحة للسياح *',
                    value: _selectedSeats,
                    items: ['4 مقاعد', '6 مقاعد', '7 مقاعد', '10 مقاعد'],
                    icon: Icons.airline_seat_recline_normal_rounded,
                    onChanged: (v) => setState(() => _selectedSeats = v!),
                  ),
                  const SizedBox(height: 14),

                  // صور السيارة
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'صور السيارة *',
                      style: GoogleFonts.cairo(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: _buildCarPhotoSlot(
                          title: 'صورة أمامية *',
                          imageUrl: 'https://images.unsplash.com/photo-1590362891991-f776e747a588?w=300&auto=format&fit=crop&q=80',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildCarPhotoSlot(
                          title: 'صورة جانبية *',
                          imageUrl: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=300&auto=format&fit=crop&q=80',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildCarPhotoSlot(
                          title: 'صورة داخلية *',
                          imageUrl: 'https://images.unsplash.com/photo-1563720223185-11003d516935?w=300&auto=format&fit=crop&q=80',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'يجب ان تكون الصور واضحة ذات إضاءة جيدة',
                    style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF9CA3AF)),
                  ),
                  const SizedBox(height: 12),

                  // ملاحظات اختياري
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'ملاحظات (اختياري)',
                      style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: TextField(
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(fontSize: 11.5),
                      decoration: InputDecoration(
                        hintText: 'اكتب اي ملاحظات عن سيارتك...',
                        hintStyle: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF9CA3AF)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // الإقرار
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _agreedToVehicleTerms,
                          activeColor: const Color(0xFF5E35B1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (v) => setState(() => _agreedToVehicleTerms = v ?? false),
                        ),
                        Expanded(
                          child: Text(
                            'أتعهد بأن جميع المعلومات والصور المدخلة صحيحة وتعبر عن سيارتي الفعلية',
                            style: GoogleFonts.cairo(fontSize: 9.5, color: const Color(0xFF4B5563)),
                          ),
                        ),
                        const Icon(Icons.verified_user_outlined, size: 16, color: Color(0xFF5E35B1)),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
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
                    MaterialPageRoute(builder: (context) => const GuideTourSelectionScreen()),
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

  Widget _buildSelectField({
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
          height: 46,
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
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF5E35B1), size: 18),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.cairo(fontSize: 11.5)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarPhotoSlot({required String title, required String imageUrl}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.cairo(fontSize: 9.5, fontWeight: FontWeight.bold, color: const Color(0xFF374151)),
          ),
          const SizedBox(height: 4),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  height: 60,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 60,
                    color: const Color(0xFFEDE7F6),
                    child: const Icon(Icons.directions_car_rounded, color: Color(0xFF5E35B1)),
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Color(0xFF5E35B1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt_rounded, size: 10, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
