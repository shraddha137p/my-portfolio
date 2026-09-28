import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/fonts/sections/shared_section.dart';

import '../../theme/app_theme.dart';
import '../data/porfolio_data.dart';


class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      bg: AppTheme.white,
      child: Centered(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeUp(child: const Eyebrow('Selected work')),
            const SizedBox(height: 16),
            FadeUp(
              delay: const Duration(milliseconds: 80),
              child: Text('Projects',
                  style: Theme.of(context).textTheme.displayMedium),
            ),
            const SizedBox(height: 64),
            const HDivider(),
            ...PortfolioData.projects.asMap().entries.map(
                  (e) => FadeUp(
                delay: Duration(milliseconds: 80 * e.key),
                child: _ProjectRow(
                  index: e.key + 1,
                  data: e.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectRow extends StatefulWidget {
  final int index;
  final Map<String, dynamic> data;

  const _ProjectRow({required this.index, required this.data});

  @override
  State<_ProjectRow> createState() => _ProjectRowState();
}

class _ProjectRowState extends State<_ProjectRow> {
  bool _over = false;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    final bg = widget.data['bg'] as Color? ?? AppTheme.offWhite;
    final accent = widget.data['accent'] as Color? ?? AppTheme.accent;
    final tags = widget.data['tags'] as List<String>? ?? [];

    return MouseRegion(
      onEnter: (_) => setState(() => _over = true),
      onExit: (_) => setState(() => _over = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: _over ? AppTheme.offWhite : AppTheme.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: isWide
                  ? _WideRow(
                index: widget.index,
                data: widget.data,
                bg: bg,
                accent: accent,
                tags: tags,
                over: _over,
              )
                  : _NarrowRow(
                index: widget.index,
                data: widget.data,
                bg: bg,
                accent: accent,
                tags: tags,
              ),
            ),
            const HDivider(),
          ],
        ),
      ),
    );
  }
}

class _WideRow extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  final Color bg, accent;
  final List<String> tags;
  final bool over;

  const _WideRow({
    required this.index,
    required this.data,
    required this.bg,
    required this.accent,
    required this.tags,
    required this.over,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Number
        SizedBox(
          width: 56,
          child: Text(
            '0$index',
            style: GoogleFonts.dmMono(
              fontSize: 13,
              color: AppTheme.muted,
              letterSpacing: 1,
            ),
          ),
        ),
        // Category chip
        SizedBox(
          width: 140,
          child: Tag(data['category'] as String),
        ),
        const SizedBox(width: 32),
        // Title + description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['title'] as String,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                data['description'] as String,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((t) => Tag(t)).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        // Preview box
        AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 160,
          height: 110,
          decoration: BoxDecoration(
            color: over ? bg : AppTheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.border),
          ),
          child: Center(
            child: Text(
              _getEmoji(index),
              style: const TextStyle(fontSize: 40),
            ),
          ),
        ),
      ],
    );
  }
}

class _NarrowRow extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  final Color bg, accent;
  final List<String> tags;

  const _NarrowRow({
    required this.index,
    required this.data,
    required this.bg,
    required this.accent,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('0$index',
                style: GoogleFonts.dmMono(fontSize: 12, color: AppTheme.muted)),
            const SizedBox(width: 16),
            Tag(data['category'] as String),
          ],
        ),
        const SizedBox(height: 16),
        Text(data['title'] as String,
            style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text(data['description'] as String,
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((t) => Tag(t)).toList()),
      ],
    );
  }
}

String _getEmoji(int i) {
  const emojis = ['📱', '📕', '🍔️', '💹'];
  return emojis[(i - 1) % emojis.length];
}