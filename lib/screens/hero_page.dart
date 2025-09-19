import 'package:flutter/material.dart';
import 'package:rishal/utils/app_colors.dart';
import 'dart:math' as math;

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
  List<String> _roles = [
    'Flutter Developer',
    'Mobile App Expert',
    'UI/UX Enthusiast',
    'Cross-Platform Specialist',
  ];
  int _currentRoleIndex = 0;

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
      duration: Duration(seconds: 20),
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
        return AnimatedBuilder(
          animation: _rotateAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: GeometricBackgroundPainter(
                rotation: _rotateAnimation.value,
                color: AppColors.accent.withOpacity(0.1),
              ),
              size: Size(constraints.maxWidth, constraints.maxHeight),
            );
          },
        );
      },
    );
  }

  Widget _buildModernSocialIcon(
    IconData icon,
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
              width: 50,
              height: 50,
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
                  child: Icon(
                    icon,
                    color: isHovered ? Colors.white : AppColors.accent,
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
          children: [
            Container(
              width: 4,
              height: 24,
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
              style: TextStyle(
                color: AppColors.accent,
                fontSize: widget.isMobile ? 18 : 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            Container(
              width: 2,
              height: 24,
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
                    image: AssetImage('assets/images/myprofile.png'),
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
                    'assets/images/myprofile.png',
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
                    horizontal: widget.isMobile ? 24 : 32,
                    vertical: widget.isMobile ? 14 : 18,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: Colors.white, size: 20),
                      SizedBox(width: 10),
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
    return Container(
      key: widget.homeKey,
      height: widget.isMobile
          ? MediaQuery.of(context).size.height * 0.90
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
            padding: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 5 : 80,
              vertical: widget.isMobile ? 40 : 60,
            ),
            child: ClipRect(
              child: widget.isMobile
                  ? _buildMobileLayout()
                  : _buildDesktopLayout(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        SizedBox(height: 40),
        SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
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
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('👋', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [AppColors.textPrimary, AppColors.accent],
                  ).createShader(bounds),
                  child: Text(
                    'Rishal',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _buildTypingText(),
                SizedBox(height: 30),
                Text(
                  'Crafting beautiful mobile experiences with Flutter.\nTurning ideas into reality, one widget at a time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.6,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 40),
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildModernButton('View Projects', Icons.work, () {}),
                    _buildModernButton('Contact Me', Icons.mail, () {}),
                  ],
                ),
                SizedBox(height: 40),
                Wrap(
                  spacing: 20,
                  runSpacing: 15,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildModernSocialIcon(Icons.code, 'GitHub', () {}),
                    _buildModernSocialIcon(Icons.work, 'LinkedIn', () {}),
                    _buildModernSocialIcon(
                      Icons.flutter_dash,
                      'Flutter',
                      () {},
                    ),
                    _buildModernSocialIcon(Icons.email, 'Email', () {}),
                    _buildModernSocialIcon(Icons.phone, 'WhatsApp', () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
                        _buildModernSocialIcon(Icons.code, 'GitHub', () {}),
                        SizedBox(width: 20),
                        _buildModernSocialIcon(Icons.work, 'LinkedIn', () {}),
                        SizedBox(width: 20),
                        _buildModernSocialIcon(
                          Icons.flutter_dash,
                          'Flutter',
                          () {},
                        ),
                        SizedBox(width: 20),
                        _buildModernSocialIcon(Icons.email, 'Email', () {}),
                        SizedBox(width: 20),
                        _buildModernSocialIcon(Icons.phone, 'WhatsApp', () {}),
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

class GeometricBackgroundPainter extends CustomPainter {
  final double rotation;
  final Color color;

  GeometricBackgroundPainter({required this.rotation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotation);

    for (int i = 0; i < 6; i++) {
      canvas.rotate(math.pi / 3);
      canvas.drawCircle(Offset(size.width * 0.2, 0), size.width * 0.1, paint);

      final path = Path();
      path.moveTo(size.width * 0.15, -size.width * 0.05);
      path.lineTo(size.width * 0.25, -size.width * 0.05);
      path.lineTo(size.width * 0.3, size.width * 0.05);
      path.lineTo(size.width * 0.2, size.width * 0.1);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(GeometricBackgroundPainter oldDelegate) {
    return oldDelegate.rotation != rotation;
  }
}
