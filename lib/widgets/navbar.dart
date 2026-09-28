import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final VoidCallback onHome;
  final VoidCallback onAbout;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onExperience;
  final VoidCallback onContact;
  final bool isScrolled;
  final bool menuOpen;
  final VoidCallback onMenuToggle;

  const Navbar({
    super.key,
    required this.onHome,
    required this.onAbout,
    required this.onSkills,
    required this.onProjects,
    required this.onExperience,
    required this.onContact,
    required this.isScrolled,
    required this.menuOpen,
    required this.onMenuToggle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;

    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: isScrolled ? const Color(0xF2050506) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Row(
              children: [
                InkWell(
                  onTap: onHome,
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Portfo', style: TextStyle(color: Colors.white)),
                        TextSpan(text: 'lio.', style: TextStyle(color: Color(0xFFE11D48))),
                      ],
                    ),
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                ),
                const Spacer(),
                if (!isMobile) ...[
                  _navItem('Home', onHome, active: true),
                  _navItem('About', onAbout),
                  _navItem('Skills', onSkills),
                  _navItem('Projects', onProjects),
                  _navItem('Experience', onExperience),
                  _navItem('Contact', onContact),
                ] else
                  _menuButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton() {
    return IconButton(
      onPressed: onMenuToggle,
      tooltip: menuOpen ? 'Close navigation menu' : 'Open navigation menu',
      icon: Icon(menuOpen ? Icons.close_rounded : Icons.menu_rounded),
      color: Colors.white,
    );
  }

  Widget _navItem(String title, VoidCallback onTap, {bool active = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: active ? const Color(0xFFE11D48) : Colors.white70,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        ),
        child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ),
    );
  }
}