import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      borderRadius: 20,
      blur: 20,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF1E1E1E).withOpacity(0.6),
          const Color(0xFF1E1E1E).withOpacity(0.3),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF3D3D3D).withOpacity(0.5),
          const Color(0x003D3D3D),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Me',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 4,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD166), Color(0xFFF4A261)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (MediaQuery.of(context).size.width > 900)
                  Expanded(
                    child: FadeInLeft(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let's talk about everything!",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Feel free to get in touch with me. I am always open to discussing new projects, creative ideas or opportunities to be part of your vision.",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFB4B4B4),
                              fontSize: 16,
                              height: 1.8,
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildContactInfo(
                            icon: Icons.mail,
                            title: 'Email',
                            value: 'hello@example.com',
                            onTap: () => _launchUrl('mailto:hello@example.com'),
                          ),
                          _buildContactInfo(
                            icon: Icons.phone,
                            title: 'Phone',
                            value: '+1 (123) 456-7890',
                            onTap: () => _launchUrl('tel:+11234567890'),
                          ),
                          _buildContactInfo(
                            icon: Icons.location_pin,
                            title: 'Location',
                            value: 'San Francisco, CA',
                          ),
                          const SizedBox(height: 40),
                          Text(
                            'Follow Me',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              _buildSocialIcon(Icons.facebook, () {}),
                              _buildSocialIcon(Icons.abc, () {}),
                              _buildSocialIcon(Icons.ac_unit_rounded, () {}),
                              _buildSocialIcon(
                                Icons.access_time_filled_rounded,
                                () {},
                              ),
                              _buildSocialIcon(Icons.wysiwyg, () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: FadeInRight(
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF1E1E1E).withOpacity(0.8),
                            const Color(0xFF1E1E1E).withOpacity(0.4),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          const ContactInputField(
                            hint: 'Your Name',
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 20),
                          const ContactInputField(
                            hint: 'Your Email',
                            icon: Icons.mail,
                          ),
                          const SizedBox(height: 20),
                          const ContactInputField(
                            hint: 'Subject',
                            icon: Icons.subject,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 150,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFF2D2D2D),
                            ),
                            child: const TextField(
                              maxLines: null,
                              expands: true,
                              decoration: InputDecoration(
                                hintText: 'Your Message',
                                hintStyle: TextStyle(color: Color(0xFFB4B4B4)),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 30),
                          _HoverButton(text: "Send Message", onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return _HoverScale(
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD166), Color(0xFFF4A261)],
                ),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: const Color(0xFFB4B4B4),
                        fontSize: 16,
                        decoration: onTap != null
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return _HoverScale(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          margin: const EdgeInsets.only(right: 15),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF2C2C2C), Color(0xFF1A1A1A)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, color: const Color(0xFFFFD166), size: 20),
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

class ContactInputField extends StatelessWidget {
  final String hint;
  final IconData icon;

  const ContactInputField({super.key, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return _HoverScale(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF2D2D2D),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFFFD166)),
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(color: Color(0xFFB4B4B4)),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HoverScale extends StatefulWidget {
  final Widget child;
  const _HoverScale({required this.child});

  @override
  State<_HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<_HoverScale> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}

class _HoverButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const _HoverButton({required this.text, required this.onPressed});

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: _hovering
                ? [const Color(0xFFF4A261), const Color(0xFFFFD166)]
                : [const Color(0xFFFFD166), const Color(0xFFF4A261)],
          ),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.6),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
