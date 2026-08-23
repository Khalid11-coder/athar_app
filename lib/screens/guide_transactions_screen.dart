import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/guide_models.dart';

class GuideTransactionsScreen extends StatefulWidget {
  const GuideTransactionsScreen({super.key});

  @override
  State<GuideTransactionsScreen> createState() => _GuideTransactionsScreenState();
}

class _GuideTransactionsScreenState extends State<GuideTransactionsScreen> {
  int _selectedTab = 0; // 0: الكل, 1: هذا الأسبوع, 2: هذا الشهر
  final List<GuideTransactionItem> _transactions = GuideTransactionItem.getSampleTransactions();
  final TextEditingController _searchController = TextEditingController();

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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: const Icon(Icons.tune_rounded, color: Color(0xFF5E35B1), size: 18),
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          'سجل العمليات',
          style: GoogleFonts.cairo(fontSize: 17, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
        ),
      ),
      body: Column(
        children: [
          // 1. شريط البحث
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.search_rounded, color: Color(0xFF9CA3AF), size: 18),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(fontSize: 11.5),
                      decoration: InputDecoration(
                        hintText: 'ابحث عن عملية أو سائح...',
                        hintStyle: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF9CA3AF)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. التبويبات
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  _buildTab(0, 'الكل'),
                  _buildTab(1, 'هذا الأسبوع'),
                  _buildTab(2, 'هذا الشهر'),
                ],
              ),
            ),
          ),

          // 3. قائمة العمليات
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final tx = _transactions[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      // السعر والشارة
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${tx.amount.toInt()} ر.س',
                            style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF16A34A)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'مكتملة',
                              style: GoogleFonts.cairo(fontSize: 9.5, fontWeight: FontWeight.bold, color: const Color(0xFF16A34A)),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // تفاصيل السائح
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tx.tourTitle,
                            style: GoogleFonts.cairo(fontSize: 13.5, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1)),
                          ),
                          Row(
                            children: [
                              Text(tx.touristName, style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF4B5563))),
                              const SizedBox(width: 4),
                              const Icon(Icons.person_outline_rounded, size: 12, color: Color(0xFF5E35B1)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${tx.personsCount} أشخاص', style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF6B7280))),
                              const SizedBox(width: 4),
                              const Icon(Icons.group_outlined, size: 12, color: Color(0xFF6B7280)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${tx.date} - ${tx.time}', style: GoogleFonts.cairo(fontSize: 9.5, color: const Color(0xFF9CA3AF))),
                              const SizedBox(width: 4),
                              const Icon(Icons.calendar_today_outlined, size: 11, color: Color(0xFF9CA3AF)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),

                      // صورة الجولة
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(tx.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 4. ملخص إجمالي في الأسفل
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: const Color(0xFFEDE7F6), borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.trending_up_rounded, color: Color(0xFF5E35B1), size: 18),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('إجمالي هذا الشهر', style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF6B7280))),
                          Text('7,890 ر.س', style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF5E35B1))),
                        ],
                      ),
                    ],
                  ),
                  Container(height: 30, width: 1, color: const Color(0xFFE5E7EB)),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: const Color(0xFFEDE7F6), borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.receipt_long_rounded, color: Color(0xFF5E35B1), size: 18),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('عدد العمليات', style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF6B7280))),
                          Text('42 عملية', style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String title) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF5E35B1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF4B5563),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
