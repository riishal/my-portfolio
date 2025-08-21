import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 800),
      child: GlassmorphicContainer(
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
                      'My Blog',
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
              const SizedBox(height: 30),

              // Blog posts grid with staggered animations
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: MediaQuery.of(context).size.width > 900
                      ? 3
                      : MediaQuery.of(context).size.width > 600
                      ? 2
                      : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    FadeInLeft(
                      delay: Duration(milliseconds: 100),
                      child: BlogPostCard(
                        title: 'Flutter State Management in 2023',
                        category: 'Development',
                        date: 'June 15, 2023',
                        accentColor: Color(0xFF64B5F6),
                      ),
                    ),
                    FadeInLeft(
                      delay: Duration(milliseconds: 200),
                      child: BlogPostCard(
                        title: 'Creating Beautiful UI with Glassmorphism',
                        category: 'Design',
                        date: 'May 28, 2023',
                        accentColor: Color(0xFFBA68C8),
                      ),
                    ),
                    FadeInLeft(
                      delay: Duration(milliseconds: 300),
                      child: BlogPostCard(
                        title: 'Building Scalable Backends with Firebase',
                        category: 'Backend',
                        date: 'April 12, 2023',
                        accentColor: Color(0xFF4DB6AC),
                      ),
                    ),
                    FadeInLeft(
                      delay: Duration(milliseconds: 400),
                      child: BlogPostCard(
                        title: 'Animations in Flutter Made Easy',
                        category: 'Development',
                        date: 'March 30, 2023',
                        accentColor: Color(0xFFFF8A65),
                      ),
                    ),
                    FadeInLeft(
                      delay: Duration(milliseconds: 500),
                      child: BlogPostCard(
                        title: 'The Future of Responsive Design',
                        category: 'Design',
                        date: 'February 18, 2023',
                        accentColor: Color(0xFF9575CD),
                      ),
                    ),
                    FadeInLeft(
                      delay: Duration(milliseconds: 600),
                      child: BlogPostCard(
                        title: 'Optimizing App Performance',
                        category: 'Development',
                        date: 'January 5, 2023',
                        accentColor: Color(0xFF4FC3F7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogPostCard extends StatefulWidget {
  final String title;
  final String category;
  final String date;
  final Color accentColor;

  const BlogPostCard({
    super.key,
    required this.title,
    required this.category,
    required this.date,
    this.accentColor = const Color(0xFFFFD166),
  });

  @override
  State<BlogPostCard> createState() => _BlogPostCardState();
}

class _BlogPostCardState extends State<BlogPostCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _shadowColorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _elevationAnimation = Tween<double>(
      begin: 0,
      end: 15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _shadowColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: widget.accentColor.withOpacity(0.4),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Card(
              elevation: _elevationAnimation.value,
              shadowColor: _shadowColorAnimation.value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: const Color(0xFF1E1E1E),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image placeholder with animated gradient
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isHovered
                              ? [
                                  widget.accentColor.withOpacity(0.9),
                                  widget.accentColor
                                      .withRed(200)
                                      .withOpacity(0.8),
                                ]
                              : [
                                  widget.accentColor.withOpacity(0.7),
                                  widget.accentColor
                                      .withRed(200)
                                      .withOpacity(0.6),
                                ],
                        ),
                      ),
                      child: Center(
                        child: ElasticIn(
                          manualTrigger: true,
                          controller: (controller) {
                            if (isHovered) controller.forward();
                          },
                          child: Icon(
                            Icons.article,
                            size: isHovered ? 70 : 60,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category chip with animation
                          SlideInLeft(
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: widget.accentColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: widget.accentColor.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                widget.category,
                                style: TextStyle(
                                  color: widget.accentColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Title with hover effect
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: GoogleFonts.poppins(
                              color: isHovered
                                  ? Colors.white
                                  : const Color(0xFFE0E0E0),
                              fontSize: isHovered ? 19 : 18,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                            child: Text(widget.title),
                          ),
                          const SizedBox(height: 15),

                          // Footer with date and read more button
                          Row(
                            children: [
                              FadeTransition(
                                opacity: Tween(begin: 0.8, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: _controller,
                                    curve: Curves.easeIn,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: const Color(
                                        0xFFB4B4B4,
                                      ).withOpacity(isHovered ? 1 : 0.8),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      widget.date,
                                      style: TextStyle(
                                        color: const Color(
                                          0xFFB4B4B4,
                                        ).withOpacity(isHovered ? 1 : 0.8),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              // Animated read more button
                              SlideInRight(
                                duration: const Duration(milliseconds: 300),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isHovered
                                        ? widget.accentColor
                                        : const Color(0xFF2D2D2D),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: isHovered
                                        ? [
                                            BoxShadow(
                                              color: widget.accentColor
                                                  .withOpacity(0.5),
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Read More',
                                        style: TextStyle(
                                          color: isHovered
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      AnimatedRotation(
                                        turns: isHovered ? 0.25 : 0,
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
