import 'package:flutter/material.dart';
import '../widgets/hover_title.dart';

class SkillsSection extends StatelessWidget {
  final bool isActive;

  const SkillsSection({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 120),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.3,
          colors: [
            Color(0xFF0F172A),
            Color(0xFF020617),
          ],
        ),
      ),
      child: Column(
        children: [
          const Text(
            "WHAT I KNOW",
            style: TextStyle(
              color: Color(0xFFA855F7),
              letterSpacing: 3,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          HoverTitle(
            text: "My Skills",
            style: const TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            isActive: isActive,
          ),
          const SizedBox(height: 70),

          Wrap(
            spacing: 35,
            runSpacing: 35,
            alignment: WrapAlignment.center,
            children: const [
              CosmicSkillCard(title: "Flutter", subtitle: "Cross-platform UI"),
              CosmicSkillCard(title: "Django", subtitle: "REST APIs & backend"),
              CosmicSkillCard(title: "React", subtitle: "Modern web apps"),
              CosmicSkillCard(title: "Node.js", subtitle: "Server-side logic"),
              CosmicSkillCard(title: "Machine Learning", subtitle: "AI models"),
              CosmicSkillCard(title: "Artificial Intelligence", subtitle: "LLMs & NLP"),
              CosmicSkillCard(title: "PostgreSQL", subtitle: "Database design"),
              CosmicSkillCard(title: "DSA", subtitle: "Algorithms"),
            ],
          ),
        ],
      ),
    );
  }
}

class CosmicSkillCard extends StatefulWidget {
  final String title;
  final String subtitle;

  const CosmicSkillCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<CosmicSkillCard> createState() => _CosmicSkillCardState();
}

class _CosmicSkillCardState extends State<CosmicSkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 280,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: isHovered
                ? [
                    const Color(0xFF1E3A8A).withOpacity(0.6),
                    const Color(0xFF6D28D9).withOpacity(0.6),
                  ]
                : [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.02),
                  ],
          ),
          border: Border.all(
            color: isHovered
                ? const Color(0xFF6366F1)
                : Colors.white.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? const Color(0xFF6366F1).withOpacity(0.6)
                  : Colors.transparent,
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.subtitle,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}