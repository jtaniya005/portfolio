import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final VoidCallback onHome;
  final VoidCallback onAbout;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onContact;

  const Navbar({
    super.key,
    required this.onHome,
    required this.onAbout,
    required this.onSkills,
    required this.onProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 80),
        decoration: BoxDecoration(
          color: const Color(0xFF04061A).withOpacity(0.8),
          border: const Border(
            bottom: BorderSide(color: Color(0x223c5cff)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Taniya",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                _NavItem(title: "Home", onTap: onHome),
                _NavItem(title: "About", onTap: onAbout),
                _NavItem(title: "Skills", onTap: onSkills),
                _NavItem(title: "Projects", onTap: onProjects),
                _NavItem(title: "Contact", onTap: onContact),
              ],
            )
          ],
        ),
      ),
    );
  }

}

class _NavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem({required this.title, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final normalStyle = const TextStyle(
      color: Colors.white70,
      fontSize: 16,
    );

    final hoverStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      decoration: TextDecoration.underline,
      shadows: [
        Shadow(
          color: Colors.blueAccent.withOpacity(0.9),
          blurRadius: 12,
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 160),
            style: _hover ? hoverStyle : normalStyle,
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}