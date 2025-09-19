import 'package:flutter/material.dart';
import 'package:rishal/utils/app_colors.dart';

class ModernContactSection extends StatefulWidget {
  final GlobalKey contactKey;
  final bool isMobile;

  ModernContactSection({required this.contactKey, required this.isMobile});

  @override
  _ModernContactSectionState createState() => _ModernContactSectionState();
}

class _ModernContactSectionState extends State<ModernContactSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _floatingController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _floatingAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _floatingController.repeat(reverse: true);
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _floatingController.dispose();
    _pulseController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required List<Color> gradientColors,
    required VoidCallback onTap,
    required int index,
  }) {
    bool _isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  _floatingAnimation.value * (index % 2 == 0 ? 1 : -1),
                ),
                child: GestureDetector(
                  onTap: onTap,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.all(widget.isMobile ? 24 : 32),
                    transform: Matrix4.identity()
                      ..scale(_isHovered ? 1.03 : 1.0)
                      ..rotateZ(_isHovered ? 0.005 : 0.0),
                    decoration: BoxDecoration(
                      gradient: _isHovered
                          ? LinearGradient(
                              colors: [
                                gradientColors[0].withOpacity(0.15),
                                gradientColors[1].withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [
                                AppColors.cardBackground.withOpacity(0.9),
                                AppColors.background.withOpacity(0.8),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: _isHovered
                            ? gradientColors[0].withOpacity(0.6)
                            : AppColors.accent.withOpacity(0.2),
                        width: _isHovered ? 2 : 1,
                      ),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: gradientColors[0].withOpacity(0.3),
                                blurRadius: 25,
                                offset: Offset(0, 12),
                                spreadRadius: 2,
                              ),
                              BoxShadow(
                                color: gradientColors[1].withOpacity(0.1),
                                blurRadius: 40,
                                offset: Offset(0, 20),
                                spreadRadius: 5,
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: AppColors.shadow.withOpacity(0.1),
                                blurRadius: 15,
                                offset: Offset(0, 8),
                              ),
                            ],
                    ),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          width: widget.isMobile ? 60 : 70,
                          height: widget.isMobile ? 60 : 70,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: _isHovered
                                  ? gradientColors
                                  : [
                                      AppColors.accent.withOpacity(0.8),
                                      AppColors.accent.withOpacity(0.6),
                                    ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: _isHovered
                                ? [
                                    BoxShadow(
                                      color: gradientColors[0].withOpacity(0.4),
                                      blurRadius: 20,
                                      offset: Offset(0, 8),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: AppColors.accent.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                          ),
                          child: AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _isHovered ? _pulseAnimation.value : 1.0,
                                child: Icon(
                                  icon,
                                  color: Colors.white,
                                  size: widget.isMobile ? 28 : 32,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          title,
                          style: TextStyle(
                            color: _isHovered
                                ? gradientColors[0]
                                : AppColors.textPrimary,
                            fontSize: widget.isMobile ? 18 : 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: widget.isMobile ? 14 : 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary.withOpacity(0.7),
                            fontSize: widget.isMobile ? 12 : 13,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isTextArea = false,
    String? Function(String?)? validator,
  }) {
    bool _isFocused = false;
    bool _isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: AppColors.cardBackground.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isFocused || _isHovered
                    ? AppColors.accent.withOpacity(0.8)
                    : AppColors.accent.withOpacity(0.2),
                width: _isFocused ? 2 : 1,
              ),
              boxShadow: _isFocused || _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.2),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ]
                  : [],
            ),
            child: Focus(
              onFocusChange: (focused) => setState(() => _isFocused = focused),
              child: TextFormField(
                controller: controller,
                validator: validator,
                maxLines: isTextArea ? 5 : 1,
                style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
                decoration: InputDecoration(
                  labelText: label,
                  hintText: hint,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      icon,
                      color: _isFocused || _isHovered
                          ? AppColors.accent
                          : AppColors.textSecondary.withOpacity(0.6),
                      size: 22,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: _isFocused
                        ? AppColors.accent
                        : AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  hintStyle: TextStyle(
                    color: AppColors.textSecondary.withOpacity(0.6),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: isTextArea ? 20 : 16,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSendButton() {
    bool _isHovered = false;
    bool _isPressed = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            onTap: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Message sent successfully!'),
                    backgroundColor: AppColors.accent,
                  ),
                );
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              transform: Matrix4.identity()
                ..scale(_isPressed ? 0.95 : (_isHovered ? 1.05 : 1.0)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accent, AppColors.accent.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.4),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send, color: Colors.white, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Send Message',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.contactKey,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.background,
            AppColors.cardBackground.withOpacity(0.3),
            AppColors.background,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: widget.isMobile ? 60 : 120,
        horizontal: widget.isMobile ? 20 : 80,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      'GET IN TOUCH',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [AppColors.textPrimary, AppColors.accent],
                    ).createShader(bounds),
                    child: Text(
                      'Let\'s Work Together',
                      style: TextStyle(
                        fontSize: widget.isMobile ? 32 : 52,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Text(
                      'Have a project in mind? I\'d love to hear about it. Send me a message and let\'s discuss how we can bring your ideas to life.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: widget.isMobile ? 16 : 18,
                        height: 1.6,
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: widget.isMobile ? 50 : 80),
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: widget.isMobile ? 1 : 3,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: widget.isMobile ? 1.5 : 1.2,
                    children: [
                      _buildContactCard(
                        icon: Icons.location_on,
                        title: 'Location',
                        value: 'Islamabad, Pakistan',
                        subtitle: 'Available for remote work',
                        gradientColors: [Colors.blue, Colors.blueAccent],
                        onTap: () {},
                        index: 0,
                      ),
                      _buildContactCard(
                        icon: Icons.phone,
                        title: 'Phone',
                        value: '+92 346 0159869',
                        subtitle: 'Mon-Fri 9AM-6PM',
                        gradientColors: [Colors.green, Colors.greenAccent],
                        onTap: () {},
                        index: 1,
                      ),
                      _buildContactCard(
                        icon: Icons.email,
                        title: 'Email',
                        value: 'rishal@example.com',
                        subtitle: '24/7 Available',
                        gradientColors: [Colors.purple, Colors.purpleAccent],
                        onTap: () {},
                        index: 2,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: widget.isMobile ? 50 : 80),
              Container(
                constraints: BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send me a message',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: widget.isMobile ? 24 : 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'I\'ll get back to you within 24 hours',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 32),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildModernTextField(
                            controller: _nameController,
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            icon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          _buildModernTextField(
                            controller: _emailController,
                            label: 'Email Address',
                            hint: 'Enter your email address',
                            icon: Icons.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          _buildModernTextField(
                            controller: _messageController,
                            label: 'Message',
                            hint: 'Tell me about your project...',
                            icon: Icons.message,
                            isTextArea: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your message';
                              }
                              if (value.length < 10) {
                                return 'Message should be at least 10 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 32),
                          _buildSendButton(),
                        ],
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
