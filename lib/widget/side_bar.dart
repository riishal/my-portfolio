import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:url_launcher/url_launcher.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  // Hover states for contact items
  final List<bool> _contactHoverStates = List.generate(4, (_) => false);
  // Hover states for social icons
  final List<bool> _socialIconHoverStates = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: 280,
      height: double.infinity,
      borderRadius: 20,
      blur: 25,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF121212).withOpacity(0.9),
          const Color(0xFF1E1E1E).withOpacity(0.8),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.05),
          Colors.white.withOpacity(0.02),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar without pulse animation
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF6DD5ED), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6DD5ED).withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xFF121212),
                  backgroundImage: const AssetImage(
                    'assets/images/myprofile.png',
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Name
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  'Rishal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              // Title
              BounceInDown(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: const Text(
                    'Flutter Developer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Contact list with hover effect
              Column(
                children: [
                  _buildAnimatedContactItem(
                    index: 0,
                    delay: 100,
                    icon: Icons.email,
                    label: 'Email',
                    value: 'rishal@gmail.com',
                    onTap: () => _launchUrl('mailto:rishal@gmail.com'),
                  ),
                  _buildAnimatedContactItem(
                    index: 1,
                    delay: 200,
                    icon: Icons.phone,
                    label: 'Phone',
                    value: '7592895143',
                    onTap: () => _launchUrl('tel:+12133522795'),
                  ),
                  _buildAnimatedContactItem(
                    index: 2,
                    delay: 300,
                    icon: Icons.cake,
                    label: 'Birthday',
                    value: 'Jul 6, 2004',
                  ),
                  _buildAnimatedContactItem(
                    index: 3,
                    delay: 400,
                    icon: Icons.location_pin,
                    label: 'Location',
                    value: 'Areekode, Malappuram, India',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Social icons
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(0, Icons.facebook, () {}),
                    _buildSocialIcon(1, Icons.code, () {}),
                    _buildSocialIcon(2, Icons.linked_camera, () {}),
                    _buildSocialIcon(3, Icons.web, () {}),
                    // _buildSocialIcon(4, Icons.share, () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedContactItem({
    required int index,
    required int delay,
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return FadeInLeft(
      delay: Duration(milliseconds: delay),
      duration: const Duration(milliseconds: 600),
      child: MouseRegion(
        onEnter: (_) => setState(() => _contactHoverStates[index] = true),
        onExit: (_) => setState(() => _contactHoverStates[index] = false),
        cursor: onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _contactHoverStates[index]
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: _contactHoverStates[index]
                    ? const Color(0xFF6DD5ED)
                    : Colors.white.withOpacity(0.05),
              ),
              boxShadow: [
                BoxShadow(
                  color: _contactHoverStates[index]
                      ? const Color(0xFF6DD5ED).withOpacity(0.3)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2193B0), Color(0xFF6DD5ED)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 20, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Color(0xFFB4B4B4),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        value,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: onTap != null
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  const Icon(
                    Icons.arrow_outward,
                    size: 16,
                    color: Color(0xFF6DD5ED),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(int index, IconData icon, VoidCallback onTap) {
    return MouseRegion(
      onEnter: (_) => setState(() => _socialIconHoverStates[index] = true),
      onExit: (_) => setState(() => _socialIconHoverStates[index] = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: _socialIconHoverStates[index] ? 46 : 40,
        height: _socialIconHoverStates[index] ? 46 : 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: _socialIconHoverStates[index]
                ? [const Color(0xFF2193B0), const Color(0xFF6DD5ED)]
                : [const Color(0xFF2C2C2C), const Color(0xFF1A1A1A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: _socialIconHoverStates[index]
                  ? const Color(0xFF6DD5ED).withOpacity(0.4)
                  : Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: _socialIconHoverStates[index]
                ? Colors.white
                : const Color(0xFF6DD5ED),
            size: _socialIconHoverStates[index] ? 22 : 20,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
