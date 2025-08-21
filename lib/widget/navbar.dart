import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 70,
      borderRadius: 20,
      blur: 20,
      alignment: Alignment.bottomCenter,
      border: 0,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF1E1E1E).withOpacity(0.7),
          const Color(0xFF1E1E1E).withOpacity(0.3),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blueAccent.withOpacity(0.4),
          Colors.cyanAccent.withOpacity(0.2),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: const Color(0xFFB4B4B4),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          _buildNavItem(Icons.person_outline, 'About', 0),
          _buildNavItem(Icons.description_outlined, 'Resume', 1),
          _buildNavItem(Icons.work_outline, 'Portfolio', 2),
          _buildNavItem(Icons.article_outlined, 'Blog', 3),
          _buildNavItem(Icons.mail_outline, 'Contact', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    String label,
    int index,
  ) {
    final bool isHovered = hoveredIndex == index;
    final bool isSelected = widget.currentIndex == index;

    return BottomNavigationBarItem(
      icon: MouseRegion(
        onEnter: (_) => setState(() => hoveredIndex = index),
        onExit: (_) => setState(() => hoveredIndex = null),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isHovered
                ? Colors.cyanAccent.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Stack(
            children: [
              Icon(
                icon,
                size: isHovered || isSelected ? 26 : 24,
                color: isHovered
                    ? Colors.cyanAccent
                    : (isSelected
                          ? Colors.cyanAccent
                          : const Color(0xFFB4B4B4)),
              ),
              if (isSelected)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.cyanAccent,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      label: label,
    );
  }
}
