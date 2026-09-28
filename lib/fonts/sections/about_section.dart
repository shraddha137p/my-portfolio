import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/fonts/sections/shared_section.dart';

import '../../theme/app_theme.dart';
import '../data/porfolio_data.dart';


class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Section(
      bg: AppTheme.offWhite,
      child: Centered(
        child: isWide ? _WideLayout() : _NarrowLayout(),
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeUp(child: const Eyebrow('About me')),
            const SizedBox(height: 20),
            FadeUp(
              delay: const Duration(milliseconds: 80),
              child: Text(
                PortfolioData.aboutTitle,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 44,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 80),
      Expanded(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeUp(
                delay: const Duration(milliseconds: 120),
                child: Text(
                  PortfolioData.aboutBody,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 48),
              const HDivider(),
              const SizedBox(height: 40),
              FadeUp(
                delay: const Duration(milliseconds: 180),
                child: _ExperienceList(),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Eyebrow('About me'),
      const SizedBox(height: 16),
      Text(PortfolioData.aboutTitle,
          style: Theme.of(context).textTheme.displaySmall),
      const SizedBox(height: 32),
      Text(PortfolioData.aboutBody,
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 48),
      const HDivider(),
      const SizedBox(height: 40),
      _ExperienceList(),
    ],
  );
}

class _ExperienceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Experience',
          style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 28),
      ...PortfolioData.experience.asMap().entries.map(
            (e) => _ExpItem(data: e.value, isLast: e.key == PortfolioData.experience.length - 1),
      ),
    ],
  );
}

class _ExpItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isLast;

  const _ExpItem({required this.data, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot
          Column(
            children: [
              const SizedBox(height: 6),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: data['current'] == true ? AppTheme.accent : AppTheme.white,
                  border: Border.all(
                    color: data['current'] == true ? AppTheme.accentDark : AppTheme.muted,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Container(
                  width: 1,
                  height: 30,
                  color: AppTheme.border,
                  margin: const EdgeInsets.only(top: 6),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        data['role'] as String,
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.ink,
                        ),
                      ),
                    ),
                    Text(
                      data['period'] as String,
                      style: GoogleFonts.dmMono(
                        fontSize: 11,
                        color: AppTheme.muted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  data['company'] as String,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: AppTheme.accentDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}