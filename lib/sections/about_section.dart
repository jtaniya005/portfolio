import 'package:flutter/material.dart';
import '../widgets/hover_title.dart';

class AboutSection extends StatelessWidget {
  final bool isActive;

  const AboutSection({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120),
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HoverTitle(
                  text: "About Me",
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  isActive: isActive,
                ),
                const SizedBox(height: 30),
                const Text(
                  "I am a passionate Computer Science student driven by curiosity "
                  "and a strong desire to build meaningful digital solutions. "
                  "I enjoy transforming ideas into structured, efficient, and "
                  "user-focused applications that solve real-world problems.\n\n"
                  "With a solid foundation in problem-solving and logical thinking, "
                  "I continuously work on improving my technical abilities and "
                  "understanding systems at a deeper level. I believe great software "
                  "is not only functional, but scalable, maintainable, and thoughtfully engineered.\n\n"
                  "My goal is to grow into a skilled software engineer who contributes "
                  "to innovative projects, takes on challenging problems, and "
                  "continuously evolves with emerging technologies.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 60),

                /// Responsive Cards
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 900) {
                      // Mobile / small screen → stacked
                      return Column(
                        children: const [
                          _StatCard(
                            title: "Problem Solving",
                            subtitle: "Strong Analytical Thinking",
                          ),
                          SizedBox(height: 30),
                          _StatCard(
                            title: "Scalable Design",
                            subtitle: "Structured & Clean Systems",
                          ),
                          SizedBox(height: 30),
                          _StatCard(
                            title: "Continuous Learning",
                            subtitle: "Growth Mindset",
                          ),
                        ],
                      );
                    } else {
                      // Desktop → row layout
                      return Row(
                        children: const [
                          Expanded(
                            child: _StatCard(
                              title: "Problem Solving",
                              subtitle: "Strong Analytical Thinking",
                            ),
                          ),
                          SizedBox(width: 40),
                          Expanded(
                            child: _StatCard(
                              title: "Scalable Design",
                              subtitle: "Structured & Clean Systems",
                            ),
                          ),
                          SizedBox(width: 40),
                          Expanded(
                            child: _StatCard(
                              title: "Continuous Learning",
                              subtitle: "Growth Mindset",
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatefulWidget {
  final String title;
  final String subtitle;

  const _StatCard({
    required this.title,
    required this.subtitle,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: isHovered
            ? (Matrix4.identity()..scale(1.05))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: isHovered
              ? const Color(0xFF4F8CFF).withOpacity(0.1)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF4F8CFF),
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF4F8CFF).withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F8CFF),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              widget.subtitle,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}