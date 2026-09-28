import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/fonts/sections/shared_section.dart';

import '../../theme/app_theme.dart';
import '../data/porfolio_data.dart';


class HeroSection extends StatelessWidget {
  final VoidCallback onContact;
  final VoidCallback onWork;

  const HeroSection({super.key, required this.onContact, required this.onWork});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    return Container(
      width: double.infinity,
      color: AppTheme.white,
      padding: EdgeInsets.fromLTRB(0, isWide ? 160 : 120, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Centered(
            child: isWide
                ? _WideLayout(onContact: onContact, onWork: onWork)
                : _NarrowLayout(onContact: onContact, onWork: onWork),
          ),
          const SizedBox(height: 80),
          const HDivider(),
          _StatsStrip(),
          const HDivider(),
        ],
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  final VoidCallback onContact, onWork;

  const _WideLayout({required this.onContact, required this.onWork});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: _HeadlineBlock(onContact: onContact, onWork: onWork),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: _SideBlock(),
          ),
        ),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  final VoidCallback onContact, onWork;

  const _NarrowLayout({required this.onContact, required this.onWork});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _HeadlineBlock(onContact: onContact, onWork: onWork),
      const SizedBox(height: 40),
      _SideBlock(),
    ],
  );
}

class _HeadlineBlock extends StatelessWidget {
  final VoidCallback onContact, onWork;

  const _HeadlineBlock({required this.onContact, required this.onWork});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeUp(
          delay: const Duration(milliseconds: 50),
          child: const Eyebrow('Flutter Developer · UI Designer'),
        ),
        const SizedBox(height: 24),
        FadeUp(
          delay: const Duration(milliseconds: 150),
          child: Text(
            PortfolioData.heroHeadline,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: isWide ? 80 : 48,
            ),
          ),
        ),
        const SizedBox(height: 44),
        FadeUp(
          delay: const Duration(milliseconds: 280),
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              PortfolioButton(label: 'View my work', onTap: onWork, filled: false),
              PortfolioButton(label: 'Get in touch', onTap: onContact, filled: true),
            ],
          ),
        ),
      ],
    );
  }
}

class _SideBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeUp(
      delay: const Duration(milliseconds: 220),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            PortfolioData.heroCopy,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _Dot(PortfolioData.location),
            ],
          ),
          const SizedBox(height: 12),
          _Dot('Available for freelance & full-time'),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final String text;

  const _Dot(this.text);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: AppTheme.accent,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 10),
      Text(text, style: Theme.of(context).textTheme.bodyMedium),
    ],
  );
}

class _StatsStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Centered(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: isWide
            ? Row(
          children: PortfolioData.stats
              .asMap()
              .entries
              .map((e) => Expanded(
            child: _StatItem(
              value: e.value['value']!,
              label: e.value['label']!,
              showDivider: e.key < PortfolioData.stats.length - 1,
            ),
          ))
              .toList(),
        )
            : Wrap(
          spacing: 32,
          runSpacing: 24,
          children: PortfolioData.stats
              .map((s) => _StatItem(
            value: s['value']!,
            label: s['label']!,
            showDivider: false,
          ))
              .toList(),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool showDivider;

  const _StatItem({
    required this.value,
    required this.label,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.playfairDisplay(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: AppTheme.ink,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
      if (showDivider) ...[
        const SizedBox(width: 24),
        Container(width: 1, height: 48, color: AppTheme.border),
      ],
    ],
  );
}