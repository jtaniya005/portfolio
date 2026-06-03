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
                AboutSection(key: aboutKey),
                SkillsSection(key: skillsKey),
                ProjectsSection(key: projectsKey),
                ContactSection(key: contactKey),
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
                            _navItem("Home", () => scrollToSection(heroKey)),
                            _navItem("About", () => scrollToSection(aboutKey)),
                            _navItem("Skills", () => scrollToSection(skillsKey)),
                            _navItem("Projects", () => scrollToSection(projectsKey)),
                            _navItem("Contact", () => scrollToSection(contactKey)),
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

  Widget _navItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: NavLink(title: title, onTap: onTap),
    );
  }
}


class NavLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  const NavLink({super.key, required this.title, required this.onTap});

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
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
            color: _isHovered ? const Color(0xFF4F8CFF) : Colors.white70,
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