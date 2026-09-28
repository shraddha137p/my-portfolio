import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/fonts/sections/shared_section.dart';

import '../../theme/app_theme.dart';
import '../data/porfolio_data.dart';


class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final t = PortfolioData.testimonials[_current];
    final isWide = MediaQuery.of(context).size.width > 700;

    return Section(
      bg: AppTheme.ink,
      child: Centered(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Testimonial', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppTheme.accent)),
            const SizedBox(height: 48),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Column(
                key: ValueKey(_current),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"${t['quote']!}"',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: isWide ? 32 : 22,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.white,
                      height: 1.45,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppTheme.accent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            t['name']![0],
                            style: GoogleFonts.dmSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.ink,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t['name']!,
                            style: GoogleFonts.dmSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.white,
                            ),
                          ),
                          Text(
                            t['role']!,
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                _NavBtn(
                  icon: Icons.arrow_back_rounded,
                  onTap: () => setState(() {
                    _current = (_current - 1 + PortfolioData.testimonials.length) %
                        PortfolioData.testimonials.length;
                  }),
                ),
                const SizedBox(width: 12),
                _NavBtn(
                  icon: Icons.arrow_forward_rounded,
                  onTap: () => setState(() {
                    _current = (_current + 1) % PortfolioData.testimonials.length;
                  }),
                ),
                const SizedBox(width: 24),
                ...List.generate(
                  PortfolioData.testimonials.length,
                      (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: i == _current ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: i == _current ? AppTheme.accent : Colors.white24,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBtn extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavBtn({required this.icon, required this.onTap});

  @override
  State<_NavBtn> createState() => _NavBtnState();
}

class _NavBtnState extends State<_NavBtn> {
  bool _over = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _over = true),
    onExit: (_) => setState(() => _over = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: _over ? AppTheme.accent : Colors.white12,
          shape: BoxShape.circle,
        ),
        child: Icon(
          widget.icon,
          size: 18,
          color: _over ? AppTheme.ink : AppTheme.white,
        ),
      ),
    ),
  );
}