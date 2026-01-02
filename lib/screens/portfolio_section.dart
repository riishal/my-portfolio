import 'package:flutter/material.dart';
import 'package:rishal/utils/app_colors.dart';
import 'dart:math' as math;

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
  late AnimationController _hoverController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Mobile Apps',
    'Management Systems',
    'UI/UX Design',
    'Business Solutions',
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
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
    _hoverController.dispose();
    super.dispose();
  }

  Widget _buildFilterButton(String filter) {
    bool isSelected = _selectedFilter == filter;
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedFilter = filter);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.only(right: 12, bottom: 8),
              padding: EdgeInsets.symmetric(
                horizontal: widget.isMobile ? 16 : 20,
                vertical: widget.isMobile ? 8 : 12,
              ),
              decoration: BoxDecoration(
                gradient: isSelected || isHovered
                    ? LinearGradient(
                        colors: [
                          AppColors.accent,
                          AppColors.accent.withOpacity(0.8),
                        ],
                      )
                    : null,
                color: isSelected || isHovered
                    ? null
                    : AppColors.cardBackground.withOpacity(0.6),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected || isHovered
                      ? AppColors.accent.withOpacity(0.8)
                      : AppColors.accent.withOpacity(0.3),
                ),
                boxShadow: isSelected || isHovered
                    ? [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.3),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ]
                    : [],
              ),
              transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected || isHovered
                      ? Colors.white
                      : AppColors.textSecondary,
                  fontSize: widget.isMobile ? 12 : 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPortfolioCard({
    required String title,
    required String description,
    required String category,
    required List<String> technologies,
    required Color primaryColor,
    required IconData icon,
    required String imageUrl,
    required int index,
  }) {
    bool _isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            transform: Matrix4.identity()
              ..scale(_isHovered ? 1.02 : 1.0)
              ..rotateX(_isHovered ? -0.02 : 0.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isHovered
                    ? [
                        primaryColor.withOpacity(0.1),
                        AppColors.cardBackground.withOpacity(0.9),
                      ]
                    : [
                        AppColors.cardBackground.withOpacity(0.8),
                        AppColors.background.withOpacity(0.9),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered
                    ? primaryColor.withOpacity(0.5)
                    : AppColors.accent.withOpacity(0.1),
                width: _isHovered ? 2 : 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 30,
                        offset: Offset(0, 15),
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: primaryColor.withOpacity(0.1),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withOpacity(_isHovered ? 0.2 : 0.1),
                            primaryColor.withOpacity(_isHovered ? 0.1 : 0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Background Image
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: primaryColor.withOpacity(0.1),
                                    child: Icon(
                                      icon,
                                      color: primaryColor,
                                      size: 50,
                                    ),
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        color: primaryColor.withOpacity(0.1),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    },
                              ),
                            ),
                          ),
                          // Gradient Overlay
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  primaryColor.withOpacity(
                                    _isHovered ? 0.3 : 0.1,
                                  ),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          // Icon in center
                          Center(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: widget.isMobile ? 60 : 80,
                              height: widget.isMobile ? 60 : 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    primaryColor.withOpacity(0.9),
                                    primaryColor.withOpacity(0.7),
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: _isHovered
                                    ? [
                                        BoxShadow(
                                          color: primaryColor.withOpacity(0.4),
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        ),
                                      ]
                                    : [],
                              ),
                              transform: Matrix4.identity()
                                ..scale(_isHovered ? 1.1 : 1.0)
                                ..rotateZ(_isHovered ? 0.1 : 0.0),
                              child: Icon(
                                icon,
                                color: Colors.white,
                                size: widget.isMobile ? 28 : 36,
                              ),
                            ),
                          ),
                          // Category Badge
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(widget.isMobile ? 20 : 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: _isHovered
                                  ? primaryColor
                                  : AppColors.textPrimary,
                              fontSize: widget.isMobile ? 16 : 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              description,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: widget.isMobile ? 12 : 14,
                                height: 1.5,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: technologies
                                .take(3)
                                .map(
                                  (tech) => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: primaryColor.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Text(
                                      tech,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  height: 36,
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
                                        : AppColors.accent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: _isHovered
                                          ? primaryColor
                                          : AppColors.accent.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(18),
                                      child: Center(
                                        child: Text(
                                          'View Project',
                                          style: TextStyle(
                                            color: _isHovered
                                                ? Colors.white
                                                : AppColors.accent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: _isHovered
                                      ? primaryColor.withOpacity(0.1)
                                      : AppColors.cardBackground,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _isHovered
                                        ? primaryColor.withOpacity(0.5)
                                        : AppColors.accent.withOpacity(0.3),
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(18),
                                    child: Icon(
                                      Icons.code,
                                      color: _isHovered
                                          ? primaryColor
                                          : AppColors.textSecondary,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> projects = [
      {
        'title': 'ECSO - Cargo Delivery App',
        'description':
            'Complete cargo delivery management system with bill generation, expense tracking, delivery monitoring, and receipt printing capabilities.',
        'category': 'Business Solutions',
        'technologies': ['Flutter', 'Firebase', 'PDF Generation', 'Tracking'],
        'color': Colors.blue,
        'icon': Icons.local_shipping,
        'imageUrl':
            'https://img.freepik.com/premium-photo/ecommerce-concept-transportation-shipment-delivery-by-truck-3d-illustration_68971-1446.jpg',
      },
      {
        'title': 'Inspec - Employee Quality Timer',
        'description':
            'Advanced employee productivity management system with quality time tracking, task completion monitoring, and performance analytics.',
        'category': 'Management Systems',
        'technologies': ['Flutter', 'Timer API', 'Analytics', 'Reports'],
        'color': Colors.green,
        'icon': Icons.timer,
        'imageUrl':
            'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400&h=300&fit=crop',
      },
      {
        'title': 'Gym Management System',
        'description':
            'Comprehensive gym management app with customer tracking, membership expiry notifications, receipt printing, and payment management.',
        'category': 'Management Systems',
        'technologies': ['Flutter', 'SQLite', 'Notifications', 'Print'],
        'color': Colors.red,
        'icon': Icons.fitness_center,
        'imageUrl':
            'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=300&fit=crop',
      },
      {
        'title': 'Site Diary - Finance Tracker',
        'description':
            'Complete site management solution with cash receipts, payment tracking, expense reports, employee attendance, and advance payment management.',
        'category': 'Business Solutions',
        'technologies': ['Flutter', 'Financial API', 'Reports', 'Attendance'],
        'color': Colors.orange,
        'icon': Icons.account_balance_wallet,
        'imageUrl':
            'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&h=300&fit=crop',
      },
      {
        'title': 'Food Booking App UI',
        'description':
            'Modern food ordering interface with restaurant discovery, location tracking, menu browsing, and seamless ordering experience.',
        'category': 'UI/UX Design',
        'technologies': ['Flutter', 'Maps API', 'UI Design', 'Location'],
        'color': Colors.purple,
        'icon': Icons.restaurant,
        'imageUrl':
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=300&fit=crop',
      },
      {
        'title': 'Albaik - Employee Management',
        'description':
            'Enterprise-level employee attendance system with driver location tracking, production monitoring, comprehensive reporting, and workforce analytics.',
        'category': 'Management Systems',
        'technologies': ['Flutter', 'GPS Tracking', 'Analytics', 'Enterprise'],
        'color': Colors.teal,
        'icon': Icons.business,
        'imageUrl': '',
      },
    ];

    return Container(
      key: widget.portfolioKey,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.background,
            AppColors.cardBackground.withOpacity(0.2),
            AppColors.background,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      'PORTFOLIO',
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
                      'Featured Projects',
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
                      'Here are some of my recent projects showcasing business solutions, management systems, and modern mobile applications.',
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
              SizedBox(height: widget.isMobile ? 40 : 60),
              Container(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: _filters
                      .map((filter) => _buildFilterButton(filter))
                      .toList(),
                ),
              ),
              SizedBox(height: widget.isMobile ? 30 : 50),
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount;
                  double childAspectRatio;

                  if (widget.isMobile) {
                    crossAxisCount = 1;
                    childAspectRatio = 0.85;
                  } else if (constraints.maxWidth < 1200) {
                    crossAxisCount = 2;
                    childAspectRatio = 0.8;
                  } else {
                    crossAxisCount = 3;
                    childAspectRatio = 0.75;
                  }

                  return GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: childAspectRatio,
                    children: projects.asMap().entries.map((entry) {
                      final project = entry.value;
                      return _buildPortfolioCard(
                        title: project['title'],
                        description: project['description'],
                        category: project['category'],
                        technologies: project['technologies'],
                        primaryColor: project['color'],
                        icon: project['icon'],
                        imageUrl: project['imageUrl'],
                        index: entry.key,
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: widget.isMobile ? 40 : 60),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent,
                      AppColors.accent.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.isMobile ? 32 : 40,
                        vertical: widget.isMobile ? 16 : 20,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.work, color: Colors.white, size: 20),
                          SizedBox(width: 12),
                          Text(
                            'View All Projects',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: widget.isMobile ? 14 : 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectBackgroundPainter extends CustomPainter {
  final Color color;
  final bool isHovered;

  ProjectBackgroundPainter({required this.color, required this.isHovered});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    if (isHovered) {
      for (int i = 0; i < 5; i++) {
        final offset = Offset(
          size.width * (0.1 + i * 0.2),
          size.height * (0.1 + i * 0.15),
        );
        canvas.drawCircle(offset, 8 + i * 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(ProjectBackgroundPainter oldDelegate) {
    return oldDelegate.isHovered != isHovered;
  }
}
