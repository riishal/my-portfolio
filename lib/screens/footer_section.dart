import 'package:flutter/material.dart';
import 'package:rishal/utils/app_colors.dart';

class ModernFooterSection extends StatefulWidget {
  @override
  _ModernFooterSectionState createState() => _ModernFooterSectionState();
}

class _ModernFooterSectionState extends State<ModernFooterSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _floatingController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _floatingAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  Widget _buildSocialLink({
    required IconData icon,
    required String tooltip,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    bool _isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Tooltip(
            message: tooltip,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: _isHovered
                    ? LinearGradient(colors: gradientColors)
                    : LinearGradient(
                        colors: [
                          AppColors.cardBackground.withOpacity(0.8),
                          AppColors.cardBackground.withOpacity(0.6),
                        ],
                      ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isHovered
                      ? gradientColors[0].withOpacity(0.8)
                      : AppColors.accent.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: gradientColors[0].withOpacity(0.4),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: AppColors.shadow.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
              ),
              transform: Matrix4.identity()
                ..scale(_isHovered ? 1.1 : 1.0)
                ..rotateZ(_isHovered ? 0.1 : 0.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(25),
                  child: Icon(
                    icon,
                    color: _isHovered ? Colors.white : AppColors.accent,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickLink(String title, VoidCallback onTap) {
    bool _isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: _isHovered ? 6 : 0,
                    height: 2,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  if (_isHovered) SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: _isHovered
                          ? AppColors.accent
                          : AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: _isHovered
                          ? FontWeight.w500
                          : FontWeight.w400,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedBackground() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: MediaQuery.of(context).size.width < 768
              ? 600
              : 400, // Adjust based on content
          child: CustomPaint(
            painter: FooterBackgroundPainter(
              animation: _floatingAnimation,
              color: AppColors.accent.withOpacity(0.03),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      child: Stack(
        children: [
          _buildAnimatedBackground(),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.background,
                  AppColors.cardBackground.withOpacity(0.5),
                  AppColors.background.withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 80,
                      vertical: isMobile ? 50 : 80,
                    ),
                    child: isMobile
                        ? _buildMobileFooter()
                        : _buildDesktopFooter(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 80,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColors.accent.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: isMobile
                        ? Column(
                            children: [
                              Text(
                                '© 2024 Rishal. All rights reserved.',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Made with ❤️ in Flutter',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '© 2024 Rishal. All rights reserved.',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Made with',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  AnimatedBuilder(
                                    animation: _floatingAnimation,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                          0,
                                          _floatingAnimation.value * 0.3,
                                        ),
                                        child: Text(
                                          '❤️',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'in Flutter',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      children: [
        Column(
          children: [
            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatingAnimation.value),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accent,
                          AppColors.accent.withOpacity(0.7),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Colors.white, Colors.white.withOpacity(0.8)],
                        ).createShader(bounds),
                        child: Text(
                          'R',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [AppColors.accent, AppColors.accent.withOpacity(0.7)],
              ).createShader(bounds),
              child: Text(
                '<Rishal/>',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: Text(
                'Flutter Developer passionate about creating beautiful, high-performance mobile applications that users love.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.6,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        Container(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildSocialLink(
                icon: Icons.code,
                tooltip: 'GitHub',
                gradientColors: [Colors.grey.shade800, Colors.grey.shade600],
                onTap: () {},
              ),
              _buildSocialLink(
                icon: Icons.work,
                tooltip: 'LinkedIn',
                gradientColors: [Colors.blue.shade700, Colors.blue.shade500],
                onTap: () {},
              ),
              _buildSocialLink(
                icon: Icons.email,
                tooltip: 'Email',
                gradientColors: [Colors.red.shade600, Colors.red.shade400],
                onTap: () {},
              ),
              _buildSocialLink(
                icon: Icons.phone,
                tooltip: 'WhatsApp',
                gradientColors: [Colors.green.shade600, Colors.green.shade400],
                onTap: () {},
              ),
              _buildSocialLink(
                icon: Icons.flutter_dash,
                tooltip: 'Flutter',
                gradientColors: [Colors.blue.shade400, Colors.cyan.shade300],
                onTap: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        Column(
          children: [
            Text(
              'Quick Links',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 24,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildQuickLink('Home', () {}),
                _buildQuickLink('About', () {}),
                _buildQuickLink('Services', () {}),
                _buildQuickLink('Projects', () {}),
                _buildQuickLink('Contact', () {}),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBuilder(
                animation: _floatingAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _floatingAnimation.value),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.accent,
                                AppColors.accent.withOpacity(0.7),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accent.withOpacity(0.3),
                                blurRadius: 15,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'R',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              AppColors.accent,
                              AppColors.accent.withOpacity(0.7),
                            ],
                          ).createShader(bounds),
                          child: Text(
                            '<Rishal/>',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Container(
                constraints: BoxConstraints(maxWidth: 300),
                child: Text(
                  'Flutter Developer passionate about creating beautiful, high-performance mobile applications that deliver exceptional user experiences.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.6,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  _buildSocialLink(
                    icon: Icons.code,
                    tooltip: 'GitHub',
                    gradientColors: [
                      Colors.grey.shade800,
                      Colors.grey.shade600,
                    ],
                    onTap: () {},
                  ),
                  SizedBox(width: 12),
                  _buildSocialLink(
                    icon: Icons.work,
                    tooltip: 'LinkedIn',
                    gradientColors: [
                      Colors.blue.shade700,
                      Colors.blue.shade500,
                    ],
                    onTap: () {},
                  ),
                  SizedBox(width: 12),
                  _buildSocialLink(
                    icon: Icons.email,
                    tooltip: 'Email',
                    gradientColors: [Colors.red.shade600, Colors.red.shade400],
                    onTap: () {},
                  ),
                  SizedBox(width: 12),
                  _buildSocialLink(
                    icon: Icons.phone,
                    tooltip: 'WhatsApp',
                    gradientColors: [
                      Colors.green.shade600,
                      Colors.green.shade400,
                    ],
                    onTap: () {},
                  ),
                  SizedBox(width: 12),
                  _buildSocialLink(
                    icon: Icons.flutter_dash,
                    tooltip: 'Flutter',
                    gradientColors: [
                      Colors.blue.shade400,
                      Colors.cyan.shade300,
                    ],
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 80),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Links',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuickLink('Home', () {}),
                  _buildQuickLink('About Me', () {}),
                  _buildQuickLink('Services', () {}),
                  _buildQuickLink('Projects', () {}),
                  _buildQuickLink('Contact', () {}),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 40),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Services',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuickLink('Mobile Development', () {}),
                  _buildQuickLink('UI/UX Design', () {}),
                  _buildQuickLink('API Integration', () {}),
                  _buildQuickLink('Performance Optimization', () {}),
                  _buildQuickLink('Consulting', () {}),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FooterBackgroundPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  FooterBackgroundPainter({required this.animation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 12; i++) {
      final offset = Offset(
        size.width * (0.05 + (i * 0.08) % 0.9),
        size.height * (0.1 + (i * 0.15) % 0.8) +
            animation.value * (i % 3 == 0 ? 1 : -1),
      );

      final radius = 15 + (i * 3);

      if (i % 4 == 0) {
        canvas.drawCircle(offset, radius.toDouble(), paint);
      } else if (i % 4 == 1) {
        final rect = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: offset,
            width: radius * 1.5,
            height: radius * 1.5,
          ),
          Radius.circular(6),
        );
        canvas.drawRRect(rect, paint);
      } else {
        final path = Path();
        path.moveTo(offset.dx, offset.dy - radius);
        path.lineTo(offset.dx - radius * 0.866, offset.dy + radius * 0.5);
        path.lineTo(offset.dx + radius * 0.866, offset.dy + radius * 0.5);
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(FooterBackgroundPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
