import 'package:flutter/material.dart';
import 'package:rishal/models/project_model.dart';
import 'package:rishal/screens/project_detail/project_detail_page.dart';
import 'package:rishal/utils/app_colors.dart';

class ModernPortfolioSection extends StatefulWidget {
  final GlobalKey portfolioKey;
  final bool isMobile;

  ModernPortfolioSection({required this.portfolioKey, required this.isMobile});

  @override
  _ModernPortfolioSectionState createState() => _ModernPortfolioSectionState();
}

class _ModernPortfolioSectionState extends State<ModernPortfolioSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
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

  Widget _buildPortfolioCard({
    required Project project,
    required Color primaryColor,
    required IconData icon,
  }) {
    bool _isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectDetailPage(project: project),
                ),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? primaryColor.withOpacity(0.25)
                        : Colors.black.withOpacity(0.06),
                    blurRadius: _isHovered ? 28 : 12,
                    offset: Offset(0, _isHovered ? 12 : 6),
                    spreadRadius: _isHovered ? 1 : 0,
                  ),
                ],
              ),
              transform: Matrix4.identity()
                ..scale(_isHovered ? 1.02 : 1.0)
                ..translate(0.0, _isHovered ? -8.0 : 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    border: Border.all(
                      color: _isHovered
                          ? primaryColor.withOpacity(0.35)
                          : Colors.transparent,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      Expanded(
                        flex: 5,
                        child: Stack(
                          children: [
                            // Main Image Display
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.asset(
                                project.imageUrl,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          primaryColor.withOpacity(0.25),
                                          primaryColor.withOpacity(0.08),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            icon,
                                            size: 64,
                                            color: primaryColor.withOpacity(
                                              0.5,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'Image Not Found',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Subtle gradient overlay at bottom
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.4),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            // Category Badge - Top Left
                            Positioned(
                              top: 12,
                              left: 12,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _isHovered
                                      ? primaryColor
                                      : Colors.white.withOpacity(0.92),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      icon,
                                      size: 14,
                                      color: _isHovered
                                          ? Colors.white
                                          : primaryColor,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      project.category,
                                      style: TextStyle(
                                        color: _isHovered
                                            ? Colors.white
                                            : primaryColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Hover Overlay
                            if (_isHovered)
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      primaryColor.withOpacity(0.08),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Content Section
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.all(widget.isMobile ? 16 : 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                project.title,
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: widget.isMobile ? 16 : 18,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.2,
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              // Description
                              Expanded(
                                child: Text(
                                  project.description,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: widget.isMobile ? 12 : 13,
                                    height: 1.5,
                                    letterSpacing: 0.1,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 12),
                              // Technologies
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: project.technologies.take(3).map((
                                  tech,
                                ) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          primaryColor.withOpacity(0.12),
                                          primaryColor.withOpacity(0.06),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                        color: primaryColor.withOpacity(0.25),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: Text(
                                      tech,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 12),
                              // Action Button
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  gradient: _isHovered
                                      ? LinearGradient(
                                          colors: [
                                            primaryColor,
                                            primaryColor.withOpacity(0.8),
                                          ],
                                        )
                                      : null,
                                  color: _isHovered
                                      ? null
                                      : primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: primaryColor.withOpacity(
                                      _isHovered ? 0.7 : 0.25,
                                    ),
                                    width: _isHovered ? 1.5 : 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'View Details',
                                      style: TextStyle(
                                        color: _isHovered
                                            ? Colors.white
                                            : primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: _isHovered
                                          ? Colors.white
                                          : primaryColor,
                                      size: 16,
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
    final List<Project> projects = [
      Project(
        title: 'ECSO - Cargo Management',
        description:
            'A powerful cargo management app designed for logistics professionals. Handles air and sea cargo booking, real-time tracking, and comprehensive reporting. Available on Play Store.',
        category: 'Logistics',
        technologies: ['Flutter', 'Firebase', 'Real-time Tracking', 'Reports'],
        imageUrl: 'assets/images/ecso/ecsoimage.jpeg',
        uiImages: [
          'assets/images/ecso/ecso1.jpeg',
          'assets/images/ecso/ecso2.jpeg',
          'assets/images/ecso/ecso3.jpeg',
          'assets/images/ecso/ecso4.jpeg',
        ],
      ),
      Project(
        title: 'Inspec - Quality Control',
        description:
            'QC application integrated with CODE7 ERP Production Module. Digitalizes quality control processes with step-by-step workflows, ensuring consistent inspections. Available on Play Store.',
        category: 'Manufacturing',
        technologies: [
          'Flutter',
          'ERP Integration',
          'QC Automation',
          'Analytics',
        ],
        imageUrl: 'assets/images/inspec/inspecimage.jpeg',
        uiImages: [
          'assets/images/inspec/inspec1.jpeg',
          'assets/images/inspec/inspec2.jpeg',
          'assets/images/inspec/inspec3.jpeg',
          'assets/images/inspec/inspec4.jpeg',
          'assets/images/inspec/inspec5.jpeg',
          'assets/images/inspec/inspec6.jpeg',
        ],
      ),
      Project(
        title: 'Site Diary - Construction Hub',
        description:
            'Complete digital command center for construction sites. Streamlined employee management, real-time expense tracking, insightful reports, and precise order tracking. Freelance project.',
        category: 'Construction',
        technologies: [
          'Flutter',
          'PDF Generation',
          'Expense Tracking',
          'Reports',
        ],
        imageUrl: 'assets/images/sitediary/sitediaryimage.jpeg',
        uiImages: [
          'assets/images/sitediary/sitediary1.jpeg',
          'assets/images/sitediary/sitediary2.jpeg',
          'assets/images/sitediary/sitediary3.jpeg',
          'assets/images/sitediary/sitediary4.jpeg',
          'assets/images/sitediary/sitediary5.jpeg',
          'assets/images/sitediary/sitediary6.jpeg',
        ],
      ),
    ];

    final List<Color> projectColors = [
      Color(0xFF4A90E2), // Modern Blue
      Color(0xFFa2bb00), // Olive Green
      Color(0xFFFF6B9D), // Pink Rose
    ];

    final List<IconData> projectIcons = [
      Icons.local_shipping_rounded,
      Icons.verified_outlined,
      Icons.construction_rounded,
    ];

    return Container(
      key: widget.portfolioKey,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.background,
            AppColors.cardBackground.withOpacity(0.15),
            AppColors.background,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: widget.isMobile ? 50 : 50,
        horizontal: widget.isMobile ? 16 : 190,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              // Header Section
              Column(
                children: [
                  // Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accent.withOpacity(0.15),
                          AppColors.accent.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.3),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.work_outline_rounded,
                          color: AppColors.accent,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'PORTFOLIO',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // Title
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [AppColors.textPrimary, AppColors.accent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'Featured Projects',
                      style: TextStyle(
                        fontSize: widget.isMobile ? 34 : 50,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.1,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Description
                  Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Text(
                      'Innovative mobile solutions crafted with precision and modern design principles.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: widget.isMobile ? 14 : 16,
                        height: 1.6,
                        letterSpacing: 0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: widget.isMobile ? 40 : 60),
              // Projects Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount;
                  double childAspectRatio;

                  if (widget.isMobile) {
                    crossAxisCount = 1;
                    childAspectRatio = 0.75;
                  } else if (constraints.maxWidth < 1200) {
                    crossAxisCount = 2;
                    childAspectRatio = 0.7;
                  } else {
                    crossAxisCount = 3;
                    childAspectRatio = 0.68;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return _buildPortfolioCard(
                        project: project,
                        primaryColor: projectColors[index],
                        icon: projectIcons[index],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
