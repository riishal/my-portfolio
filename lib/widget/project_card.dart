import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String category;

  const ProjectCard({super.key, required this.title, required this.category});

  @override
  Widget build(BuildContext context) {
    return FlipInX(
      duration: const Duration(milliseconds: 800),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E1E1E), Color(0xFF2D2D2D)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: const Color(0xFF2D2D2D),
                  child: const Icon(
                    Icons.image,
                    size: 80,
                    color: Color(0xFF3D3D3D),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
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
                  Text(
                    category,
                    style: const TextStyle(
                      color: Color(0xFFFFD166),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 15,
              right: 15,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD166),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_outward, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
