import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:ui';

// ── BRAND CONSTANTS ──
class TahsiliColors {
  static const Color g = Color(0xFF00C896);
  static const Color gDark = Color(0xFF009E77);
  static const Color gLight = Color(0xFFE6FAF5);
  static const Color gMid = Color(0xFFB3F0E0);
  static const Color white = Color(0xFFFFFFFF);
  static const Color bg = Color(0xFFF7FAF9);
  static const Color ink = Color(0xFF0D1F1A);
  static const Color inkMid = Color(0xFF3D5A52);
  static const Color inkLt = Color(0xFF8FA89F);
  static const Color red = Color(0xFFFF3B30);
  static const Color redLt = Color(0xFFFFF0EF);
  static const Color border = Color(0xFFE2EBE7);
}

void main() {
  runApp(const TahsiliApp());
}

class TahsiliApp extends StatelessWidget {
  const TahsiliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تحصيلي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: TahsiliColors.g,
        scaffoldBackgroundColor: TahsiliColors.bg,
        textTheme: GoogleFonts.cairoTextTheme().copyWith(
          displayLarge: GoogleFonts.cairo(fontWeight: FontWeight.w900, color: TahsiliColors.ink),
          headlineMedium: GoogleFonts.cairo(fontWeight: FontWeight.w800, color: TahsiliColors.ink),
          bodyLarge: GoogleFonts.cairo(fontWeight: FontWeight.w500, color: TahsiliColors.inkMid),
          bodySmall: GoogleFonts.cairo(fontWeight: FontWeight.w400, color: TahsiliColors.inkLt),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ── SPLASH SCREEN (HERO) ──
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    
    _controller.forward();
    Timer(const Duration(seconds: 3), () {
      if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TahsiliColors.ink,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 700, height: 700,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [TahsiliColors.g.withOpacity(0.15), Colors.transparent],
                  stops: const [0.0, 0.65],
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 0.08,
            child: CustomPaint(painter: DotsPainter(), child: Container()),
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 110, height: 110,
                      decoration: BoxDecoration(
                        color: TahsiliColors.g,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(color: TahsiliColors.g.withOpacity(0.3), blurRadius: 60),
                          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 60, offset: const Offset(0, 20)),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text('ت', style: TextStyle(color: Colors.white, fontSize: 51, fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(height: 36),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.cairo(fontSize: 72, fontWeight: FontWeight.w900, color: Colors.white, height: 1),
                        children: const [
                          TextSpan(text: 'تح'),
                          TextSpan(text: 'صي', style: TextStyle(color: TahsiliColors.g)),
                          TextSpan(text: 'لي'),
                        ],
                      ),
                    ),
                    Text(
                      'T A H S I L I',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, letterSpacing: 8, color: Colors.white.withOpacity(0.3), fontWeight: FontWeight.w600,
                      ),
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
}

class DotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = TahsiliColors.g;
    for (double i = 0; i < size.width; i += 32) {
      for (double j = 0; j < size.height; j += 32) {
        canvas.drawCircle(Offset(i, j), 1.0, paint);
      }
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ── LOGIN PAGE ──
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(32, 100, 32, 60),
              decoration: const BoxDecoration(color: TahsiliColors.ink),
              child: Column(
                children: [
                  Container(
                    width: 70, height: 70,
                    decoration: BoxDecoration(color: TahsiliColors.g, borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    child: const Text('ت', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                  ),
                  const SizedBox(height: 24),
                  const Text('أهلاً بك 👋', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Text('سجّل دخولك وابدأ استعدادك', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildLabel('البريد الإلكتروني'),
                  _buildInput('example@gmail.com', false),
                  const SizedBox(height: 24),
                  _buildLabel('كلمة المرور'),
                  _buildInput('••••••••', true),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TahsiliColors.g,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 8, shadowColor: TahsiliColors.g.withOpacity(0.3),
                    ),
                    child: const Text('تسجيل الدخول', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('ما عندك حساب؟ ', style: TextStyle(color: TahsiliColors.inkLt)),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OnboardingPage())),
                        child: const Text('سجّل الحين', style: TextStyle(color: TahsiliColors.g, fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: TahsiliColors.ink)),
  );

  Widget _buildInput(String hint, bool pass) => TextField(
    obscureText: pass,
    textAlign: TextAlign.right,
    decoration: InputDecoration(
      hintText: hint,
      filled: true, fillColor: TahsiliColors.bg,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),
  );
}

// ── ONBOARDING PAGE ──
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _step = 1;
  String _specialization = 'علمي';
  String _grade = 'الصف الثالث الثانوي';
  double _questionCount = 20;
  String _reminderTime = '٨:٠٠ مساءً';
  DateTime _examDate = DateTime.now().add(const Duration(days: 45));

  int _calculateRemainingDays() {
    return _examDate.difference(DateTime.now()).inDays;
  }

  String _toArabicNum(int n) {
    const Map<String, String> digits = {
      '0': '٠', '1': '١', '2': '٢', '3': '٣', '4': '٤',
      '5': '٥', '6': '٦', '7': '٧', '8': '٨', '9': '٩'
    };
    return n.toString().split('').map((e) => digits[e] ?? e).join('');
  }

  String _formatDate(DateTime d) {
    return '${_toArabicNum(d.day)} / ${_toArabicNum(d.month)} / ${_toArabicNum(d.year)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: List.generate(5, (i) => Expanded(
                  child: Container(
                    height: 4, margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(color: (i + 1 <= _step) ? TahsiliColors.g : TahsiliColors.border, borderRadius: BorderRadius.circular(2)),
                  ),
                )),
              ),
              const SizedBox(height: 32),
              Text('الخطوة $_step من ٥', style: GoogleFonts.plusJakartaSans(color: TahsiliColors.g, fontWeight: FontWeight.w800, letterSpacing: 2, fontSize: 11)),
              const SizedBox(height: 12),
              Text(_getTitle(), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: TahsiliColors.ink, height: 1.1)),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildStepContent(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  if (_step > 1)
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () => setState(() => _step--),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          side: const BorderSide(color: TahsiliColors.border, width: 2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('رجوع ←', style: TextStyle(color: TahsiliColors.inkMid, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  if (_step > 1) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_step < 5) setState(() => _step++);
                        else Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PaywallPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TahsiliColors.g,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4, shadowColor: TahsiliColors.g.withOpacity(0.3),
                      ),
                      child: const Text('التالي ←', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (_step) {
      case 1: return 'أنشئ حسابك ✨';
      case 2: return 'ما تخصصك الدراسي؟';
      case 3: return 'أنت في أي صف؟';
      case 4: return 'متى اختبارك؟';
      case 5: return 'كم سؤال يومياً؟';
      default: return '';
    }
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 1:
        return Column(
          children: [
            _buildStepLabel('الاسم الكامل'),
            _buildStepInput('مثال: أحمد الغامدي', false),
            const SizedBox(height: 24),
            _buildStepLabel('البريد الإلكتروني'),
            _buildStepInput('example@gmail.com', false),
            const SizedBox(height: 24),
            _buildStepLabel('كلمة المرور'),
            _buildStepInput('••••••••', true),
            const SizedBox(height: 24),
            _buildStepLabel('تأكيد كلمة المرور'),
            _buildStepInput('••••••••', true),
          ],
        );
      case 2:
        return Column(
          children: [
            _buildOptionCard('علمي', 'رياضيات · فيزياء · كيمياء · أحياء', '🔬', _specialization == 'علمي', (v) => setState(() => _specialization = v)),
            _buildOptionCard('أدبي', 'عربي · تاريخ · جغرافيا · اجتماعيات', '📚', _specialization == 'أدبي', (v) => setState(() => _specialization = v), disabled: true),
          ],
        );
      case 3:
        return Column(
          children: [
            _buildOptionCard('الصف الثاني الثانوي', 'تحضير مبكر — ممتاز!', '📖', _grade == 'الصف الثاني الثانوي', (v) => setState(() => _grade = v)),
            _buildOptionCard('الصف الثالث الثانوي', 'السنة الحاسمة', '🎯', _grade == 'الصف الثالث الثانوي', (v) => setState(() => _grade = v)),
          ],
        );
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _examDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 730)),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(primary: TahsiliColors.g, onPrimary: Colors.white, onSurface: TahsiliColors.ink),
                        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: TahsiliColors.g)),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) setState(() => _examDate = picked);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: TahsiliColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: TahsiliColors.border, width: 1.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDate(_examDate), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: TahsiliColors.ink)),
                    const Icon(Icons.calendar_month_outlined, color: TahsiliColors.inkLt),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: TahsiliColors.gLight, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  const Icon(Icons.calendar_view_month, color: Color(0xFF4A90E2), size: 32),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_toArabicNum(_calculateRemainingDays())} يوم متبقية', style: const TextStyle(color: TahsiliColors.gDark, fontWeight: FontWeight.w900, fontSize: 16)),
                      const Text('خطة دراسية منظمة بانتظارك', style: TextStyle(color: TahsiliColors.inkLt, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      case 5:
        return Column(
          children: [
            Text(_questionCount.toInt().toString(), style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w900, color: TahsiliColors.g, height: 1)),
            const Text('سؤال يومياً', style: TextStyle(color: TahsiliColors.inkLt, fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 32),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: TahsiliColors.g,
                inactiveTrackColor: TahsiliColors.border,
                thumbColor: TahsiliColors.g,
                overlayColor: TahsiliColors.g.withOpacity(0.2),
                trackHeight: 6,
              ),
              child: Slider(
                value: _questionCount,
                min: 5, max: 50,
                onChanged: (v) => setState(() => _questionCount = v),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('٥ — مشغول', style: TextStyle(color: TahsiliColors.inkLt, fontSize: 11)),
                Text('٢٥ — متوسط', style: TextStyle(color: TahsiliColors.inkLt, fontSize: 11)),
                Text('٥٠ — جاد', style: TextStyle(color: TahsiliColors.inkLt, fontSize: 11)),
              ],
            ),
            const SizedBox(height: 40),
            _buildOptionCard('٨:٠٠ مساءً', 'تذكير يومي للدراسة', '🔔', _reminderTime == '٨:٠٠ مساءً', (v) => setState(() => _reminderTime = v)),
            _buildOptionCard('٧:٠٠ صباحاً', 'ابدأ يومك بالدراسة', '🌅', _reminderTime == '٧:٠٠ صباحاً', (v) => setState(() => _reminderTime = v)),
          ],
        );
      default: return Container();
    }
  }

  Widget _buildOptionCard(String title, String sub, String icon, bool sel, Function(String)? onSel, {bool disabled = false}) {
    return GestureDetector(
      onTap: disabled ? null : () => onSel!(title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: disabled ? const Color(0xFFF5F5F5) : (sel ? TahsiliColors.gLight : TahsiliColors.bg),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: sel ? TahsiliColors.g : Colors.transparent, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: disabled ? Colors.grey : (sel ? TahsiliColors.gDark : TahsiliColors.ink))),
                      if (disabled) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(6)),
                          child: const Text('قريباً', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ]
                    ],
                  ),
                  Text(sub, style: TextStyle(fontSize: 12, color: disabled ? Colors.grey[400] : (sel ? TahsiliColors.gDark.withOpacity(0.5) : TahsiliColors.inkLt))),
                ],
              ),
            ),
            if (sel)
              const Icon(Icons.check_circle, color: TahsiliColors.g, size: 24)
            else
              Icon(Icons.circle_outlined, color: disabled ? Colors.grey[300] : TahsiliColors.border, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStepLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: TahsiliColors.ink)),
  );

  Widget _buildStepInput(String hint, bool pass) => TextField(
    obscureText: pass,
    textAlign: TextAlign.right,
    decoration: InputDecoration(
      hintText: hint,
      filled: true, fillColor: TahsiliColors.bg,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),
  );
}

// ── PAYWALL PAGE ──
class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: -100, right: -100,
            child: Container(width: 300, height: 300, decoration: BoxDecoration(color: TahsiliColors.g.withOpacity(0.2), shape: BoxShape.circle), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80), child: Container())),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🚀', style: TextStyle(fontSize: 80)),
                const SizedBox(height: 24),
                const Text('استعد للقمة مع النسخة الكاملة', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, height: 1.1)),
                const SizedBox(height: 12),
                Text('افتح جميع المميزات والأسئلة وابدأ تدريبك بذكاء', textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16)),
                const SizedBox(height: 48),
                
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white.withOpacity(0.2))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: TahsiliColors.g, borderRadius: BorderRadius.circular(10)),
                        child: const Text('٧ أيام مجاناً', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('فترة تجريبية مجانية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                          Text('ابدأ الآن وادفع لاحقاً', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: const Color(0xFF111111), borderRadius: BorderRadius.circular(28), border: Border.all(color: TahsiliColors.g, width: 2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('الاشتراك الشهري', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('ريال / شهر', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14)),
                          const SizedBox(width: 8),
                          const Text('٢٠', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
                        ],
                      ),
                      const Text('تطبق بعد انتهاء الفترة التجريبية', style: TextStyle(color: TahsiliColors.g, fontSize: 12)),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
                
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TahsiliColors.g, minimumSize: const Size(double.infinity, 64),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('ابدأ تجربتك المجانية', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900)),
                ),
                
                TextButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage())),
                  child: Text('ربما لاحقاً', style: TextStyle(color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── HOME PAGE ──
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currIndex = 4; // Start at Home (Arabic RTL logic)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TahsiliColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(color: TahsiliColors.g, borderRadius: BorderRadius.circular(22), boxShadow: [BoxShadow(color: TahsiliColors.g.withOpacity(0.3), blurRadius: 15)]),
                    alignment: Alignment.center,
                    child: const Text('أح', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('صباح الخير 👋', style: TextStyle(color: TahsiliColors.inkLt, fontSize: 12, fontWeight: FontWeight.w600)),
                      Text('أحمد الغامدي', style: GoogleFonts.cairo(fontWeight: FontWeight.w900, fontSize: 20, color: TahsiliColors.ink, height: 1.2)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Premium Countdown Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: TahsiliColors.ink,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('اختبار التحصيلي', style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        const Text('١٥ مارس ٢٠٢٦', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('٤٥', style: TextStyle(color: TahsiliColors.g, fontSize: 48, fontWeight: FontWeight.w900, height: 1)),
                        const Text('يوم باقي على اختبارك', style: TextStyle(color: Colors.white30, fontSize: 10, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Streak Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('🔥', style: TextStyle(fontSize: 24)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('١٢', style: TextStyle(color: Color(0xFFF5A623), fontSize: 28, fontWeight: FontWeight.w900, height: 1)),
                            const Text('يوم', style: TextStyle(color: Color(0xFFF5A623), fontSize: 18, fontWeight: FontWeight.w900, height: 1)),
                            const Text('أيام متواصلة', style: TextStyle(color: TahsiliColors.inkLt, fontSize: 10, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['ح','س','ج','خ','ر','ث','ن'].map((d) => Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(
                          color: (d == 'ن' || d == 'ث' || d == 'ر' || d == 'خ' || d == 'ج') ? TahsiliColors.g : TahsiliColors.bg,
                          borderRadius: BorderRadius.circular(8),
                          border: d == 'ج' ? Border.all(color: TahsiliColors.g, width: 1) : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(d, style: TextStyle(color: (d == 'ن' || d == 'ث' || d == 'ر' || d == 'خ' || d == 'ج') ? Colors.white : TahsiliColors.inkLt, fontWeight: FontWeight.w900, fontSize: 12)),
                      )).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Missions Header
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('مهمة اليوم 📚', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: TahsiliColors.ink)),
                ],
              ),
              const SizedBox(height: 16),
              // Mission Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: TahsiliColors.redLt, borderRadius: BorderRadius.circular(10)),
                          child: const Text('⚠️ الأحياء ضعيفة', style: TextStyle(color: TahsiliColors.red, fontSize: 10, fontWeight: FontWeight.w900)),
                        ),
                        const Text('٢٠ سؤال اليوم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: TahsiliColors.ink)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildMissionItem('الرياضيات', '٨ أسئلة', Colors.blueAccent),
                    _buildMissionItem('الأحياء', '١٠ أسئلة', TahsiliColors.red),
                    _buildMissionItem('الكيمياء', '٢ أسئلة', TahsiliColors.g),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TahsiliColors.g, minimumSize: const Size(double.infinity, 58),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      ),
                      child: const Text('ابدأ جلسة اليوم ←', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Align(alignment: Alignment.centerRight, child: Text('إحصائياتك', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: TahsiliColors.ink))),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatCard('٤٥', 'يوم باقي'),
                  const SizedBox(width: 12),
                  _buildStatCard('٧٦٪', 'دقة عامة'),
                  const SizedBox(width: 12),
                  _buildStatCard('٦٣٠', 'سؤال محلول'),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 3) return; // Disable Competition
          if (index == 4) Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: TahsiliColors.g,
        unselectedItemColor: TahsiliColors.inkLt,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
          const BottomNavigationBarItem(icon: Icon(Icons.library_books_outlined), label: 'جلستي'),
          const BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'تقدمي'),
          BottomNavigationBarItem(
            icon: Opacity(
              opacity: 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.emoji_events_outlined, color: Colors.grey),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
                    child: const Text('قريباً', style: TextStyle(fontSize: 6, color: Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            label: 'منافسة',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'إعدادات'),
        ],
      ),
    );
  }

  Widget _buildMissionItem(String label, String count, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: Text(count, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: TahsiliColors.ink)),
          const SizedBox(width: 12),
          Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String val, String lbl) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: TahsiliColors.border.withOpacity(0.5))),
        child: Column(
          children: [
            Text(val, style: const TextStyle(color: TahsiliColors.g, fontSize: 24, fontWeight: FontWeight.w900)),
            Text(lbl, style: const TextStyle(color: TahsiliColors.inkLt, fontSize: 10, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

// ── SETTINGS PAGE ──
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TahsiliColors.bg,
      appBar: AppBar(
        title: const Text('الإعدادات ⚙️', style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Trial Card
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallPage())),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: TahsiliColors.ink,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white.withOpacity(0.2))),
                          child: const Text('٧ أيام تجريبية', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                        ),
                        const Text('الاشتراك المميّز', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('٢٠ ريال / شهر', style: TextStyle(color: TahsiliColors.g, fontSize: 24, fontWeight: FontWeight.w900)),
                    const Text('اضغط لاختيار الباقة المناسبة', style: TextStyle(color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildSettingSection('إعدادات الدراسة', [
              _buildSettingRow('تاريخ الاختبار', '١٥ مارس ٢٠٢٦', Icons.calendar_today_outlined),
              _buildSettingRow('هدف الأسئلة اليومي', '٢٠ سؤال', Icons.track_changes_outlined),
              _buildSettingRow('التخصص', 'علمي', Icons.science_outlined),
            ]),
            const SizedBox(height: 32),
            _buildSettingSection('الحساب', [
              _buildSettingRow('الملف الشخصي', 'أحمد الغامدي', Icons.person_outline),
              _buildSettingRow('تسجيل الخروج', '', Icons.logout, color: TahsiliColors.red),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: TahsiliColors.inkLt)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingRow(String title, String sub, IconData icon, {Color? color}) {
    return ListTile(
      leading: const Icon(Icons.chevron_left, color: TahsiliColors.border),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: color ?? TahsiliColors.ink)),
              if (sub.isNotEmpty) Text(sub, style: const TextStyle(color: TahsiliColors.inkLt, fontSize: 11)),
            ],
          ),
          const SizedBox(width: 12),
          Icon(icon, color: color ?? TahsiliColors.inkMid),
        ],
      ),
    );
  }
}
