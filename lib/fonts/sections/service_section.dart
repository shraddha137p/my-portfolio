import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/fonts/sections/shared_section.dart';

import '../../theme/app_theme.dart';
import '../data/porfolio_data.dart';


class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Section(
      bg: AppTheme.offWhite,
      child: Centered(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeUp(child: const Eyebrow('What I do')),
            const SizedBox(height: 16),
            FadeUp(
              delay: const Duration(milliseconds: 80),
              child: Text(
                'Services',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 64),
            isWide ? _WideGrid() : _NarrowList(),
          ],
        ),
      ),
    );
  }
}

class _WideGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
      childAspectRatio: 1.6,
    ),
    itemCount: PortfolioData.services.length,
    itemBuilder: (_, i) => _ServiceCard(
      data: PortfolioData.services[i],
      delay: Duration(milliseconds: 60 * i),
    ),
  );
}

class _NarrowList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: PortfolioData.services
        .asMap()
        .entries
        .map((e) => Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: _ServiceCard(
        data: e.value,
        delay: Duration(milliseconds: 60 * e.key),
      ),
    ))
        .toList(),
  );
}

class _ServiceCard extends StatefulWidget {
  final Map<String, String> data;
  final Duration delay;

  const _ServiceCard({required this.data, required this.delay});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _over = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _over = true),
      onExit: (_) => setState(() => _over = false),
      child: FadeUp(
        delay: widget.delay,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: _over ? AppTheme.ink : AppTheme.white,
            border: Border.all(color: AppTheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.data['icon']!, style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 20),
              Text(
                widget.data['title']!,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: _over ? AppTheme.white : AppTheme.ink,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Text(
                  widget.data['body']!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _over ? Colors.white70 : AppTheme.muted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}