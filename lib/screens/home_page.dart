import 'package:flutter/material.dart';
import 'package:rishal/screens/footer_section.dart';
import 'package:rishal/screens/hero_page.dart';
import 'package:rishal/screens/service_section.dart';
import 'package:rishal/utils/app_colors.dart';
import 'about_section.dart';
import 'portfolio_section.dart';
import 'contact_section.dart';

class PortfolioHomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const PortfolioHomePage({required this.onThemeToggle, super.key});

  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  bool _showMobileMenu = false;
  String _selectedNavItem = 'HOME';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key, String navItem) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
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
      drawer: isMobile ? _buildModernDrawer() : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  homeKey: _homeKey,
                  isMobile: isMobile,
                  onViewWork: () => _scrollToSection(_portfolioKey, 'PROJECTS'),
                  onGetInTouch: () => _scrollToSection(_contactKey, 'CONTACT'),
                ),
                AboutSection(aboutKey: _aboutKey, isMobile: isMobile),
                ModernServicesSection(
                  servicesKey: _servicesKey,
                  isMobile: isMobile,
                ),
                ModernPortfolioSection(
                  portfolioKey: _portfolioKey,
                  isMobile: isMobile,
                ),
                ModernContactSection(
                  contactKey: _contactKey,
                  isMobile: isMobile,
                ),
                ModernFooterSection(),
              ],
            ),
          ),
          // Mobile Navigation
          if (isMobile)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.05),
                  //     blurRadius: 10,
                  //     offset: const Offset(0, 2),
                  //   ),
                  // ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menu Button
                    Builder(
                      builder: (context) => _buildModernIconButton(
                        icon: Icons.menu_rounded,
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    // Theme Toggle Button
                    _buildModernIconButton(
                      icon: AppColors.isDarkMode
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      onPressed: widget.onThemeToggle,
                    ),
                  ],
                ),
              ),
            ),
          // Desktop Navigation
          if (!isMobile)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(32, 24, 32, 16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.05),
                  //     blurRadius: 10,
                  //     offset: const Offset(0, 2),
                  //   ),
                  // ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo/Brand
                    SizedBox(),
                    // Navigation Items
                    Row(
                      children: [
                        ..._buildNavItems(),
                        const SizedBox(width: 24),
                        _buildModernIconButton(
                          icon: AppColors.isDarkMode
                              ? Icons.light_mode_rounded
                              : Icons.dark_mode_rounded,
                          onPressed: widget.onThemeToggle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModernIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isHovered
                  ? AppColors.accent.withOpacity(0.1)
                  : AppColors.cardBackground.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1,
                color: isHovered
                    ? AppColors.accent.withOpacity(0.3)
                    : AppColors.accent,
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(icon, color: AppColors.accent, size: 22),
                ),
              ),
            ),
          ),
        );
      },
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
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected || isHovered
                          ? AppColors.accent.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
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
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
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

  Widget _buildModernDrawer() {
    return Drawer(
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 120,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  Center(
                    child: Icon(
                      Icons.person_rounded,
                      color: AppColors.accent,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'MENU',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _buildModernDrawerItem('HOME', Icons.home_rounded, () {
              _scrollToSection(_homeKey, 'HOME');
              Navigator.pop(context);
            }),
            _buildModernDrawerItem('ABOUT', Icons.person_rounded, () {
              _scrollToSection(_aboutKey, 'ABOUT');
              Navigator.pop(context);
            }),
            _buildModernDrawerItem('SERVICES', Icons.work_rounded, () {
              _scrollToSection(_servicesKey, 'SERVICES');
              Navigator.pop(context);
            }),
            _buildModernDrawerItem('PROJECTS', Icons.code_rounded, () {
              _scrollToSection(_portfolioKey, 'PROJECTS');
              Navigator.pop(context);
            }),
            _buildModernDrawerItem('CONTACT', Icons.mail_rounded, () {
              _scrollToSection(_contactKey, 'CONTACT');
              Navigator.pop(context);
            }),
            const SizedBox(height: 24),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         AppColors.accent.withOpacity(0.1),
            //         AppColors.accent.withOpacity(0.05),
            //       ],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //     ),
            //     borderRadius: BorderRadius.circular(20),
            //     border: Border.all(color: AppColors.accent.withOpacity(0.2)),
            //   ),
            //   child: ListTile(
            //     leading: Container(
            //       padding: const EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //         color: AppColors.accent.withOpacity(0.2),
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       child: Icon(
            //         AppColors.isDarkMode
            //             ? Icons.light_mode_rounded
            //             : Icons.dark_mode_rounded,
            //         color: AppColors.accent,
            //         size: 20,
            //       ),
            //     ),
            //     title: Text(
            //       AppColors.isDarkMode ? 'Light Mode' : 'Dark Mode',
            //       style: TextStyle(
            //         color: AppColors.textPrimary,
            //         fontWeight: FontWeight.w600,
            //         fontSize: 16,
            //       ),
            //     ),
            //     onTap: widget.onThemeToggle,
            //   ),
            // ),
            const SizedBox(height: 32),
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.accent.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? Border.all(color: AppColors.accent.withOpacity(0.3))
            : null,
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.accent.withOpacity(0.2)
                : AppColors.cardBackground.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isSelected ? AppColors.accent : AppColors.textSecondary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.accent : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
        trailing: isSelected
            ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
