import 'package:flutter/material.dart';

class ClientLogo extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color gradientStart;
  final Color gradientEnd;
  final double width;
  final double height;

  const ClientLogo({
    super.key,
    this.icon = Icons.business,
    this.iconColor = Colors.white,
    this.gradientStart = const Color(0xFF6A11CB),
    this.gradientEnd = const Color(0xFF2575FC),
    this.width = 110,
    this.height = 70,
  });

  @override
  State<ClientLogo> createState() => _ClientLogoState();
}

class _ClientLogoState extends State<ClientLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..scale(_scaleAnimation.value)
              ..rotateZ(_rotateAnimation.value),
            alignment: Alignment.center,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [widget.gradientStart, widget.gradientEnd],
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: widget.gradientEnd.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Center(
                child: Icon(widget.icon, color: widget.iconColor, size: 34),
              ),
            ),
          );
        },
      ),
    );
  }
}
