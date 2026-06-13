import 'dart:ui';
import 'package:flutter/material.dart';
import 'widgets/cosmic_background.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taniya Joshi | Flutter & AI Developer',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'DM Sans',
        scaffoldBackgroundColor: const Color(0xFF04061A),
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  // Keys for section navigation
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  String _active = 'home';

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutQuart,
        alignment: 0.0,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveSection);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateActiveSection());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateActiveSection() {
    final sections = {
      'home': heroKey,
      'about': aboutKey,
      'skills': skillsKey,
      'projects': projectsKey,
      'contact': contactKey,
    };

    final centerY = MediaQuery.of(context).size.height / 2;
    String best = _active;
    double bestDist = double.infinity;

    sections.forEach((name, key) {
      final ctx = key.currentContext;
      if (ctx == null) return;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) return;
      final topLeft = box.localToGlobal(Offset.zero);
      final sectionCenter = topLeft.dy + box.size.height / 2;
      final dist = (sectionCenter - centerY).abs();
      if (dist < bestDist) {
        bestDist = dist;
        best = name;
      }
    });

    if (best != _active && mounted) {
      setState(() => _active = best);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Fixed background that stays put while scrolling
          const Positioned.fill(child: CosmicBackground()),

          /// Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 100), 
                HeroSection(key: heroKey, onContact: () => scrollToSection(contactKey)),
                AboutSection(key: aboutKey, isActive: _active == 'about'),
                SkillsSection(key: skillsKey, isActive: _active == 'skills'),
                ProjectsSection(key: projectsKey, isActive: _active == 'projects'),
                ContactSection(key: contactKey, isActive: _active == 'contact'),
                const FooterWidget(),
              ],
            ),
          ),

          /// Glassmorphic Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 80,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF04061A).withOpacity(0.7),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(0.08),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo
                      Text(
                        "Taniya Joshi",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [Colors.white, Color(0xFF4F8CFF)],
                            ).createShader(const Rect.fromLTWH(0, 0, 100, 20)),
                        ),
                      ),
              
                      if (!isMobile)
                        Row(
                          children: [
                              _navItem("Home", () => scrollToSection(heroKey), _active == 'home'),
                              _navItem("About", () => scrollToSection(aboutKey), _active == 'about'),
                              _navItem("Skills", () => scrollToSection(skillsKey), _active == 'skills'),
                              _navItem("Projects", () => scrollToSection(projectsKey), _active == 'projects'),
                              _navItem("Contact", () => scrollToSection(contactKey), _active == 'contact'),
                            ],
                        )
                      else
                        const Icon(Icons.menu_rounded, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: NavLink(title: title, onTap: onTap, isActive: isActive),
    );
  }
}


class NavLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isActive;
  const NavLink({super.key, required this.title, required this.onTap, this.isActive = false});

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive || _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: active ? const Color(0xFF4F8CFF) : Colors.white70,
            decoration: active ? TextDecoration.underline : TextDecoration.none,
            shadows: active
                ? [
                    Shadow(
                      color: const Color(0xFF4F8CFF).withOpacity(0.9),
                      blurRadius: 14,
                    ),
                  ]
                : [],
            fontFamily: 'DM Sans',
          ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: const Center(
        child: Text(
          "© 2026 Taniya Joshi. Built with Flutter 💙",
          style: TextStyle(color: Colors.white38, fontSize: 14),
        ),
      ),
    );
  }
}