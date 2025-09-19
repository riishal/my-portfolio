import 'package:flutter/material.dart';
import 'package:rishal/screens/hero_page.dart';
import 'package:rishal/screens/service_section.dart';
import 'package:rishal/utils/app_colors.dart';
import 'dart:math' as math;

import 'about_section.dart';
import 'portfolio_section.dart';
import 'contact_section.dart';
import 'footer_section.dart';

class PortfolioHomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;

  PortfolioHomePage({required this.onThemeToggle});

  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late AnimationController _appBarController;
  late Animation<double> _appBarAnimation;

  bool _showMobileMenu = false;
  bool _isScrolled = false;
  String _selectedNavItem = 'HOME';

  @override
  void initState() {
    super.initState();

    _appBarController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _appBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _appBarController, curve: Curves.easeInOut),
    );

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _appBarController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && !_isScrolled) {
      setState(() => _isScrolled = true);
      _appBarController.forward();
    } else if (_scrollController.offset <= 100 && _isScrolled) {
      setState(() => _isScrolled = false);
      _appBarController.reverse();
    }
  }

  void _scrollToSection(GlobalKey key, String navItem) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
    setState(() {
      _showMobileMenu = false;
      _selectedNavItem = navItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: _buildModernAppBar(isMobile),
      drawer: isMobile ? _buildModernDrawer() : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(homeKey: _homeKey, isMobile: isMobile),
            AboutSection(aboutKey: _aboutKey, isMobile: isMobile),
            ModernServicesSection(
              servicesKey: _servicesKey,
              isMobile: isMobile,
            ),
            ModernPortfolioSection(
              portfolioKey: _portfolioKey,
              isMobile: isMobile,
            ),
            ModernContactSection(contactKey: _contactKey, isMobile: isMobile),
            ModernFooterSection(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar(bool isMobile) {
    return AppBar(
      backgroundColor: _isScrolled
          ? AppColors.cardBackground.withOpacity(0.95)
          : Colors.transparent,
      elevation: _isScrolled ? 8 : 0,
      flexibleSpace: _isScrolled
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.cardBackground.withOpacity(0.95),
                    AppColors.background.withOpacity(0.95),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            )
          : null,
      title: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColors.accent, AppColors.accent.withOpacity(0.7)],
          ).createShader(bounds),
          child: Text(
            '<Rishal/>',
            style: TextStyle(
              color: Colors.white,
              fontSize: _isScrolled ? 20 : 24,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      actions: isMobile
          ? [_buildModernThemeButton(), SizedBox(width: 8)]
          : [
              ..._buildNavItems(),
              SizedBox(width: 16),
              _buildModernResumeButton(),
              SizedBox(width: 16),
              _buildModernThemeButton(),
              SizedBox(width: 16),
            ],
      iconTheme: IconThemeData(color: AppColors.accent),
    );
  }

  List<Widget> _buildNavItems() {
    final items = [
      ('HOME', _homeKey),
      ('ABOUT', _aboutKey),
      ('SERVICES', _servicesKey),
      ('PROJECTS', _portfolioKey),
      ('CONTACT', _contactKey),
    ];

    return items
        .map(
          (item) => _buildModernNavItem(
            item.$1,
            () => _scrollToSection(item.$2, item.$1),
          ),
        )
        .toList();
  }

  Widget _buildModernNavItem(String title, VoidCallback onTap) {
    bool isSelected = _selectedNavItem == title;
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: onTap,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected || isHovered
                      ? AppColors.accent.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? Border.all(color: AppColors.accent.withOpacity(0.3))
                      : null,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected || isHovered
                        ? AppColors.accent
                        : AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernResumeButton() {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
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
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? AppColors.accent.withOpacity(0.4)
                      : AppColors.accent.withOpacity(0.2),
                  blurRadius: isHovered ? 15 : 8,
                  offset: Offset(0, isHovered ? 6 : 3),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.download, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'RESUME',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
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

  Widget _buildModernThemeButton() {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: isHovered
                  ? AppColors.accent.withOpacity(0.1)
                  : AppColors.cardBackground.withOpacity(0.8),
              shape: BoxShape.circle,
              border: Border.all(
                color: isHovered
                    ? AppColors.accent.withOpacity(0.5)
                    : AppColors.accent.withOpacity(0.2),
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ]
                  : [],
            ),
            transform: Matrix4.identity()
              ..scale(isHovered ? 1.1 : 1.0)
              ..rotateZ(isHovered ? 0.1 : 0.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onThemeToggle,
                borderRadius: BorderRadius.circular(22.5),
                child: Icon(
                  AppColors.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: AppColors.accent,
                  size: 22,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernDrawer() {
    return Drawer(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.background,
              AppColors.cardBackground.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 120,
              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accent,
                          AppColors.accent.withOpacity(0.7),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          AppColors.accent,
                          AppColors.accent.withOpacity(0.7),
                        ],
                      ).createShader(bounds),
                      child: Text(
                        '<Rishal/>',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildModernDrawerItem('HOME', Icons.home, () {
              _scrollToSection(_homeKey, 'HOME');
              Navigator.pop(context);
            }),
            _buildModernDrawerItem('ABOUT', Icons.person, () {
              _scrollToSection(_aboutKey, 'ABOUT');
              Navigator.pop(context);
            }),
            _buildModernDrawerItem('SERVICES', Icons.work, () {
              _scrollToSection(_servicesKey, 'SERVICES');
              Navigator.pop(context);
            }),
            _buildModernDrawerItem('PROJECTS', Icons.code, () {
              _scrollToSection(_portfolioKey, 'PROJECTS');
              Navigator.pop(context);
            }),
            _buildModernDrawerItem('CONTACT', Icons.mail, () {
              _scrollToSection(_contactKey, 'CONTACT');
              Navigator.pop(context);
            }),
            Padding(
              padding: EdgeInsets.all(20),
              child: _buildModernResumeButton(),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(
                  AppColors.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: AppColors.accent,
                ),
                title: Text(
                  AppColors.isDarkMode ? 'Light Mode' : 'Dark Mode',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: widget.onThemeToggle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernDrawerItem(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    bool isSelected = _selectedNavItem == title;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.accent.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: AppColors.accent.withOpacity(0.3))
            : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.accent : AppColors.textSecondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.accent : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        trailing: isSelected
            ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
