import 'package:flutter/material.dart';
import 'package:rishal/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final GlobalKey homeKey;
  final bool isMobile;

  const HeroSection({required this.homeKey, required this.isMobile, Key? key})
    : super(key: key);

  @override
  _HeroSectionState createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _backgroundController;
  late AnimationController _typingController;
  late AnimationController _floatingController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _typingAnimation;
  late Animation<double> _floatingAnimation;

  bool _imageHovered = false;
  Offset _mousePosition = Offset.zero;
  List<String> _roles = [
    'Flutter Developer',
    'Mobile App Expert',
    'UI/UX Enthusiast',
    'Cross-Platform Specialist',
  ];
  int _currentRoleIndex = 0;

  // Social media URLs
  final String linkedinUrl =
      'https://www.linkedin.com/in/rishal-muhammed-9bb017262/';
  final String whatsappUrl = 'https://wa.me/917592895143';
  final String instagramUrl = 'https://www.instagram.com/riishal._/';
  final String phoneUrl = 'tel:+917592895143';
  final String githubUrl = 'https://github.com/riishal/';

  @override
  void initState() {
    super.initState();

    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    );

    _typingController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticOut,
          ),
        );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.linear),
    );

    _typingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _typingController, curve: Curves.easeInOut),
    );

    _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    _animationController.forward();
    _backgroundController.repeat();
    _floatingController.repeat(reverse: true);

    _startTypingCycle();
  }

  void _startTypingCycle() {
    _typingController.forward().then((_) {
      Future.delayed(Duration(milliseconds: 1500), () {
        _typingController.reverse().then((_) {
          setState(() {
            _currentRoleIndex = (_currentRoleIndex + 1) % _roles.length;
          });
          Future.delayed(Duration(milliseconds: 500), _startTypingCycle);
        });
      });
    });
  }

  // Function to launch URLs
  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // You can show a snackbar or dialog here to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open the link'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Function to handle email
  void _makePhonecall() {
    _launchURL(phoneUrl);
  }

  // Function to handle WhatsApp
  void _openWhatsApp() {
    _launchURL(whatsappUrl);
  }

  // Function to handle LinkedIn
  void _openLinkedIn() {
    _launchURL(linkedinUrl);
  }

  // Function to handle Instagram
  void _openInstagram() {
    _launchURL(instagramUrl);
  }

  // Function to handle GitHub
  void _openGitHub() {
    _launchURL(githubUrl);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _backgroundController.dispose();
    _typingController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedBackground() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: !widget.isMobile
              ? (event) {
                  setState(() {
                    _mousePosition = event.localPosition;
                  });
                }
              : null,
          child: AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: ModernParticleBackgroundPainter(
                  rotation: _rotateAnimation.value,
                  mousePosition: _mousePosition,
                  canvasSize: Size(constraints.maxWidth, constraints.maxHeight),
                  color: AppColors.accent.withOpacity(
                    widget.isMobile ? 0.04 : 0.06,
                  ),
                  isMobile: widget.isMobile,
                ),
                size: Size(constraints.maxWidth, constraints.maxHeight),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildModernSocialIcon(
    String icon,
    String tooltip,
    VoidCallback? onTap,
  ) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Tooltip(
            message: tooltip,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: widget.isMobile ? 44 : 50,
              height: widget.isMobile ? 44 : 50,
              decoration: BoxDecoration(
                gradient: isHovered
                    ? LinearGradient(
                        colors: [
                          AppColors.accent,
                          AppColors.accent.withOpacity(0.7),
                        ],
                      )
                    : null,
                color: isHovered
                    ? null
                    : AppColors.cardBackground.withOpacity(0.8),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isHovered
                      ? AppColors.accent.withOpacity(0.8)
                      : AppColors.accent.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.5),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.2),
                          blurRadius: 40,
                          offset: Offset(0, 20),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: AppColors.shadow.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
              ),
              transform: Matrix4.identity()
                ..scale(isHovered ? 1.1 : 1.0)
                ..rotateZ(isHovered ? 0.1 : 0.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(25),
                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      color: isHovered ? Colors.white : AppColors.accent,
                      width: widget.isMobile ? 20 : 24,
                      height: widget.isMobile ? 20 : 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingElement(Widget child, Duration delay) {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: child,
        );
      },
    );
  }

  Widget _buildTypingText() {
    return AnimatedBuilder(
      animation: _typingAnimation,
      builder: (context, child) {
        String currentRole = _roles[_currentRoleIndex];
        int visibleChars = (_typingAnimation.value * currentRole.length)
            .floor();
        String displayText = currentRole.substring(0, visibleChars);

        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: widget.isMobile ? 20 : 24,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accent, AppColors.accent.withOpacity(0.3)],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 12),
            Text(
              displayText,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.accent,
                fontSize: widget.isMobile ? 16 : 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            Container(
              width: 2,
              height: widget.isMobile ? 20 : 24,
              margin: EdgeInsets.only(left: 2),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(1),
              ),
              child: AnimatedOpacity(
                opacity: (_typingAnimation.value * 10) % 2 > 1 ? 1.0 : 0.0,
                duration: Duration(milliseconds: 100),
                child: Container(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildModernProfileImage() {
    return MouseRegion(
      onEnter: (_) => setState(() => _imageHovered = true),
      onExit: (_) => setState(() => _imageHovered = false),
      child: AnimatedBuilder(
        animation: _floatingAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatingAnimation.value * 0.5),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: widget.isMobile ? 200 : 350,
              height: widget.isMobile ? 200 : 350,
              transform: Matrix4.identity()
                ..scale(_imageHovered ? 1.05 : 1.0)
                ..rotateZ(_imageHovered ? 0.02 : 0.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.3),
                    AppColors.gradientEnd.withOpacity(0.2),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _imageHovered
                        ? AppColors.accent.withOpacity(0.4)
                        : AppColors.shadow.withOpacity(0.2),
                    blurRadius: _imageHovered ? 40 : 20,
                    offset: Offset(0, _imageHovered ? 20 : 10),
                    spreadRadius: _imageHovered ? 5 : 0,
                  ),
                  if (_imageHovered)
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.2),
                      blurRadius: 80,
                      offset: Offset(0, 40),
                      spreadRadius: 10,
                    ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/rish.jpeg'),
                  ),
                  border: Border.all(
                    color: _imageHovered
                        ? AppColors.accent.withOpacity(0.8)
                        : AppColors.accent.withOpacity(0.3),
                    width: _imageHovered ? 3 : 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/rish.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.cardBackground,
                            AppColors.gradientEnd,
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        color: AppColors.textSecondary,
                        size: widget.isMobile ? 80 : 120,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernButton(String text, IconData icon, VoidCallback onTap) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isHovered
                    ? [AppColors.accent, AppColors.accent.withOpacity(0.8)]
                    : [
                        AppColors.accent.withOpacity(0.8),
                        AppColors.accent.withOpacity(0.6),
                      ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? AppColors.accent.withOpacity(0.4)
                      : AppColors.accent.withOpacity(0.2),
                  blurRadius: isHovered ? 25 : 15,
                  offset: Offset(0, isHovered ? 12 : 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.isMobile ? 20 : 32,
                    vertical: widget.isMobile ? 12 : 18,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                        size: widget.isMobile ? 16 : 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: widget.isMobile ? 14 : 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        key: widget.homeKey,
        height: widget.isMobile
            ? MediaQuery.of(context).size.height * 0.95
            : MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.background,
                    AppColors.cardBackground.withOpacity(0.5),
                    AppColors.gradientEnd.withOpacity(0.8),
                    AppColors.background,
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
              child: _buildAnimatedBackground(),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: widget.isMobile ? 20 : 80,
                vertical: widget.isMobile ? 20 : 60,
              ),
              child: ClipRect(
                child: widget.isMobile
                    ? _buildMobileLayout()
                    : _buildDesktopLayout(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: _buildFloatingElement(
                  _buildModernProfileImage(),
                  Duration(milliseconds: 200),
                ),
              ),
            ),
          ),
          SizedBox(height: 32),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.accent.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WELCOME TO MY PORTFOLIO',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text('👋', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [AppColors.textPrimary, AppColors.accent],
                      ).createShader(bounds),
                      child: Text(
                        'Rishal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.1,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTypingText(),
                  SizedBox(height: 24),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Crafting beautiful mobile experiences with Flutter.\nTurning ideas into reality, one widget at a time.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.5,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildModernButton('View Projects', Icons.work, () {}),
                        _buildModernButton('Contact Me', Icons.mail, () {}),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildModernSocialIcon(
                          'assets/images/github.svg',
                          'GitHub',
                          _openGitHub,
                        ),
                        _buildModernSocialIcon(
                          'assets/images/linkedin.svg',
                          'LinkedIn',
                          _openLinkedIn,
                        ),
                        _buildModernSocialIcon(
                          'assets/images/instagram.svg',
                          'Instagram',
                          _openInstagram,
                        ),

                        _buildModernSocialIcon(
                          'assets/images/whatsapp.svg',
                          'WhatsApp',
                          _openWhatsApp,
                        ),
                        _buildModernSocialIcon(
                          'assets/images/phone.svg',
                          'Phone',
                          _makePhonecall,
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

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFloatingElement(
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: AppColors.accent.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'WELCOME TO MY PORTFOLIO',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('👋', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    Duration(milliseconds: 0),
                  ),
                  SizedBox(height: 30),
                  _buildFloatingElement(
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [AppColors.textPrimary, AppColors.accent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        'Rishal',
                        style: TextStyle(
                          fontSize: 96,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 0.9,
                          letterSpacing: -2,
                        ),
                      ),
                    ),
                    Duration(milliseconds: 200),
                  ),
                  SizedBox(height: 20),
                  _buildFloatingElement(
                    _buildTypingText(),
                    Duration(milliseconds: 400),
                  ),
                  SizedBox(height: 30),
                  _buildFloatingElement(
                    Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Text(
                        'Passionate Flutter Developer crafting exceptional mobile experiences. I transform ideas into beautiful, high-performance applications that users love.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 18,
                          height: 1.7,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Duration(milliseconds: 600),
                  ),
                  SizedBox(height: 50),
                  _buildFloatingElement(
                    Row(
                      children: [
                        _buildModernButton('View My Work', Icons.work, () {}),
                        SizedBox(width: 20),
                        _buildModernButton('Get In Touch', Icons.mail, () {}),
                      ],
                    ),
                    Duration(milliseconds: 800),
                  ),
                  SizedBox(height: 50),
                  _buildFloatingElement(
                    Row(
                      children: [
                        _buildModernSocialIcon(
                          'assets/images/github.svg',
                          'GitHub',
                          _openGitHub,
                        ),
                        SizedBox(width: 20),
                        _buildModernSocialIcon(
                          'assets/images/linkedin.svg',
                          'LinkedIn',
                          _openLinkedIn,
                        ),
                        SizedBox(width: 20),
                        _buildModernSocialIcon(
                          'assets/images/instagram.svg',
                          'Instagram',
                          _openInstagram,
                        ),
                        SizedBox(width: 20),
                        _buildModernSocialIcon(
                          'assets/images/whatsapp.svg',
                          'WhatsApp',
                          _openWhatsApp,
                        ),

                        SizedBox(width: 20),
                        _buildModernSocialIcon(
                          'assets/images/phone.svg',
                          'Phone',
                          _makePhonecall,
                        ),
                      ],
                    ),
                    Duration(milliseconds: 1000),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(0.5, 0), end: Offset.zero)
                .animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.elasticOut,
                  ),
                ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Center(child: _buildModernProfileImage()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Modern Particle System with Dynamic Grid Distortion
class ModernParticleBackgroundPainter extends CustomPainter {
  final double rotation;
  final Offset mousePosition;
  final Size canvasSize;
  final Color color;
  final bool isMobile;

  ModernParticleBackgroundPainter({
    required this.rotation,
    required this.mousePosition,
    required this.canvasSize,
    required this.color,
    this.isMobile = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15);

    // Particle system with orbiting clusters
    final particleCount = isMobile ? 30 : 60;
    final particles = <Offset>[];
    final particleSizes = <double>[];
    final particleOpacities = <double>[];
    final particleSpeeds = <double>[];

    // Generate particles with dynamic orbits
    for (int i = 0; i < particleCount; i++) {
      final baseAngle = (i / particleCount) * 2 * math.pi;
      final orbitRadius = size.width * (0.1 + (i % 4) * 0.1);

      // Mouse influence
      double mouseInfluence = 0;
      if (!isMobile && mousePosition != Offset.zero) {
        final mouseDistance =
            (mousePosition - Offset(size.width / 2, size.height / 2)).distance;
        mouseInfluence =
            math.max(0, 1 - (mouseDistance / (size.width * 0.4))) * 0.4;
      }

      // Dynamic orbit animation
      final orbitSpeed = 0.3 + (i % 3) * 0.1;
      final animatedAngle = baseAngle + rotation * orbitSpeed;
      final animatedRadius =
          orbitRadius +
          math.sin(rotation * 1.5 + i) * 20 +
          (mouseInfluence * 40);

      double x = size.width / 2 + math.cos(animatedAngle) * animatedRadius;
      double y = size.height / 2 + math.sin(animatedAngle) * animatedRadius;

      // Enhanced mouse attraction
      if (!isMobile && mousePosition != Offset.zero) {
        final attractionStrength = mouseInfluence * 0.5;
        x += (mousePosition.dx - x) * attractionStrength;
        y += (mousePosition.dy - y) * attractionStrength;
      }

      particles.add(Offset(x, y));
      particleSizes.add(
        3.0 + math.sin(rotation * 2 + i) * 2 + mouseInfluence * 3,
      );
      particleOpacities.add(
        0.4 + math.cos(rotation + i) * 0.3 + mouseInfluence * 0.3,
      );
      particleSpeeds.add(orbitSpeed);
    }

    // Draw dynamic connections
    if (!isMobile) {
      for (int i = 0; i < particles.length; i++) {
        for (int j = i + 1; j < particles.length; j++) {
          final distance = (particles[i] - particles[j]).distance;
          final maxConnectionDistance = 150.0;

          if (distance < maxConnectionDistance) {
            final lineOpacity = (1 - distance / maxConnectionDistance) * 0.2;
            final mouseProximity = mousePosition != Offset.zero
                ? math.max(
                    0,
                    1 -
                        ((mousePosition -
                                    Offset(
                                      (particles[i].dx + particles[j].dx) / 2,
                                      (particles[i].dy + particles[j].dy) / 2,
                                    ))
                                .distance /
                            250),
                  )
                : 0.0;

            linePaint.color = color.withOpacity(
              lineOpacity + mouseProximity * 0.3,
            );
            canvas.drawLine(particles[i], particles[j], linePaint);
          }
        }
      }
    }

    // Draw particles with enhanced glow
    for (int i = 0; i < particles.length; i++) {
      final particle = particles[i];
      final size = particleSizes[i];
      final opacity = particleOpacities[i];

      // Enhanced glow effect
      if (!isMobile) {
        glowPaint.color = color.withOpacity(opacity * 0.4);
        canvas.drawCircle(particle, size * 3, glowPaint);
      }

      paint.color = color.withOpacity(opacity);
      canvas.drawCircle(particle, size, paint);
    }

    // Floating geometric shapes with dynamic scaling
    final shapeCount = isMobile ? 10 : 20;
    for (int i = 0; i < shapeCount; i++) {
      final angle = rotation * (0.4 + i * 0.1) + (i * math.pi / 5);
      final baseDistance = size.width * (0.1 + (i % 3) * 0.15);

      double mouseEffect = 0;
      if (!isMobile && mousePosition != Offset.zero) {
        final mouseDistance =
            (mousePosition - Offset(size.width / 2, size.height / 2)).distance;
        mouseEffect =
            math.max(0, 1 - (mouseDistance / (size.width * 0.5))) * 0.5;
      }

      final distance =
          baseDistance + math.sin(rotation * 1.2 + i) * 30 + (mouseEffect * 50);

      double x = size.width / 2 + math.cos(angle) * distance;
      double y = size.height / 2 + math.sin(angle) * distance;

      if (!isMobile && mousePosition != Offset.zero) {
        final attraction = mouseEffect * 0.4;
        x += (mousePosition.dx - x) * attraction;
        y += (mousePosition.dy - y) * attraction;
      }

      final shapeSize =
          (isMobile ? 6 : 10) +
          math.sin(rotation * 1.5 + i) * 3 +
          (mouseEffect * 6);
      final opacity =
          0.3 +
          (math.sin(rotation + i * 0.8) + 1) / 2 * 0.2 +
          (mouseEffect * 0.4);

      paint.color = color.withOpacity(opacity);

      // Draw varied shapes
      if (i % 4 == 0) {
        canvas.drawCircle(Offset(x, y), shapeSize / 2, paint);
      } else if (i % 4 == 1) {
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(x, y),
            width: shapeSize,
            height: shapeSize,
          ),
          paint,
        );
      } else if (i % 4 == 2) {
        final path = Path();
        path.moveTo(x, y - shapeSize / 2);
        path.lineTo(x - shapeSize / 2, y + shapeSize / 2);
        path.lineTo(x + shapeSize / 2, y + shapeSize / 2);
        path.close();
        canvas.drawPath(path, paint);
      } else {
        final path = Path();
        path.moveTo(x, y - shapeSize / 2);
        path.lineTo(x - shapeSize / 2, y);
        path.lineTo(x, y + shapeSize / 2);
        path.lineTo(x + shapeSize / 2, y);
        path.close();
        canvas.drawPath(path, paint);
      }
    }

    // Dynamic grid distortion effect (desktop only)
    if (!isMobile) {
      final gridPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8;

      final gridSpacing = 60.0;
      final distortionRadius = 200.0;

      // Vertical lines with distortion
      for (double x = 0; x < size.width; x += gridSpacing) {
        double opacity = 0.05;
        double distortionX = 0;

        if (mousePosition != Offset.zero) {
          final distance = (mousePosition.dx - x).abs();
          if (distance < distortionRadius) {
            opacity += (1 - distance / distortionRadius) * 0.15;
            distortionX =
                (1 - distance / distortionRadius) *
                (mousePosition.dx - x) *
                0.1;
          }
        }

        gridPaint.color = color.withOpacity(opacity);
        final path = Path();
        for (double y = 0; y < size.height; y += gridSpacing / 2) {
          double localDistortionX = distortionX * (1 - (y / size.height));
          path.moveTo(x + localDistortionX, y);
          path.lineTo(x + localDistortionX, y + gridSpacing / 2);
        }
        canvas.drawPath(path, gridPaint);
      }

      // Horizontal lines with distortion
      for (double y = 0; y < size.height; y += gridSpacing) {
        double opacity = 0.05;
        double distortionY = 0;

        if (mousePosition != Offset.zero) {
          final distance = (mousePosition.dy - y).abs();
          if (distance < distortionRadius) {
            opacity += (1 - distance / distortionRadius) * 0.15;
            distortionY =
                (1 - distance / distortionRadius) *
                (mousePosition.dy - y) *
                0.1;
          }
        }

        gridPaint.color = color.withOpacity(opacity);
        final path = Path();
        for (double x = 0; x < size.width; x += gridSpacing / 2) {
          double localDistortionY = distortionY * (1 - (x / size.width));
          path.moveTo(x, y + localDistortionY);
          path.lineTo(x + gridSpacing / 2, y + localDistortionY);
        }
        canvas.drawPath(path, gridPaint);
      }
    }
  }

  @override
  bool shouldRepaint(ModernParticleBackgroundPainter oldDelegate) {
    return oldDelegate.rotation != rotation ||
        oldDelegate.mousePosition != mousePosition ||
        oldDelegate.isMobile != isMobile;
  }
}
