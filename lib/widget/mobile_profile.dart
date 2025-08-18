import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';

class ModernProfileHeader extends StatefulWidget {
  const ModernProfileHeader({super.key});

  @override
  State<ModernProfileHeader> createState() => _ModernProfileHeaderState();
}

class _ModernProfileHeaderState extends State<ModernProfileHeader>
    with SingleTickerProviderStateMixin {
  bool _showSocial = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSocial() {
    setState(() {
      _showSocial = !_showSocial;
      if (_showSocial) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [Colors.black87, Colors.grey[900]!],
      //   ),
      // ),
      child: Column(
        children: [
          SizedBox(height: 10),
          // Profile Avatar with Glassmorphism Effect
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.tealAccent.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ScaleTransition(
              scale: Tween(begin: 1.0, end: 0.95).animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeOut),
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xFF121212),
                backgroundImage: AssetImage('assets/images/myprofile.png'),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Name and Title
          Column(
            children: [
              FadeIn(
                duration: const Duration(milliseconds: 600),
                child: const Text(
                  'Rishal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SlideInUp(
                duration: const Duration(milliseconds: 700),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: const Text(
                    'Flutter Developer',
                    style: TextStyle(
                      color: Color(0xFF92FE9D),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Contact Info - Modern Grid
          GridView.count(
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 3.5,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              _buildModernContactItem(
                icon: Icons.email_outlined,
                label: 'rishal@gmail.com',
                onTap: () => _launchUrl('mailto:rishal@gmail.com'),
              ),
              _buildModernContactItem(
                icon: Icons.phone_iphone_rounded,
                label: '+91 7592895143',
                onTap: () => _launchUrl('tel:+917592895143'),
              ),
              _buildModernContactItem(
                icon: Icons.cake_outlined,
                label: 'July 6, 2004',
              ),
              _buildModernContactItem(
                icon: Icons.location_pin,
                label: 'Areekode, India',
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Social Toggle Button
          ElasticIn(
            duration: const Duration(milliseconds: 900),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.tealAccent.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _toggleSocial,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _showSocial ? Icons.close : Icons.connect_without_contact,
                      color: Colors.black,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _showSocial ? 'CLOSE CONNECTIONS' : 'SHOW CONNECTIONS',
                      style: const TextStyle(
                        color: Colors.black,
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

          const SizedBox(height: 25),

          // Social Icons - Modern Reveal
          if (_showSocial)
            SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
              ),
              axis: Axis.vertical,
              child: FadeTransition(
                opacity: _controller,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildModernSocialIcon(0, Icons.facebook, 'Facebook'),
                      _buildModernSocialIcon(1, Icons.code, 'GitHub'),
                      _buildModernSocialIcon(
                        2,
                        Icons.linked_camera,
                        'Instagram',
                      ),
                      _buildModernSocialIcon(3, Icons.web, 'Website'),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModernContactItem({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return FadeIn(
      delay: const Duration(milliseconds: 300),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.25),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: const Color(0xFF00C9FF)),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      decoration: onTap != null
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernSocialIcon(int index, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BounceInDown(
          duration: const Duration(milliseconds: 700),
          delay: Duration(milliseconds: 150 * index),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00C9FF).withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.black, size: 24),
          ),
        ),
        const SizedBox(height: 8),
        FadeIn(
          delay: Duration(milliseconds: 150 * index + 300),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
