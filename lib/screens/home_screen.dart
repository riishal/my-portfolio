import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishal/widget/about_section.dart';
import 'package:rishal/widget/blog_section.dart';
import 'package:rishal/widget/contact_section.dart';
import 'package:rishal/widget/mobile_profile.dart';
import 'package:rishal/widget/navbar.dart';
import 'package:rishal/widget/portfolio_section.dart';
import 'package:rishal/widget/resume_section.dart';
import 'package:rishal/widget/side_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Widget> _sections = [
    const AboutSection(),
    const ResumeSection(),
    const PortfolioSection(),
    const BlogSection(),
    const ContactSection(),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: Stack(
        children: [
          // Animated Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topRight,
                  radius: 1.5,
                  colors: [Color(0xFF121212), Color(0xFF070707)],
                  stops: [0.1, 1.0],
                ),
              ),
              child: CustomPaint(painter: _DotsPainter()),
            ),
          ),

          // Content
          Column(
            children: [
              // Mobile Profile Header - Only visible on mobile
              // if (isMobile) const MobileProfileHeader(),
              Expanded(
                child: Row(
                  children: [
                    // Sidebar - Only visible on larger screens
                    if (!isMobile)
                      FadeInLeft(
                        duration: const Duration(milliseconds: 800),
                        child: const Sidebar(),
                      ),

                    // Main content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ElasticIn(
                            duration: const Duration(milliseconds: 1200),
                            child: _sections[_currentIndex],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      // Bottom navbar
      bottomNavigationBar: FadeInUp(
        duration: const Duration(milliseconds: 1000),
        child: NavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class _DotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x15FFFFFF)
      ..style = PaintingStyle.fill;

    const double spacing = 30;
    final double rows = size.height / spacing;
    final double cols = size.width / spacing;

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        final dx = i * spacing;
        final dy = j * spacing;
        canvas.drawCircle(Offset(dx, dy), 0.8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Mobile Profile Header Widget

// Other sections (ResumeSection, PortfolioSection, etc.) remain unchanged
