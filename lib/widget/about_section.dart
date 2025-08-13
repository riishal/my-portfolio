import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'service_card.dart';
import 'testimonial_card.dart';
import 'client_logo.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      height: MediaQuery.of(context).size.height * 1.8,
      width: double.infinity,
      borderRadius: 20,
      blur: 20,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF0F2027).withOpacity(0.6),
          const Color(0xFF203A43).withOpacity(0.5),
          const Color(0xFF2C5364).withOpacity(0.4),
        ],
        stops: const [0.1, 0.5, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blueAccent.withOpacity(0.5),
          Colors.cyan.withOpacity(0.2),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with animated underline
              FadeInDown(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Me',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 4,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Colors.blueAccent, Colors.cyan],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // About text
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: Text(
                  "Hi, I'm Rishal — a passionate Flutter Developer from Kerala, India, "
                  "with over 2 years of experience building beautiful, high-performance mobile apps. "
                  "I specialize in creating feature-rich, user-friendly applications for Android & iOS, "
                  "focusing on clean architecture, responsive UI, and smooth animations.\n\n"
                  "From pixel-perfect designs to API integration and state management, "
                  "I ensure every project is delivered with quality and performance in mind. "
                  "My mission is to turn your ideas into reality through creative coding and attention to detail.",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFB4B4B4),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    height: 1.8,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Services section
              FadeInLeft(
                child: Text(
                  "What I Do",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Service cards with hover effect
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _HoverWrapper(
                    child: const ServiceCard(
                      icon: Icons.phone_android,
                      title: 'Flutter App Development',
                      description:
                          'Cross-platform apps with native performance',
                      color: Colors.blueAccent,
                    ),
                  ),
                  _HoverWrapper(
                    child: const ServiceCard(
                      icon: Icons.design_services,
                      title: 'UI/UX Design',
                      description:
                          'Beautiful and user-friendly interface designs',
                      color: Colors.purpleAccent,
                    ),
                  ),
                  _HoverWrapper(
                    child: const ServiceCard(
                      icon: Icons.api,
                      title: 'API Integration',
                      description: 'Seamless backend connectivity',
                      color: Colors.tealAccent,
                    ),
                  ),
                  _HoverWrapper(
                    child: const ServiceCard(
                      icon: Icons.bug_report,
                      title: 'App Maintenance',
                      description: 'Bug fixing and performance improvements',
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Testimonials section
              FadeInRight(
                child: Text(
                  "Testimonials",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 280,
                child: PageView(
                  children: const [
                    TestimonialCard(
                      name: 'Client A',
                      role: 'Business Owner',
                      comment:
                          'Rishal delivered our app ahead of schedule with top-notch quality. Highly recommended!',
                    ),
                    TestimonialCard(
                      name: 'Client B',
                      role: 'Startup Founder',
                      comment:
                          'Great communication and excellent Flutter expertise. Will work again.',
                    ),
                    TestimonialCard(
                      name: 'Client C',
                      role: 'Project Manager',
                      comment:
                          'A professional developer who goes above and beyond to meet expectations.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Clients section
              FadeInLeft(
                child: Text(
                  "Clients",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Client logos with hover effect
              Wrap(
                spacing: 30,
                runSpacing: 20,
                children: const [
                  _HoverWrapper(
                    child: ClientLogo(
                      icon: Icons.flutter_dash,
                      iconColor: Colors.cyanAccent,
                    ),
                  ),
                  _HoverWrapper(
                    child: ClientLogo(
                      icon: Icons.code,
                      iconColor: Colors.blueAccent,
                    ),
                  ),
                  _HoverWrapper(
                    child: ClientLogo(
                      icon: Icons.web,
                      iconColor: Colors.purpleAccent,
                    ),
                  ),
                  _HoverWrapper(
                    child: ClientLogo(
                      icon: Icons.mobile_friendly,
                      iconColor: Colors.greenAccent,
                    ),
                  ),
                  _HoverWrapper(
                    child: ClientLogo(
                      icon: Icons.business,
                      iconColor: Colors.orangeAccent,
                    ),
                  ),
                  _HoverWrapper(
                    child: ClientLogo(
                      icon: Icons.computer,
                      iconColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Hover effect wrapper
class _HoverWrapper extends StatefulWidget {
  final Widget child;
  const _HoverWrapper({required this.child});

  @override
  State<_HoverWrapper> createState() => _HoverWrapperState();
}

class _HoverWrapperState extends State<_HoverWrapper> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
