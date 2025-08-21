import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({super.key});

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  int? hoveredIndex;

  final List<Map<String, dynamic>> projects = [
    {
      'title': 'Flutter E-commerce App',
      'description': 'A complete shopping app with payment integration',
      'accentColor': const Color(0xFF64B5F6),
      'technologies': ['Flutter', 'Firebase', 'Stripe'],
    },
    {
      'title': 'Flutter Finance Dashboard',
      'description': 'Financial analytics and visualization platform',
      'accentColor': const Color(0xFFBA68C8),
      'technologies': ['Flutter', 'D3.js', 'Node.js'],
    },
    {
      'title': 'Flutter Fitness Tracker',
      'description': 'Health monitoring with wearable integration',
      'accentColor': const Color(0xFF4DB6AC),
      'technologies': ['Flutter', 'BLoC', 'Health API'],
    },
    {
      'title': 'Flutter Travel Blog UI',
      'description': 'Beautiful travel experience sharing platform',
      'accentColor': const Color(0xFFFF8A65),
      'technologies': ['Flutter', 'Google Maps', 'Firestore'],
    },
    {
      'title': 'Flutter Social Analytics',
      'description': 'Social media metrics and insights dashboard',
      'accentColor': const Color(0xFF9575CD),
      'technologies': ['Flutter', 'Twitter API', 'MongoDB'],
    },
    {
      'title': 'Flutter Restaurant Booking',
      'description': 'Table reservation and menu browsing app',
      'accentColor': const Color(0xFF4FC3F7),
      'technologies': ['Flutter', 'Google Places', 'Firebase'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 800),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.9,
        borderRadius: 20,
        blur: 20,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF121212).withOpacity(0.8),
            const Color(0xFF1E1E1E).withOpacity(0.5),
          ],
          stops: const [0.1, 1],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF3D3D3D).withOpacity(0.8),
            const Color(0x003D3D3D),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElasticInLeft(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Projects',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    BounceInRight(
                      duration: const Duration(milliseconds: 1000),
                      child: Container(
                        height: 4,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFD166), Color(0xFFF4A261)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFD166).withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 900
                        ? 3
                        : constraints.maxWidth > 600
                        ? 2
                        : 1;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: projects.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.2,
                      ),
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        final isHovered = hoveredIndex == index;
                        return FadeInLeft(
                          delay: Duration(milliseconds: 200 + (index * 100)),
                          child: MouseRegion(
                            onEnter: (_) =>
                                setState(() => hoveredIndex = index),
                            onExit: (_) => setState(() => hoveredIndex = null),
                            child: AnimatedScale(
                              scale: isHovered ? 1.03 : 1.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutBack,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFF1E1E1E).withOpacity(0.9),
                                      const Color(0xFF1E1E1E).withOpacity(0.7),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isHovered
                                          ? project['accentColor'].withOpacity(
                                              0.4,
                                            )
                                          : Colors.black.withOpacity(0.5),
                                      blurRadius: isHovered ? 20 : 10,
                                      offset: Offset(0, isHovered ? 8 : 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              project['accentColor']
                                                  .withOpacity(0.2),
                                              project['accentColor']
                                                  .withOpacity(0.1),
                                            ],
                                          ),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.work_outline,
                                            size: 60,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.black.withOpacity(0.8),
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                project['title'],
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.4,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                project['description'],
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Wrap(
                                                spacing: 8,
                                                runSpacing: 8,
                                                children:
                                                    (project['technologies']
                                                            as List<String>)
                                                        .map(
                                                          (tech) => Container(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color: project['accentColor']
                                                                  .withOpacity(
                                                                    0.1,
                                                                  ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10,
                                                                  ),
                                                              border: Border.all(
                                                                color: project['accentColor']
                                                                    .withOpacity(
                                                                      0.3,
                                                                    ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              tech,
                                                              style: TextStyle(
                                                                color:
                                                                    project['accentColor'],
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                              ),
                                              const SizedBox(height: 20),
                                              AnimatedContainer(
                                                duration: const Duration(
                                                  milliseconds: 300,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 8,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: isHovered
                                                      ? project['accentColor']
                                                      : const Color(0xFF2D2D2D),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: isHovered
                                                      ? [
                                                          BoxShadow(
                                                            color:
                                                                project['accentColor']
                                                                    .withOpacity(
                                                                      0.5,
                                                                    ),
                                                            blurRadius: 10,
                                                            spreadRadius: 1,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  2,
                                                                ),
                                                          ),
                                                        ]
                                                      : null,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'View Details',
                                                      style: TextStyle(
                                                        color: isHovered
                                                            ? Colors.black
                                                            : Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    AnimatedRotation(
                                                      turns: isHovered
                                                          ? 0.25
                                                          : 0,
                                                      duration: const Duration(
                                                        milliseconds: 300,
                                                      ),
                                                      child: Icon(
                                                        Icons.arrow_forward,
                                                        size: 14,
                                                        color: isHovered
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
