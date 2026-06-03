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
                navItem("Home", onHome),
                navItem("About", onAbout),
                navItem("Skills", onSkills),
                navItem("Projects", onProjects),
                navItem("Contact", onContact),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget navItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}