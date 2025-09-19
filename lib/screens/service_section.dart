import 'package:flutter/material.dart';
import 'package:rishal/utils/app_colors.dart';
import 'dart:math' as math;

class ModernServicesSection extends StatefulWidget {
  final GlobalKey servicesKey;
  final bool isMobile;

  ModernServicesSection({required this.servicesKey, required this.isMobile});

  @override
  _ModernServicesSectionState createState() => _ModernServicesSectionState();
}

class _ModernServicesSectionState extends State<ModernServicesSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _floatingController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _floatingAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _floatingController.repeat(reverse: true);
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Widget _buildModernServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required List<Color> gradientColors,
    required int index,
  }) {
    bool _isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  _floatingAnimation.value * (index % 2 == 0 ? 1 : -1),
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(widget.isMobile ? 24 : 32),
                  transform: Matrix4.identity()
                    ..scale(_isHovered ? 1.05 : 1.0)
                    ..rotateZ(_isHovered ? 0.01 : 0.0),
                  decoration: BoxDecoration(
                    gradient: _isHovered
                        ? LinearGradient(
                            colors: [
                              gradientColors[0].withOpacity(0.15),
                              gradientColors[1].withOpacity(0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              AppColors.cardBackground.withOpacity(0.8),
                              AppColors.background.withOpacity(0.9),
                            ],
                          ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _isHovered
                          ? gradientColors[0].withOpacity(0.5)
                          : AppColors.accent.withOpacity(0.1),
                      width: _isHovered ? 2 : 1,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: gradientColors[0].withOpacity(0.3),
                              blurRadius: 30,
                              offset: Offset(0, 15),
                              spreadRadius: 2,
                            ),
                            BoxShadow(
                              color: gradientColors[1].withOpacity(0.1),
                              blurRadius: 50,
                              offset: Offset(0, 25),
                              spreadRadius: 5,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: AppColors.shadow.withOpacity(0.1),
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
                  ),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        width: widget.isMobile ? 70 : 80,
                        height: widget.isMobile ? 70 : 80,
                        decoration: BoxDecoration(
                          gradient: _isHovered
                              ? LinearGradient(
                                  colors: gradientColors,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : LinearGradient(
                                  colors: [
                                    AppColors.accent.withOpacity(0.8),
                                    AppColors.accent.withOpacity(0.6),
                                  ],
                                ),
                          shape: BoxShape.circle,
                          boxShadow: _isHovered
                              ? [
                                  BoxShadow(
                                    color: gradientColors[0].withOpacity(0.4),
                                    blurRadius: 20,
                                    offset: Offset(0, 8),
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: AppColors.accent.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                        ),
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _isHovered ? _pulseAnimation.value : 1.0,
                              child: Icon(
                                icon,
                                color: Colors.white,
                                size: widget.isMobile ? 32 : 36,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _isHovered
                              ? gradientColors[0]
                              : AppColors.textPrimary,
                          fontSize: widget.isMobile ? 18 : 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: widget.isMobile ? 14 : 15,
                          height: 1.6,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(height: 20),
                      if (_isHovered)
                        AnimatedOpacity(
                          opacity: _isHovered ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 300),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: gradientColors),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Learn More',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAnimatedBackground() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use a fixed height to avoid infinite constraints
        return SizedBox(
          width: constraints.maxWidth,
          height: widget.isMobile
              ? 800
              : 1200, // Adjust based on content height
          child: CustomPaint(
            painter: ServiceBackgroundPainter(
              animation: _floatingAnimation,
              color: AppColors.accent.withOpacity(0.05),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.servicesKey,
      child: Stack(
        children: [
          _buildAnimatedBackground(),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.background,
                  AppColors.cardBackground.withOpacity(0.3),
                  AppColors.background,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: widget.isMobile ? 60 : 120,
              horizontal: widget.isMobile ? 20 : 80,
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.accent.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            'SERVICES',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [AppColors.textPrimary, AppColors.accent],
                          ).createShader(bounds),
                          child: Text(
                            'What I can do?',
                            style: TextStyle(
                              fontSize: widget.isMobile ? 32 : 52,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          constraints: BoxConstraints(maxWidth: 600),
                          child: Text(
                            'I specialize in creating exceptional digital experiences through innovative mobile development and cutting-edge design solutions.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: widget.isMobile ? 16 : 18,
                              height: 1.6,
                              letterSpacing: 0.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: widget.isMobile ? 50 : 80),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount;
                        double childAspectRatio;

                        if (widget.isMobile) {
                          crossAxisCount = 1;
                          childAspectRatio = 1.2;
                        } else if (constraints.maxWidth < 1200) {
                          crossAxisCount = 2;
                          childAspectRatio = 1.0;
                        } else {
                          crossAxisCount = 3;
                          childAspectRatio = 0.9;
                        }

                        return GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                          childAspectRatio: childAspectRatio,
                          children: [
                            _buildModernServiceCard(
                              icon: Icons.phone_android,
                              title: 'Mobile Development',
                              description:
                                  'Cross-platform Flutter apps with native performance and beautiful UI designs.',
                              gradientColors: [Colors.blue, Colors.blueAccent],
                              index: 0,
                            ),
                            _buildModernServiceCard(
                              icon: Icons.design_services,
                              title: 'UI/UX Design',
                              description:
                                  'User-centered design solutions that create engaging and intuitive experiences.',
                              gradientColors: [
                                Colors.purple,
                                Colors.purpleAccent,
                              ],
                              index: 1,
                            ),
                            _buildModernServiceCard(
                              icon: Icons.speed,
                              title: 'Rapid Prototyping',
                              description:
                                  'Quick MVP development to validate ideas and bring concepts to life fast.',
                              gradientColors: [
                                Colors.orange,
                                Colors.orangeAccent,
                              ],
                              index: 2,
                            ),
                            _buildModernServiceCard(
                              icon: Icons.api,
                              title: 'API Integration',
                              description:
                                  'Seamless backend connectivity with REST APIs, GraphQL, and cloud services.',
                              gradientColors: [
                                Colors.green,
                                Colors.greenAccent,
                              ],
                              index: 3,
                            ),
                            _buildModernServiceCard(
                              icon: Icons.code,
                              title: 'Open Source',
                              description:
                                  'Contributing to the developer community with reusable packages and solutions.',
                              gradientColors: [Colors.red, Colors.redAccent],
                              index: 4,
                            ),
                            _buildModernServiceCard(
                              icon: Icons.tune,
                              title: 'Performance Optimization',
                              description:
                                  'App performance tuning, memory management, and scalability improvements.',
                              gradientColors: [Colors.teal, Colors.tealAccent],
                              index: 5,
                            ),
                          ],
                        );
                      },
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

class ServiceBackgroundPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  ServiceBackgroundPainter({required this.animation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      final offset = Offset(
        size.width * (0.1 + (i * 0.15) % 0.8),
        size.height * (0.2 + (i * 0.2) % 0.6) +
            animation.value * (i % 2 == 0 ? 1 : -1),
      );

      final radius = 20 + (i * 5);

      if (i % 3 == 0) {
        canvas.drawCircle(offset, radius.toDouble(), paint);
      } else {
        final rect = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: offset,
            width: radius * 2,
            height: radius * 2,
          ),
          Radius.circular(8),
        );
        canvas.drawRRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(ServiceBackgroundPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
