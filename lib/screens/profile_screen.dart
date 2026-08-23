import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'تسجيل الخروج',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Text(
          'هل أنت متأكد من رغبتك في تسجيل الخروج من حسابك؟',
          style: GoogleFonts.cairo(fontSize: 14, color: const Color(0xFF4B5563)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold, color: const Color(0xFF6B7280)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('تم تسجيل الخروج بنجاح', style: GoogleFonts.cairo()),
                ),
              );
            },
            child: Text(
              'تسجيل الخروج',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text(
            'حسابي والإعدادات',
            style: GoogleFonts.cairo(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF1F2937)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        child: Column(
          children: [
            // بطاقة المستخدم الرئيسية
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // الصورة الشخصية
                      Stack(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF5E35B1), Color(0xFF7E57C2)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF5E35B1).withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'خ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF6F00),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, color: Colors.white, size: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),

                      // بيانات المستخدم
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'خالد بن عبدالله',
                                  style: GoogleFonts.cairo(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1F2937),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCFCE7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.verified, size: 12, color: Color(0xFF16A34A)),
                                      const SizedBox(width: 3),
                                      Text(
                                        'موثق',
                                        style: GoogleFonts.cairo(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF16A34A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '+966 50 123 4567',
                              style: GoogleFonts.cairo(fontSize: 12.5, color: const Color(0xFF6B7280)),
                            ),
                            Text(
                              'khalid@athar.sa',
                              style: GoogleFonts.cairo(fontSize: 12, color: const Color(0xFF9CA3AF)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  const SizedBox(height: 14),

                  // إحصائيات النشاط
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('4', 'جولات مكتملة', const Color(0xFF5E35B1)),
                      Container(height: 30, width: 1, color: const Color(0xFFE5E7EB)),
                      _buildStatColumn('2', 'تذاكر نشطة', const Color(0xFFFF6F00)),
                      Container(height: 30, width: 1, color: const Color(0xFFE5E7EB)),
                      _buildStatColumn('5', 'في المفضلة', const Color(0xFF059669)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // قائمة الخيارات - الحساب والمدفوعات
            _buildSectionHeader('الحساب والمدفوعات'),
            _buildSettingsContainer([
              _buildSettingsTile(
                icon: Icons.account_balance_wallet_outlined,
                iconColor: const Color(0xFF5E35B1),
                title: 'طرق الدفع والمحفظة',
                subtitle: 'مدى، Apple Pay، والبطاقات الائتمانية',
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.receipt_long_outlined,
                iconColor: const Color(0xFFFF6F00),
                title: 'سجل العمليات والفواتير',
                subtitle: 'استعراض الفواتير الضريبية السابقة',
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.person_outline_rounded,
                iconColor: const Color(0xFF0288D1),
                title: 'تعديل البيانات الشخصية',
                subtitle: 'الاسم، رقم الجوال، والبريد الإلكتروني',
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 18),

            // قائمة الخيارات - التفضيلات
            _buildSectionHeader('تفضيلات التطبيق'),
            _buildSettingsContainer([
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE7F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.notifications_outlined, color: Color(0xFF5E35B1), size: 22),
                ),
                title: Text(
                  'إشعارات الجولات والتذكير',
                  style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'تنبيهك قبل موعد الجولة بـ 24 ساعة',
                  style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
                ),
                trailing: Switch.adaptive(
                  value: _notificationsEnabled,
                  activeColor: const Color(0xFF5E35B1),
                  onChanged: (val) => setState(() => _notificationsEnabled = val),
                ),
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.language_rounded,
                iconColor: const Color(0xFF059669),
                title: 'لغة التطبيق',
                subtitle: 'العربية (السعودية)',
                trailingText: 'تغيير',
                onTap: () {},
              ),
              _buildDivider(),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.dark_mode_outlined, color: Color(0xFF4B5563), size: 22),
                ),
                title: Text(
                  'الوضع الليلي (Dark Mode)',
                  style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'تفعيل المظهر الداكن المريح للعين',
                  style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
                ),
                trailing: Switch.adaptive(
                  value: _darkModeEnabled,
                  activeColor: const Color(0xFF5E35B1),
                  onChanged: (val) => setState(() => _darkModeEnabled = val),
                ),
              ),
            ]),

            const SizedBox(height: 18),

            // الدعم والمعلومات
            _buildSectionHeader('المساعدة والمعلومات'),
            _buildSettingsContainer([
              _buildSettingsTile(
                icon: Icons.headset_mic_outlined,
                iconColor: const Color(0xFF5E35B1),
                title: 'تواصل مع الدعم الفني',
                subtitle: 'خدمة العملاء عبر واتساب 24/7',
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.help_outline_rounded,
                iconColor: const Color(0xFF6B7280),
                title: 'الأسئلة الشائعة ومركز المساعدة',
                subtitle: 'إجابات حول سياسة الحجز والإلغاء',
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFF6B7280),
                title: 'الشروط والأحكام وسياسة الخصوصية',
                subtitle: 'ترخيص وزارة السياحة والهيئة العامة للسياحة',
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 24),

            // زر تسجيل الخروج
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFCA5A5), width: 1.2),
                  backgroundColor: const Color(0xFFFEF2F2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _showLogoutDialog,
                icon: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626), size: 20),
                label: Text(
                  'تسجيل الخروج',
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFDC2626),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Text(
              'تطبيق أثر السياحي - الإصدار 1.0.0 (المدينة المنورة)',
              style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String number, String label, Color color) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 6, bottom: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF374151),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF6B7280)),
      ),
      trailing: trailingText != null
          ? Text(
              trailingText,
              style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
            )
          : const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF9CA3AF)),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, indent: 60, color: Color(0xFFF3F4F6));
  }
}
