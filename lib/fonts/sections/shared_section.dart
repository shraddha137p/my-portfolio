import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';

// ─── Max-width centering wrapper ──────────────────────────────────────────────

class Centered extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsets? padding;

  const Centered({
    super.key,
    required this.child,
    this.maxWidth = 1100,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 32),
          child: child,
        ),
      ),
    );
  }
}

// ─── Section container ────────────────────────────────────────────────────────

class Section extends StatelessWidget {
  final Widget child;
  final Color? bg;
  final EdgeInsets padding;

  const Section({
    super.key,
    required this.child,
    this.bg,
    this.padding = const EdgeInsets.symmetric(vertical: 96),
  });

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: bg,
    padding: padding,
    child: child,
  );
}

// ─── Eyebrow label ────────────────────────────────────────────────────────────

class Eyebrow extends StatelessWidget {
  final String text;

  const Eyebrow(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: Theme.of(context).textTheme.labelLarge,
  );
}

// ─── Pill tag ─────────────────────────────────────────────────────────────────

class Tag extends StatelessWidget {
  final String label;
  final Color? bg;
  final Color? textColor;

  const Tag(this.label, {super.key, this.bg, this.textColor});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      color: bg ?? AppTheme.surface,
      border: Border.all(color: AppTheme.border),
      borderRadius: BorderRadius.circular(40),
    ),
    child: Text(
      label,
      style: GoogleFonts.dmMono(
        fontSize: 11,
        letterSpacing: 0.4,
        color: textColor ?? AppTheme.inkLight,
      ),
    ),
  );
}

// ─── Animated fade + slide in ─────────────────────────────────────────────────

class FadeUp extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const FadeUp({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 650),
  });

  @override
  State<FadeUp> createState() => _FadeUpState();
}

class _FadeUpState extends State<FadeUp> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _c, curve: Curves.easeOut);
    _slide = Tween(begin: const Offset(0, 0.05), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOut));
    Future.delayed(widget.delay, () { if (mounted) _c.forward(); });
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _fade,
    child: SlideTransition(position: _slide, child: widget.child),
  );
}

// ─── Hover button (outlined / filled) ────────────────────────────────────────

class PortfolioButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool filled;

  const PortfolioButton({
    super.key,
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  @override
  State<PortfolioButton> createState() => _PortfolioButtonState();
}

class _PortfolioButtonState extends State<PortfolioButton> {
  bool _over = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _over = true),
    onExit: (_) => setState(() => _over = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: widget.filled
              ? (_over ? AppTheme.accentDark : AppTheme.accent)
              : (_over ? AppTheme.ink : Colors.transparent),
          border: Border.all(
            color: widget.filled ? Colors.transparent : AppTheme.ink,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
            color: widget.filled
                ? AppTheme.ink
                : (_over ? AppTheme.white : AppTheme.ink),
          ),
        ),
      ),
    ),
  );
}

// ─── Horizontal divider line ──────────────────────────────────────────────────

class HDivider extends StatelessWidget {
  const HDivider({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 1,
    color: AppTheme.border,
    width: double.infinity,
  );
}

// ─── Arrow link ───────────────────────────────────────────────────────────────

class ArrowLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const ArrowLink({super.key, required this.label, required this.onTap});

  @override
  State<ArrowLink> createState() => _ArrowLinkState();
}

class _ArrowLinkState extends State<ArrowLink> {
  bool _over = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _over = true),
    onExit: (_) => setState(() => _over = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _over ? AppTheme.accentDark : AppTheme.ink,
              decoration: TextDecoration.underline,
              decorationColor: _over ? AppTheme.accent : AppTheme.ink,
            ),
            child: Text(widget.label),
          ),
          AnimatedSlide(
            duration: const Duration(milliseconds: 150),
            offset: _over ? const Offset(0.3, 0) : Offset.zero,
            child: const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Text('→', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}