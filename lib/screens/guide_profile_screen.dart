import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'guide_edit_profile_screen.dart';

class GuideProfileScreen extends StatelessWidget {
  const GuideProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            children: [
              // 1. الشريط العلوي
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: const Icon(Icons.settings_outlined, color: Color(0xFF5E35B1), size: 20),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: const Icon(Icons.notifications_none_rounded, color: Color(0xFF1F2937), size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 2. بطاقة الملف الشخصي العلوية
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'عبد المحسن البرقاوي',
                            style: GoogleFonts.cairo(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF5E35B1),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDE7F6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('مرشد سياحي معتمد', style: GoogleFonts.cairo(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified_rounded, size: 14, color: Color(0xFF5E35B1)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('المدينة المنورة', style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280))),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('4.9 (150 تقييم)', style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                              const SizedBox(width: 4),
                              const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFB300)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    // صورة المرشد
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE7F6),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF5E35B1), width: 1.5),
                      ),
                      child: const Center(
                        child: Icon(Icons.person_rounded, size: 44, color: Color(0xFF5E35B1)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // 3. الإحصائيات الأربعة
              Row(
                children: [
                  Expanded(
                    child: _buildProfileStat('جولة مكتملة', '128', Icons.flag_outlined, const Color(0xFF8B5CF6)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildProfileStat('إجمالي الأرباح', '7,800 ر.س', Icons.account_balance_wallet_outlined, const Color(0xFF7E22CE)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildProfileStat('نسبة قبول الطلبات', '92%', Icons.trending_up_rounded, const Color(0xFF10B981)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildProfileStat('سائح خدمته', '386', Icons.groups_outlined, const Color(0xFF0288D1)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 3.5 بطاقة التبديل إلى وضع السائح
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6F00), Color(0xFFFFA000)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6F00).withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFFF6F00),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const AccountTypeScreen()),
                        );
                      },
                      child: Text('تبديل', style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'تصفح التطبيق كـ سائح / زائر',
                          style: GoogleFonts.cairo(fontSize: 13.5, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          'استكشاف الجولات، التذاكر، والخريطة',
                          style: GoogleFonts.cairo(fontSize: 10.5, color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.explore_rounded, color: Colors.white, size: 22),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // 4. قائمة الخيارات والإعدادات
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      context,
                      title: 'تعديل الملف الشخصي',
                      icon: Icons.person_outline_rounded,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GuideEditProfileScreen()),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildMenuItem(context, title: 'بيانات السيارة', icon: Icons.directions_car_filled_outlined),
                    _buildDivider(),
                    _buildMenuItem(context, title: 'الرخصة السياحية', icon: Icons.badge_outlined),
                    _buildDivider(),
                    _buildMenuItem(context, title: 'اللغات', icon: Icons.language_rounded),
                    _buildDivider(),
                    _buildMenuItem(context, title: 'التقييمات', icon: Icons.star_outline_rounded),
                    _buildDivider(),
                    _buildMenuItem(context, title: 'الحساب البنكي (Iban)', icon: Icons.account_balance_outlined),
                    _buildDivider(),
                    _buildMenuItem(context, title: 'الإشعارات', icon: Icons.notifications_none_rounded),
                    _buildDivider(),
                    _buildMenuItem(context, title: 'الإعدادات', icon: Icons.settings_outlined),
                    _buildDivider(),
                    _buildMenuItem(context, title: 'تواصل معنا', icon: Icons.headset_mic_outlined),
                    _buildDivider(),
                    _buildMenuItem(context, title: 'مركز المساعدة', icon: Icons.help_outline_rounded, isLast: true),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // 5. زر تسجيل الخروج
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFEF4444),
                    side: const BorderSide(color: Color(0xFFFCA5A5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout_rounded, size: 18, color: Color(0xFFEF4444)),
                      const SizedBox(width: 8),
                      Text(
                        'تسجيل الخروج',
                        style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFEF4444)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
          Text(label, style: GoogleFonts.cairo(fontSize: 8, color: const Color(0xFF6B7280)), maxLines: 1),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(isLast ? 22 : 0),
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Color(0xFF9CA3AF)),
            const Spacer(),
            Text(title, style: GoogleFonts.cairo(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF374151))),
            const SizedBox(width: 10),
            Icon(icon, size: 18, color: const Color(0xFF5E35B1)),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF3F4F6));
}
