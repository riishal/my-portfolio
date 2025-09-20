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
                ModernContactSection(
                  contactKey: _contactKey,
                  isMobile: isMobile,
                ),
                ModernFooterSection(),
              ],
            ),
          ),
          if (isMobile)
            Positioned(
              top: 16,
              left: 16,
              child: Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: AppColors.accent, size: 28),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
          if (!isMobile)
            Positioned(
              top: 16,
              right: 16,
              child: Row(
                children: [
                  ..._buildNavItems(),
                  const SizedBox(width: 16),
                  _buildModernResumeButton(),
                  const SizedBox(width: 16),
                  _buildModernThemeButton(),
                ],
              ),
            ),
        ],
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
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
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.8),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.download, color: Colors.white, size: 16),
                      const SizedBox(width: 6),
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
    return IconButton(
      icon: Icon(
        AppColors.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: AppColors.accent,
        size: 22,
      ),
      onPressed: widget.onThemeToggle,
    );
  }

  Widget _buildModernDrawer() {
    return Drawer(
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Icon(Icons.person, color: AppColors.accent, size: 40),
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
            padding: const EdgeInsets.all(20),
            child: _buildModernResumeButton(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
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
    );
  }

  Widget _buildModernDrawerItem(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    bool isSelected = _selectedNavItem == title;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
