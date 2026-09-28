import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';
import '../data/porfolio_data.dart';


class MarqueeStrip extends StatefulWidget {
  const MarqueeStrip({super.key});

  @override
  State<MarqueeStrip> createState() => _MarqueeStripState();
}

class _MarqueeStripState extends State<MarqueeStrip>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  static const double _itemWidth = 160;
  late final double _totalWidth;

  @override
  void initState() {
    super.initState();
    final count = PortfolioData.skills.length;
    _totalWidth = count * _itemWidth;

    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: count * 3),
    )..repeat();

    _anim = Tween<double>(begin: 0, end: -_totalWidth).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skills = PortfolioData.skills;
    // Duplicate for seamless loop
    final items = [...skills, ...skills];

    return Container(
      color: AppTheme.ink,
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _anim,
          builder: (_, __) => Transform.translate(
            offset: Offset(_anim.value % -_totalWidth, 0),
            child: Row(
              children: items
                  .map((s) => SizedBox(
                width: _itemWidth,
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppTheme.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      s,
                      style: GoogleFonts.dmMono(
                        fontSize: 13,
                        color: AppTheme.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}