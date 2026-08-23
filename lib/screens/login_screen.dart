import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();

  static const _logoUrl =
      'https://www.figma.com/api/mcp/asset/8586cb71-6e0c-46ec-b556-0eb17a149d9a.png';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF5E35B1), size: 20),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Image.network(
                    _logoUrl,
                    width: 140,
                    height: 140,
                    errorBuilder: (_, __, ___) => Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE7F6),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: Icon(Icons.terrain_rounded, size: 50, color: Color(0xFF5E35B1)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'مرحباً بك في أثر',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                ),
                const SizedBox(height: 6),
                Text(
                  'سجل برقم جوالك للمتابعة',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(fontSize: 13.5, color: const Color(0xFF6B7280)),
                ),
                const SizedBox(height: 28),

                // حقل رقم الجوال مع بادئة السعودية +966
                Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Text('🇸🇦', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 6),
                      Text('+966', style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                      const Icon(Icons.arrow_drop_down, size: 18, color: Color(0xFF6B7280)),
                      Container(margin: const EdgeInsets.symmetric(horizontal: 8), width: 1, height: 24, color: const Color(0xFFE5E7EB)),
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            hintText: '5X XXX XXXX',
                            hintStyle: GoogleFonts.cairo(color: const Color(0xFF9CA3AF), fontSize: 13.5),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // زر إرسال رمز التحقق
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5E35B1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                    ),
                    onPressed: () {
                      final phone = _phoneController.text.trim().isEmpty ? '0590708382' : _phoneController.text.trim();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber: phone)),
                      );
                    },
                    child: Text(
                      'إرسال رمز التحقق',
                      style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Row(
                  children: [
                    const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('أو المتابعة بواسطة', style: GoogleFonts.cairo(fontSize: 12, color: const Color(0xFF9CA3AF))),
                    ),
                    const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                  ],
                ),

                const SizedBox(height: 20),

                _buildSocialButton(
                  label: 'المتابعة باستخدام Google',
                  icon: Icons.g_mobiledata_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OtpScreen(phoneNumber: '0590708382')),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _buildSocialButton(
                  label: 'المتابعة باستخدام Apple',
                  icon: Icons.apple_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OtpScreen(phoneNumber: '0590708382')),
                    );
                  },
                ),

                const SizedBox(height: 24),

                Text(
                  'بالمتابعة فإنك توافق على سياسة الخصوصية وشروط الاستخدام',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(fontSize: 11, color: const Color(0xFF6B7280)),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String label, required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: const Color(0xFF1F2937)),
            const SizedBox(width: 8),
            Text(label, style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF374151))),
          ],
        ),
      ),
    );
  }
}
