import 'package:flutter/material.dart';
import 'package:rishal/utils/app_colors.dart';

class AboutSection extends StatefulWidget {
  final GlobalKey aboutKey;
  final bool isMobile;

  AboutSection({required this.aboutKey, required this.isMobile});

  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isImageHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0.0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildModernButton(String text, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [AppColors.accent, AppColors.accent.withOpacity(0.7)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.download, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlowingSkillChip(String skill) {
    bool _isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.accent.withOpacity(0.1)
                  : AppColors.cardBackground.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered
                    ? AppColors.accent
                    : AppColors.accent.withOpacity(0.3),
                width: _isHovered ? 1 : 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: AppColors.shadow.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
            ),
            transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? AppColors.accent
                        : AppColors.accent.withOpacity(0.6),
                    shape: BoxShape.circle,
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.8),
                              blurRadius: 8,
                              offset: Offset(0, 0),
                            ),
                          ]
                        : [],
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  skill,
                  style: TextStyle(
                    color: _isHovered
                        ? AppColors.accent
                        : AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHoverImage() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isImageHovered = true),
      onExit: (_) => setState(() => _isImageHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        height: widget.isMobile ? 300 : 520,
        transform: Matrix4.identity()
          ..scale(_isImageHovered ? 1.02 : 1.0)
          ..rotateZ(_isImageHovered ? 0.01 : 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _isImageHovered
                  ? AppColors.accent.withOpacity(0.3)
                  : AppColors.shadow.withOpacity(0.2),
              blurRadius: _isImageHovered ? 30 : 15,
              offset: Offset(0, _isImageHovered ? 15 : 8),
              spreadRadius: _isImageHovered ? 2 : 0,
            ),
            if (_isImageHovered)
              BoxShadow(
                color: AppColors.accent.withOpacity(0.1),
                blurRadius: 60,
                offset: Offset(0, 25),
                spreadRadius: 5,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/rish.jpeg'),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.accent.withOpacity(
                        _isImageHovered ? 0.15 : 0.05,
                      ),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              if (_isImageHovered)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.accent.withOpacity(0.6),
                      width: 2,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.aboutKey,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.background,
            AppColors.cardBackground.withOpacity(0.3),
            AppColors.background,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: widget.isMobile ? 50 : 100,
        horizontal: widget.isMobile ? 20 : 80,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            children: [
              SlideTransition(
                position: _slideAnimation,
                child: Column(
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
                        'ABOUT ME',
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
                        'Crafting Digital Excellence',
                        style: TextStyle(
                          fontSize: widget.isMobile ? 32 : 52,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Flutter Developer & Mobile App Specialist',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: widget.isMobile ? 16 : 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: widget.isMobile ? 40 : 80),
              if (widget.isMobile)
                Column(
                  children: [
                    _buildHoverImage(),
                    SizedBox(height: 40),
                    _buildContentSection(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: Offset(-0.3, 0.0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.easeOut,
                              ),
                            ),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildHoverImage(),
                        ),
                      ),
                    ),
                    SizedBox(width: 60),
                    Expanded(flex: 3, child: _buildContentSection()),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.3, 0.0), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOut,
            ),
          ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                '👋 Hello, I\'m Rishal',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Passionate Flutter Developer Creating Cross-Platform Excellence",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: widget.isMobile ? 24 : 28,
                fontWeight: FontWeight.w700,
                height: 1.3,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "I'm a dedicated Flutter Developer with extensive experience in building high-performance, scalable mobile applications. I specialize in creating seamless cross-platform experiences that deliver exceptional user engagement and robust functionality.",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: widget.isMobile ? 15 : 17,
                height: 1.7,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "My expertise spans the entire mobile development lifecycle, from concept and design to deployment and maintenance. I'm passionate about leveraging cutting-edge technologies to solve complex problems and create innovative solutions.",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: widget.isMobile ? 15 : 17,
                height: 1.7,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accent,
                        AppColors.accent.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Technical Expertise & Skills',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildGlowingSkillChip('Flutter & Dart'),
                _buildGlowingSkillChip('Cross-Platform Development'),
                _buildGlowingSkillChip('Material Design & Cupertino'),
                _buildGlowingSkillChip('Provider / Riverpod'),
                _buildGlowingSkillChip('BLoC Pattern'),
                _buildGlowingSkillChip('REST API Integration'),
                _buildGlowingSkillChip('Firebase Services'),
                _buildGlowingSkillChip('SQLite / Hive'),
                _buildGlowingSkillChip('Cloud Firestore'),
                _buildGlowingSkillChip('Push Notifications'),
                _buildGlowingSkillChip('Geolocation'),
                _buildGlowingSkillChip('Camera & Media'),
                _buildGlowingSkillChip('Unit & Integration Testing'),
                _buildGlowingSkillChip('App Store & Play Store Deployment'),
                _buildGlowingSkillChip('Performance Optimization'),
                _buildGlowingSkillChip('Animations & Transitions'),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                _buildModernButton('DOWNLOAD RESUME', () {
                  // Add resume download functionality
                }),
                if (!widget.isMobile) ...[
                  SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.code, color: AppColors.accent, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'View Projects',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
