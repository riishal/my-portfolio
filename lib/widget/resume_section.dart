import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[900]!, Colors.black],
        ),
      ),
      child: Column(
        children: [
          // Header with animated underline
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Column(
              children: [
                Text(
                  'Professional Journey',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 4,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00E5FF), Color(0xFF1200FF)],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Main content container
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[850]!.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                // Tabbed interface
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      // Custom tab bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00E5FF), Color(0xFF1200FF)],
                            ),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey[400],
                          tabs: const [
                            Tab(text: 'Education'),
                            Tab(text: 'Experience'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Tab content
                      SizedBox(
                        height: 500,
                        child: TabBarView(
                          children: [EducationTimeline(), ExperienceTimeline()],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Enhanced Technical Expertise Section
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Technical Expertise",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Areas of specialization and proficiency levels",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Enhanced Skills Display with More Animations
                      Column(
                        children: [
                          // Programming Languages
                          SkillCategorySection(
                            title: "Programming Languages",
                            skills: const [
                              SkillItem(
                                name: "Dart",
                                level: 95,
                                icon: Icons.code,
                                gradient: [
                                  Color(0xFF00E5FF),
                                  Color(0xFF1200FF),
                                ],
                              ),
                              SkillItem(
                                name: "JavaScript",
                                level: 90,
                                icon: Icons.code,
                                gradient: [
                                  Color(0xFFFF416C),
                                  Color(0xFFFF4B2B),
                                ],
                              ),
                              SkillItem(
                                name: "Python",
                                level: 85,
                                icon: Icons.code,
                                gradient: [
                                  Color(0xFFF09819),
                                  Color(0xFFEDDE5D),
                                ],
                              ),
                              SkillItem(
                                name: "Java",
                                level: 80,
                                icon: Icons.code,
                                gradient: [
                                  Color(0xFF4776E6),
                                  Color(0xFF8E54E9),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Frameworks & Tools
                          SkillCategorySection(
                            title: "Frameworks & Tools",
                            skills: const [
                              SkillItem(
                                name: "Flutter",
                                level: 98,
                                icon: Icons.phone_android,
                                gradient: [
                                  Color(0xFF1A2980),
                                  Color(0xFF26D0CE),
                                ],
                              ),
                              SkillItem(
                                name: "Firebase",
                                level: 90,
                                icon: Icons.cloud,
                                gradient: [
                                  Color(0xFFFF5F6D),
                                  Color(0xFFFFC371),
                                ],
                              ),
                              SkillItem(
                                name: "Node.js",
                                level: 85,
                                icon: Icons.developer_board,
                                gradient: [
                                  Color(0xFF614385),
                                  Color(0xFF516395),
                                ],
                              ),
                              SkillItem(
                                name: "Git",
                                level: 95,
                                icon: Icons.merge_type,
                                gradient: [
                                  Color(0xFFEB3349),
                                  Color(0xFFF45C43),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Design & Prototyping
                          SkillCategorySection(
                            title: "Design & Prototyping",
                            skills: const [
                              SkillItem(
                                name: "Figma",
                                level: 90,
                                icon: Icons.design_services,
                                gradient: [
                                  Color(0xFFDA22FF),
                                  Color(0xFF9733EE),
                                ],
                              ),
                              SkillItem(
                                name: "Adobe XD",
                                level: 85,
                                icon: Icons.brush,
                                gradient: [
                                  Color(0xFF1FA2FF),
                                  Color(0xFF12D8FA),
                                ],
                              ),
                              SkillItem(
                                name: "UI/UX Principles",
                                level: 88,
                                icon: Icons.palette,
                                gradient: [
                                  Color(0xFFDD5E89),
                                  Color(0xFFF7BB97),
                                ],
                              ),
                              SkillItem(
                                name: "Prototyping",
                                level: 87,
                                icon: Icons.layers,
                                gradient: [
                                  Color(0xFF4CB8C4),
                                  Color(0xFF3CD3AD),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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

// Enhanced Skill Item Model with Gradient
class SkillItem {
  final String name;
  final int level;
  final IconData icon;
  final List<Color> gradient;

  const SkillItem({
    required this.name,
    required this.level,
    required this.icon,
    required this.gradient,
  });
}

// Enhanced Skill Category Section Widget
class SkillCategorySection extends StatelessWidget {
  final String title;
  final List<SkillItem> skills;

  const SkillCategorySection({
    super.key,
    required this.title,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Animated title with gradient underline
        FadeInLeft(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00E5FF), Color(0xFF1200FF)],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Skills Grid with staggered animations
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 900
                ? 4
                : MediaQuery.of(context).size.width > 600
                ? 2
                : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 3,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              delay: Duration(milliseconds: 150 * index),
              child: SkillProgressCard(
                skill: skills[index],
                delay: Duration(milliseconds: 100 * index),
              ),
            );
          },
        ),
      ],
    );
  }
}

// Enhanced Skill Progress Card with Hover Effects
class SkillProgressCard extends StatefulWidget {
  final SkillItem skill;
  final Duration delay;

  const SkillProgressCard({
    super.key,
    required this.skill,
    required this.delay,
  });

  @override
  State<SkillProgressCard> createState() => _SkillProgressCardState();
}

class _SkillProgressCardState extends State<SkillProgressCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.skill.level / 100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _isHovered ? 1.03 : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[900],
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: widget.skill.gradient[0].withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                border: Border.all(
                  color: _isHovered
                      ? widget.skill.gradient[0].withOpacity(0.5)
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Icon with animated gradient background
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: _isHovered
                              ? LinearGradient(
                                  colors: widget.skill.gradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : LinearGradient(
                                  colors: [
                                    Colors.grey[800]!,
                                    Colors.grey[700]!,
                                  ],
                                ),
                        ),
                        child: Icon(
                          widget.skill.icon,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.skill.name,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      // Percentage with pulse animation on hover
                      ScaleTransition(
                        scale: _isHovered
                            ? TweenSequence([
                                TweenSequenceItem(
                                  tween: Tween(begin: 1.0, end: 1.2),
                                  weight: 50,
                                ),
                                TweenSequenceItem(
                                  tween: Tween(begin: 1.2, end: 1.0),
                                  weight: 50,
                                ),
                              ]).animate(
                                CurvedAnimation(
                                  parent: _controller,
                                  curve: Curves.easeInOut,
                                ),
                              )
                            : const AlwaysStoppedAnimation(1.0),
                        child: Text(
                          "${(_animation.value * 100).round()}%",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey[800],
                        ),
                      ),
                      // Animated progress bar with gradient
                      FractionallySizedBox(
                        widthFactor: _animation.value,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            gradient: LinearGradient(
                              colors: widget.skill.gradient,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.skill.gradient[0].withOpacity(
                                  0.5,
                                ),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Additional details on hover
                  if (_isHovered) ...[
                    const SizedBox(height: 12),
                    Text(
                      _getProficiencyText(widget.skill.level),
                      style: GoogleFonts.poppins(
                        color: Colors.grey[300],
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getProficiencyText(int level) {
    if (level >= 90) return "Expert level proficiency";
    if (level >= 75) return "Advanced proficiency";
    if (level >= 60) return "Intermediate proficiency";
    return "Basic proficiency";
  }
}

// (Keep the existing EducationTimeline, ExperienceTimeline, and TimelineCard classes unchanged)
class EducationTimeline extends StatelessWidget {
  const EducationTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TimelineCard(
          title: 'Master in Computer Science',
          subtitle: 'Stanford University | 2018 - 2020',
          description:
              'Specialized in AI and ML. Thesis on deep learning applications in computer vision.',
          icon: Icons.school,
          color: Color(0xFF00E5FF),
        ),
        TimelineCard(
          title: 'Bachelor of Software Engineering',
          subtitle: 'MIT | 2014 - 2018',
          description:
              'Graduated with honors. Focused on mobile development and UI design.',
          icon: Icons.school,
          color: Color(0xFF9C27B0),
        ),
        TimelineCard(
          title: 'High School Diploma',
          subtitle: 'Tech High School | 2010 - 2014',
          description:
              'Specialized in mathematics and computer science. Won coding competitions.',
          icon: Icons.school,
          color: Color(0xFFFF9800),
        ),
      ],
    );
  }
}

class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TimelineCard(
          title: 'Senior Flutter Developer',
          subtitle: 'Tech Innovations Inc. | 2020 - Present',
          description:
              'Leading mobile app team. Created award-winning apps with 1M+ downloads.',
          icon: Icons.work,
          color: Color(0xFF4CAF50),
        ),
        TimelineCard(
          title: 'UI/UX Designer',
          subtitle: 'Creative Solutions | 2018 - 2020',
          description:
              'Designed interfaces for enterprise apps. Created design systems.',
          icon: Icons.work,
          color: Color(0xFFE91E63),
        ),
        TimelineCard(
          title: 'Junior Developer',
          subtitle: 'StartUp Hub | 2016 - 2018',
          description: 'Developed mobile apps for early-stage startups.',
          icon: Icons.work,
          color: Color(0xFF2196F3),
        ),
      ],
    );
  }
}

class TimelineCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;

  const TimelineCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  State<TimelineCard> createState() => _TimelineCardState();
}

class _TimelineCardState extends State<TimelineCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[900],
          border: Border.all(
            color: _isHovered ? widget.color : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.color.withOpacity(0.3)
                  : Colors.black.withOpacity(0.5),
              blurRadius: _isHovered ? 20 : 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with animated border
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[800],
                border: Border.all(
                  color: _isHovered ? widget.color : Colors.grey[700]!,
                  width: 2,
                ),
              ),
              child: Icon(widget.icon, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with hover effect
                  Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Subtitle
                  Text(
                    widget.subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Description
                  Text(
                    widget.description,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[300],
                      fontSize: 14,
                      height: 1.5,
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
}
