import 'package:flutter/material.dart';
import '../widgets/hover_title.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class ProjectsSection extends StatelessWidget {
  final bool isActive;

  const ProjectsSection({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth > 1000 ? 80.0 : (screenWidth > 600 ? 40.0 : 16.0);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: horizontalPadding),
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
          HoverTitle(
            text: "My Projects",
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            isActive: isActive,
          ),
          const SizedBox(height: 70),

          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: const [
              ProjectCard(
                icon: "🗺️",
                title: "GoPlanner - Day & Trip Planner",
                description:
                    "A smart travel planner that helps users organize daily activities and trips efficiently.",
                tags: ["Node.js", "React", "Express.js"],
                githubUrl: "https://github.com/jtaniya005/goplanner",
                gradientColors: [Color(0xFF1E3A8A), Color(0xFF0F172A)],
              ),
              ProjectCard(
                icon: "🏛️",
                title: "Club Management System",
                description:
                    "A centralized platform for managing college clubs and events.",
                tags: ["Flutter", "Django", "PostgreSQL"],
                githubUrl: "https://github.com/Deepanshu-Singh-Rathore/club_management",
                gradientColors: [Color(0xFF4C1D95), Color(0xFF0F172A)],
              ),
              ProjectCard(
                icon: "🛒",
                title: "E-Commerce Website",
                description:
                    "A full-featured online store with authentication and payments.",
                tags: ["React", "Django"],
                githubUrl: "https://github.com/jtaniya005/django__project",
                gradientColors: [Color(0xFF065F46), Color(0xFF0F172A)],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String icon;
  final String title;
  final String description;
  final List<String> tags;
  final String githubUrl;
  final List<Color> gradientColors;

  const ProjectCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.tags,
    required this.githubUrl,
    required this.gradientColors,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: math.min(340, MediaQuery.of(context).size.width * 0.9),
      height: math.min(420, MediaQuery.of(context).size.height * 0.6),
        transform: isHovered
            ? (Matrix4.identity()..translate(0, -10))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.gradientColors,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? widget.gradientColors.first.withOpacity(0.5)
                  : Colors.black.withOpacity(0.4),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.icon, style: const TextStyle(fontSize: 50)),
              const SizedBox(height: 20),

              // TAGS
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.tags
                    .map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 20),

              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

            
              Expanded(
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 10),

            
              Align(
                alignment: Alignment.bottomLeft,
                child: _buildButton("GitHub", true, () {
                  _launchURL(widget.githubUrl);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, bool primary, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}