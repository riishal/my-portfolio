import 'package:flutter/material.dart';
import 'package:rishal/models/project_model.dart';
import 'package:rishal/utils/app_colors.dart';
import 'dart:ui';
import 'dart:async';

class ProjectDetailPage extends StatefulWidget {
  final Project project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final ScrollController _mockupScrollController = ScrollController();

  // Auto-scroll variables
  Timer? _autoScrollTimer;
  int _currentImageIndex = 0;
  bool _userInteracted = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutQuint),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();

    // Start auto-scroll after a brief delay
    Future.delayed(const Duration(seconds: 2), () {
      _startAutoScroll();
    });

    // Listen to user scroll interactions
    _mockupScrollController.addListener(_onUserScroll);
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_userInteracted && mounted) {
        _scrollToNextImage();
      }
    });
  }

  void _scrollToNextImage() {
    if (!mounted) return;

    final images = widget.project.uiImages;
    if (images.isEmpty) return;

    _currentImageIndex = (_currentImageIndex + 1) % images.length;

    // Calculate scroll position based on screen width
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    final mockupWidth = isMobile
        ? 280.0
        : isTablet
        ? 320.0
        : 360.0;
    final spacing = isMobile ? 24.0 : 40.0;
    final targetOffset = _currentImageIndex * (mockupWidth + spacing);

    _mockupScrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onUserScroll() {
    if (_mockupScrollController.position.isScrollingNotifier.value) {
      setState(() {
        _userInteracted = true;
      });

      // Resume auto-scroll after 10 seconds of inactivity
      _autoScrollTimer?.cancel();
      _autoScrollTimer = Timer(const Duration(seconds: 10), () {
        if (mounted) {
          setState(() {
            _userInteracted = false;
          });
          _startAutoScroll();
        }
      });
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _fadeController.dispose();
    _slideController.dispose();
    _mockupScrollController.dispose();
    super.dispose();
  }

  // Helper function to get project-specific content
  Map<String, dynamic> _getProjectContent() {
    final title = widget.project.title.toLowerCase();

    if (title.contains('ecso')) {
      return {
        'fullDescription':
            'Ecso is a powerful cargo management app designed for businesses and logistics professionals. It helps you handle everything from cargo booking to tracking and reporting, all in one platform. With support for both air cargo and sea cargo, Ecso ensures smooth and efficient operations for all your shipment needs.',
        'availability': 'Available on Play Store',
        'features': [
          _FeatureData(
            Icons.flight_takeoff,
            'Cargo Booking',
            'Quickly book air and sea cargo with detailed shipment information',
            Colors.blue,
          ),
          _FeatureData(
            Icons.track_changes,
            'Real-Time Tracking',
            'Track cargo status and movement in real time with full transparency',
            Colors.teal,
          ),
          _FeatureData(
            Icons.receipt_long,
            'Bills & Reports',
            'Access detailed invoices, billing summaries, and shipment reports',
            Colors.purple,
          ),
          _FeatureData(
            Icons.security,
            'Secure & Intuitive',
            'Clean interface designed to simplify logistics operations',
            Colors.orange,
          ),
        ],
        'targetUsers': [
          'Freight and logistics companies',
          'Import and export businesses',
          'Warehouse and distribution centers',
          'Transport agencies managing cargo operations',
        ],
      };
    } else if (title.contains('inspec')) {
      return {
        'fullDescription':
            'Inspec is a Quality Check (QC) application integrated with the CODE7 ERP Production Module. It digitalizes and automates the entire quality control process in manufacturing. The app connects the QC setup in CODE7 with real-time inspections on the production floor, ensuring each stage meets quality standards before moving to the next.',
        'availability': 'Available on Play Store',
        'features': [
          _FeatureData(
            Icons.integration_instructions,
            'ERP Integration',
            'Seamlessly connects with CODE7 ERP Production Module',
            Colors.purple,
          ),
          _FeatureData(
            Icons.checklist,
            'Step-by-Step Workflow',
            'Each QC task is performed, checked, and approved in order',
            Colors.teal,
          ),
          _FeatureData(
            Icons.analytics,
            'Real-Time Tracking',
            'Monitor quality control processes in real time on production floor',
            Colors.blue,
          ),
          _FeatureData(
            Icons.verified,
            'Quality Assurance',
            'Ensures consistent inspections and clear accountability',
            Colors.orange,
          ),
        ],
        'targetUsers': [
          'Manufacturing facilities',
          'Quality control departments',
          'Production managers',
          'ERP system users',
        ],
      };
    } else if (title.contains('site')) {
      return {
        'fullDescription':
            'Site Diary is a complete digital command center for construction sites. It brings streamlined employee management, real-time expense tracking with accuracy, insightful reports with branded PDF invoices, and precise order tracking for every detail. This project is more than just an app – it\'s the result of countless hours of thought, code, and passion.',
        'availability': 'Freelance Project',
        'features': [
          _FeatureData(
            Icons.people,
            'Employee Management',
            'Streamlined workforce management and attendance tracking',
            Colors.blue,
          ),
          _FeatureData(
            Icons.monetization_on,
            'Expense Tracking',
            'Real-time financial tracking with accuracy and transparency',
            Colors.teal,
          ),
          _FeatureData(
            Icons.assessment,
            'Reports & Invoices',
            'Generate insightful reports and branded PDF invoices',
            Colors.purple,
          ),
          _FeatureData(
            Icons.inventory,
            'Order Tracking',
            'Precise tracking for every material order and delivery',
            Colors.orange,
          ),
        ],
        'targetUsers': [
          'Construction site managers',
          'Contractors and builders',
          'Project coordinators',
          'Construction companies',
        ],
      };
    }

    // Default fallback
    return {
      'fullDescription': widget.project.description,
      'availability': '',
      'features': [
        _FeatureData(
          Icons.design_services,
          'Modern UI/UX',
          'Clean & intuitive design',
          Colors.purple,
        ),
        _FeatureData(
          Icons.speed,
          'High Performance',
          'Fast & optimized',
          Colors.teal,
        ),
        _FeatureData(
          Icons.security,
          'Secure',
          'Best practices applied',
          Colors.blue,
        ),
        _FeatureData(
          Icons.devices,
          'Cross-Platform',
          'iOS + Android',
          Colors.orange,
        ),
      ],
      'targetUsers': [],
    };
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final paddingHorizontal = isMobile
        ? 16.0
        : isTablet
        ? 36.0
        : 60.0;

    final projectContent = _getProjectContent();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Modern Glass AppBar ──
          SliverAppBar(
            expandedHeight: 80,
            floating: true,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.background.withOpacity(0.9),
                        AppColors.background.withOpacity(0.7),
                      ],
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.accent.withOpacity(0.1),
                        width: 0.6,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            leadingWidth: 64,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: _GlassBackButton(),
            ),
            title: FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                widget.project.title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: isMobile ? 16 : 19,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.1,
                ),
              ),
            ),
          ),

          // ── Main Content ──
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            sliver: SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),

                      // Hero / Title Section
                      _buildHeroSection(isMobile, isTablet, projectContent),

                      const SizedBox(height: 56),

                      // Phone Mockups – Automatic Horizontal Scroll
                      _buildMockupsSection(isMobile, isTablet, width),

                      const SizedBox(height: 60),

                      // Overview Card
                      _buildOverviewCard(isMobile, projectContent),

                      const SizedBox(height: 52),

                      // Features
                      _buildFeaturesSection(isMobile, isTablet, projectContent),

                      if (projectContent['targetUsers'].isNotEmpty) ...[
                        const SizedBox(height: 52),
                        // Target Users Section
                        _buildTargetUsersSection(isMobile, projectContent),
                      ],

                      const SizedBox(height: 52),

                      // Tech Stack
                      _buildTechStackSection(isMobile),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(
    bool isMobile,
    bool isTablet,
    Map<String, dynamic> content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category pill with availability badge
        Row(
          children: [
            _CategoryPill(category: widget.project.category),
            if (content['availability'].isNotEmpty) ...[
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.accent.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 14, color: AppColors.accent),
                    const SizedBox(width: 6),
                    Text(
                      content['availability'],
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 24),

        // Gradient Title
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColors.textPrimary, AppColors.accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            widget.project.title,
            style: TextStyle(
              fontSize: isMobile
                  ? 34
                  : isTablet
                  ? 44
                  : 54,
              fontWeight: FontWeight.w900,
              height: 1.05,
              letterSpacing: -1,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Description
        Text(
          widget.project.description,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? 14 : 16,
            height: 1.6,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }

  Widget _buildMockupsSection(
    bool isMobile,
    bool isTablet,
    double screenWidth,
  ) {
    final images = [...widget.project.uiImages];

    final mockupWidth = isMobile
        ? 280.0
        : isTablet
        ? 320.0
        : 360.0;
    final mockupHeight = (mockupWidth * 2.05).clamp(520.0, 780.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accent.withOpacity(0.2),
                        AppColors.accent.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.phone_iphone,
                    color: AppColors.accent,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  'App Screens',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            // Auto-scroll indicator
            if (!_userInteracted)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      size: 14,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Auto-scrolling',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 28),

        // Mockups Container
        SizedBox(
          height: mockupHeight + 70,
          child: Stack(
            children: [
              // Subtle radial glow
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.0,
                      colors: [
                        AppColors.accent.withOpacity(0.1),
                        AppColors.background.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ),

              // Horizontal scroll
              ListView.builder(
                controller: _mockupScrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 0 : 32,
                  vertical: 32,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: isMobile ? 24 : 40),
                    child: _ModernPhoneMockup(
                      imageUrl: images[index],
                      index: index + 1,
                      width: mockupWidth,
                      height: mockupHeight,
                      isMobile: isMobile,
                    ),
                  );
                },
              ),

              // Scroll hints (desktop/tablet)
              if (!isMobile && images.length > 2) ...[
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: _ScrollHintButton(
                    icon: Icons.chevron_left,
                    onTap: () {
                      setState(() {
                        _userInteracted = true;
                      });
                      _mockupScrollController.animateTo(
                        _mockupScrollController.offset - 340,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutCubic,
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: _ScrollHintButton(
                    icon: Icons.chevron_right,
                    onTap: () {
                      setState(() {
                        _userInteracted = true;
                      });
                      _mockupScrollController.animateTo(
                        _mockupScrollController.offset + 340,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutCubic,
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(bool isMobile, Map<String, dynamic> content) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.35),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.accent.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: AppColors.accent,
                size: 24,
              ),
              const SizedBox(width: 14),
              Text(
                'Project Overview',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            content['fullDescription'],
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: isMobile ? 14 : 16,
              height: 1.7,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(
    bool isMobile,
    bool isTablet,
    Map<String, dynamic> content,
  ) {
    final features = content['features'] as List<_FeatureData>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          icon: Icons.star_outline,
          title: 'Key Features',
          isMobile: isMobile,
        ),
        const SizedBox(height: 28),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile
                ? 1
                : isTablet
                ? 2
                : 4,
            childAspectRatio: isMobile ? 3.2 : 2.6,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: features.length,
          itemBuilder: (context, i) =>
              _FeatureCard(feature: features[i], isMobile: isMobile),
        ),
      ],
    );
  }

  Widget _buildTargetUsersSection(bool isMobile, Map<String, dynamic> content) {
    final users = content['targetUsers'] as List<String>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          icon: Icons.people_outline,
          title: 'Who Can Use',
          isMobile: isMobile,
        ),
        const SizedBox(height: 28),
        Container(
          padding: EdgeInsets.all(isMobile ? 20 : 28),
          decoration: BoxDecoration(
            color: AppColors.cardBackground.withOpacity(0.35),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accent.withOpacity(0.12)),
          ),
          child: Column(
            children: users.asMap().entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: entry.key < users.length - 1 ? 16 : 0,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.accent.withOpacity(0.2),
                            AppColors.accent.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.check_circle_outline,
                        color: AppColors.accent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: isMobile ? 14 : 15,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTechStackSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          icon: Icons.code,
          title: 'Technology Stack',
          isMobile: isMobile,
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: widget.project.technologies.map((tech) {
            return _TechChip(tech: tech, isMobile: isMobile);
          }).toList(),
        ),
      ],
    );
  }
}

// ── Reusable Widgets ────────────────────────────────────────────────────────

class _GlassBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.45),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accent.withOpacity(0.15)),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        color: AppColors.accent,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  final String category;

  const _CategoryPill({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.22),
            AppColors.accent.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.accent.withOpacity(0.28)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            category.toUpperCase(),
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernPhoneMockup extends StatelessWidget {
  final String imageUrl;
  final int index;
  final double width;
  final double height;
  final bool isMobile;

  const _ModernPhoneMockup({
    required this.imageUrl,
    required this.index,
    required this.width,
    required this.height,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.93 + 0.07 * value,
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isMobile ? 34 : 44),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E1E1E), Color(0xFF121212)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.45),
              blurRadius: 50,
              offset: const Offset(0, 24),
            ),
            BoxShadow(
              color: AppColors.accent.withOpacity(0.12),
              blurRadius: 70,
              spreadRadius: 8,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Screen
            Padding(
              padding: EdgeInsets.all(isMobile ? 9 : 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isMobile ? 27 : 35),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.cardBackground,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 52,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Dynamic Island / Notch
            Positioned(
              top: isMobile ? 12 : 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: isMobile ? 100 : 130,
                  height: isMobile ? 26 : 32,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(36),
                  ),
                ),
              ),
            ),

            // Screen number badge
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent,
                      AppColors.accent.withOpacity(0.75),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScrollHintButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ScrollHintButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.cardBackground.withOpacity(0.55),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accent.withOpacity(0.2)),
          ),
          child: Icon(icon, color: AppColors.accent, size: 24),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isMobile;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.accent.withOpacity(0.22),
                AppColors.accent.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.accent, size: 24),
        ),
        const SizedBox(width: 14),
        Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  _FeatureData(this.icon, this.title, this.description, this.color);
}

class _FeatureCard extends StatelessWidget {
  final _FeatureData feature;
  final bool isMobile;

  const _FeatureCard({required this.feature, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 18 : 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: feature.color.withOpacity(0.22)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  feature.color.withOpacity(0.3),
                  feature.color.withOpacity(0.12),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(feature.icon, color: feature.color, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  feature.title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 15 : 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  feature.description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: isMobile ? 12 : 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String tech;
  final bool isMobile;

  const _TechChip({required this.tech, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.2),
            AppColors.accent.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Text(
        tech,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: isMobile ? 13 : 14,
        ),
      ),
    );
  }
}
