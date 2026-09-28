import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';
import '../data/porfolio_data.dart';


class NavBar extends StatefulWidget {
  final VoidCallback onAbout;
  final VoidCallback onWork;
  final VoidCallback onServices;
  final VoidCallback onContact;

  const NavBar({
    super.key,
    required this.onAbout,
    required this.onWork,
    required this.onServices,
    required this.onContact,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _scrolled = false;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 800;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white.withOpacity(0.95),
        border: const Border(
          bottom: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: () {},
            child: Text(
              PortfolioData.name.split(' ').first.toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppTheme.ink,
                letterSpacing: -0.3,
              ),
            ),
          ),

          const Spacer(),

          if (wide) ...[
            _NavLink('About', widget.onAbout),
            const SizedBox(width: 36),
            _NavLink('Work', widget.onWork),
            const SizedBox(width: 36),
            _NavLink('Services', widget.onServices),
            const SizedBox(width: 36),
            _CTAButton('Get in touch', widget.onContact),
          ] else
            _MobileMenu(
              onAbout: widget.onAbout,
              onWork: widget.onWork,
              onServices: widget.onServices,
              onContact: widget.onContact,
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink(this.label, this.onTap);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _over = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _over = true),
    onExit: (_) => setState(() => _over = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 150),
        style: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _over ? AppTheme.ink : AppTheme.muted,
        ),
        child: Text(widget.label),
      ),
    ),
  );
}

class _CTAButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _CTAButton(this.label, this.onTap);

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _over = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _over = true),
    onExit: (_) => setState(() => _over = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
        decoration: BoxDecoration(
          color: _over ? AppTheme.indigo : AppTheme.ink,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppTheme.white,
          ),
        ),
      ),
    ),
  );
}

class _MobileMenu extends StatelessWidget {
  final VoidCallback onAbout, onWork, onServices, onContact;

  const _MobileMenu({
    required this.onAbout,
    required this.onWork,
    required this.onServices,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) => PopupMenuButton<String>(
    icon: const Icon(Icons.menu_rounded, color: AppTheme.ink),
    color: AppTheme.white,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(color: AppTheme.border),
    ),
    onSelected: (v) {
      switch (v) {
        case 'about': onAbout();
        case 'work': onWork();
        case 'services': onServices();
        case 'contact': onContact();
      }
    },
    itemBuilder: (_) => [
      _item('About', 'about'),
      _item('Work', 'work'),
      _item('Services', 'services'),
      _item('Get in touch', 'contact'),
    ],
  );

  PopupMenuItem<String> _item(String label, String value) => PopupMenuItem(
    value: value,
    child: Text(label, style: GoogleFonts.dmSans(color: AppTheme.ink)),
  );
}