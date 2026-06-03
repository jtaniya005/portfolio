import 'package:flutter/material.dart';

class CosmicBackground extends StatelessWidget {
  const CosmicBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark Base Layer
        Container(color: const Color(0xFF04061A)),

        // Top-Left Blue Glow
        Positioned(
          top: -150,
          left: -150,
          child: _buildOrb(500, const Color(0xFF4F8CFF).withOpacity(0.12)),
        ),

        // Bottom-Right Violet Glow
        Positioned(
          bottom: -100,
          right: -100,
          child: _buildOrb(400, const Color(0xFFA855F7).withOpacity(0.1)),
        ),

        // Center Cyan Glow
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          left: MediaQuery.of(context).size.width * 0.5,
          child: _buildOrb(300, const Color(0xFF22D3EE).withOpacity(0.05)),
        ),

        // Star Layer
        const StarField(),
      ],
    );
  }

  Widget _buildOrb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 120,
            spreadRadius: 60,
          ),
        ],
      ),
    );
  }
}

class StarField extends StatelessWidget {
  const StarField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: StarPainter(),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.5);

    final starPositions = [
      Offset(size.width * 0.15, size.height * 0.2),
      Offset(size.width * 0.32, size.height * 0.55),
      Offset(size.width * 0.55, size.height * 0.15),
      Offset(size.width * 0.72, size.height * 0.4),
      Offset(size.width * 0.88, size.height * 0.7),
      Offset(size.width * 0.10, size.height * 0.8),
      Offset(size.width * 0.45, size.height * 0.9),
      Offset(size.width * 0.60, size.height * 0.65),
    ];

    for (var pos in starPositions) {
      canvas.drawCircle(pos, 1.2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}