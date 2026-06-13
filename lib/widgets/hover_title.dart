import 'package:flutter/material.dart';

class HoverTitle extends StatefulWidget {
  final String text;
  final TextStyle style;
  final bool isActive;
  final VoidCallback? onTap;

  const HoverTitle({super.key, required this.text, required this.style, this.isActive = false, this.onTap});

  @override
  State<HoverTitle> createState() => _HoverTitleState();
}

class _HoverTitleState extends State<HoverTitle> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final base = widget.style;
    final hoverStyle = base.copyWith(
      decoration: TextDecoration.underline,
      shadows: [
        Shadow(
          color: const Color(0xFF4F8CFF).withOpacity(0.9),
          blurRadius: 16,
        ),
      ],
    );

    final active = widget.isActive || _hover;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 160),
          style: active ? hoverStyle : base,
          child: Text(widget.text),
        ),
      ),
    );
  }
}
