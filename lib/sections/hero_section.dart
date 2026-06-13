import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onContact;

  const HeroSection({super.key, this.onContact});

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(100, 60, 100, 40),
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBadge(),
                const SizedBox(height: 20),

                const Text(
                  "Hi, I'm",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                GradientText(
                  "Taniya 🦋",
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w800,
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.white,
                      Color(0xFF4F8CFF),
                      Color(0xFFA855F7),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Short bio / description
                const SizedBox(height: 8),
                const Text(
                  "I build delightful mobile experiences with Flutter — crafting responsive, accessible UIs and integrating backend services. I enjoy turning ideas into polished apps and learning new tools along the way.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 18),

                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color(0xFF4F8CFF),
                    fontWeight: FontWeight.w500,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText('Flutter Developer'),
                      TyperAnimatedText('AI & ML Enthusiast'),
                      TyperAnimatedText('Full Stack Developer'),
                      TyperAnimatedText('Dart & Flutter Developer'),
                      TyperAnimatedText('Python & Django Developer'),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                _buildButtons(),

                const SizedBox(height: 20),

                // Skill tags (glow on hover, no scale)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [
                    _HoverTag(label: 'Flutter'),
                    _HoverTag(label: 'Dart'),
                    _HoverTag(label: 'Firebase'),
                    _HoverTag(label: 'Django'),
                    _HoverTag(label: 'REST APIs'),
                  ],
                ),

                const SizedBox(height: 30),

                _buildSocialIcons(),
              ],
            ),
          ),

          
          const Expanded(
            child: Center(
              child: Text(
                "👩",
                style: TextStyle(fontSize: 150),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF4F8CFF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: const Color(0xFF4F8CFF).withOpacity(0.25),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 4,
            backgroundColor: Color(0xFF22D3EE),
          ),
          SizedBox(width: 8),
          Text(
            "Available for opportunities",
            style: TextStyle(
              color: Color(0xFF4F8CFF),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            _openUrl("assets/resume.pdf");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4F8CFF),
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 16,
            ),
          ),
          child: const Text("Download Resume"),
        ),
        const SizedBox(width: 16),
        OutlinedButton(
          onPressed: () {
            if (onContact != null) {
              onContact!();
            } else {
              // Fallback: open mail client
              _openUrl("mailto:taniya@example.com");
            }
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white24),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
          ),
          child: const Text(
            "Contact Me",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
}
  Widget _buildSocialIcons() {
    return Row(
      children: [
        _HoverIcon(
          icon: FontAwesomeIcons.github,
          url: "https://github.com/jtaniya005",
          brandColor: const Color(0xFF333333),
          openUrl: _openUrl,
        ),
        const SizedBox(width: 20),
        _HoverIcon(
          icon: FontAwesomeIcons.linkedin,
          url:
              "https://www.linkedin.com/in/taniya-joshi-a7790434b",
          brandColor: const Color(0xFF0A66C2),
          openUrl: _openUrl,
        ),
        const SizedBox(width: 20),
        _HoverIcon(
          icon: FontAwesomeIcons.xTwitter,
          url: "https://x.com/TANIYAJ41376379",
          brandColor: Colors.black,
          openUrl: _openUrl,
        ),
      ],
    );
  }
}

class _HoverIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final Color brandColor;
  final Future<void> Function(String) openUrl;

  const _HoverIcon({
    required this.icon,
    required this.url,
    required this.brandColor,
    required this.openUrl,
  });

  @override
  State<_HoverIcon> createState() => _HoverIconState();
}

class _HoverIconState extends State<_HoverIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => widget.openUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: isHovered
              ? (Matrix4.identity()..scale(1.15))
              : Matrix4.identity(),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isHovered
                ? (widget.brandColor.computeLuminance() < 0.5
                    ? Colors.white.withOpacity(0.06)
                    : widget.brandColor.withOpacity(0.15))
                : Colors.white.withOpacity(0.05),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: widget.brandColor.computeLuminance() < 0.5
                          ? Colors.white.withOpacity(0.6)
                          : widget.brandColor.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
            border: Border.all(
              color: isHovered
                  ? (widget.brandColor.computeLuminance() < 0.5 ? Colors.white : widget.brandColor)
                  : const Color(0xFF4F8CFF),
            ),
          ),
          child: FaIcon(
            widget.icon,
            color: isHovered
                ? (widget.brandColor.computeLuminance() < 0.5 ? Colors.white : widget.brandColor)
                : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _HoverTag extends StatefulWidget {
  final String label;

  const _HoverTag({required this.label});

  @override
  State<_HoverTag> createState() => _HoverTagState();
}

class _HoverTagState extends State<_HoverTag> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    const glowColor = Color(0xFF4F8CFF);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isHovered
              ? glowColor.withOpacity(0.08)
              : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered ? glowColor : Colors.transparent,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: glowColor.withOpacity(0.25),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: isHovered ? glowColor : Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}


