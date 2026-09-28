import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/fonts/sections/shared_section.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_theme.dart';
import '../data/porfolio_data.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Section(
      bg: AppTheme.white,
      child: Centered(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeUp(child: const Eyebrow('Get in touch')),
            const SizedBox(height: 16),
            FadeUp(
              delay: const Duration(milliseconds: 80),
              child: Text(
                "Let's work\ntogether.",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 64),
            isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _ContactInfo()),
                      const SizedBox(width: 80),
                      Expanded(flex: 6, child: _ContactForm()),
                    ],
                  )
                : Column(
                    children: [
                      _ContactInfo(),
                      const SizedBox(height: 48),
                      _ContactForm(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Whether you have a project in mind, want to collaborate, or just want to say hello — reach out.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 40),
        _InfoTile(
          icon: Icons.email_outlined,
          label: 'Email',
          value: PortfolioData.email,
          onTap: () => openEmail(),
        ),
        const SizedBox(height: 16),
        _InfoTile(
          icon: Icons.code_rounded,
          label: 'GitHub',
          value: PortfolioData.github,
          onTap: () => openGithub(),
        ),
        const SizedBox(height: 16),
        _InfoTile(
          icon: Icons.work_outline_rounded,
          label: 'LinkedIn',
          value: PortfolioData.linkedin,
          onTap: () => openLinkedin(),
        ),
        const SizedBox(height: 16),
        _InfoTile(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: PortfolioData.location,
          onTap: () => openLocation(),
        ),
      ],
    );
  }
}

Future<void> openEmail() async {
  final Uri email = Uri(scheme: 'mailto', path: 'shraddhapandey103@gmail.com');

  if (await canLaunchUrl(email)) {
    await launchUrl(email);
  }
}

Future<void> openGithub() async {
  final Uri url = Uri.parse("https://github.com/shraddha137p");

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  }
}

Future<void> openLinkedin() async {
  final Uri url = Uri.parse(
    "https://www.linkedin.com/in/shraddha-pandey-29b144208/",
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  }
}

Future<void> sendMessage(String name, String email, String message) async {
  final Uri mail = Uri(
    scheme: 'mailto',
    path: 'shraddhapandey103@gmail.com',
    query: 'subject=Contact from $name&body=Email: $email\n\n$message',
  );

  await launchUrl(mail);
}

Future<void> openLocation() async {
  final Uri url = Uri.parse(
    "https://www.google.com/maps/search/?api=1&query=Lucknow",
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}

class _InfoTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<_InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<_InfoTile> {
  bool _over = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _over = true),
    onExit: (_) => setState(() => _over = false),
    child: GestureDetector(
      onTap: widget.onTap != null
          ? () {
              widget.onTap!();
              Clipboard.setData(ClipboardData(text: widget.value));
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _over ? AppTheme.offWhite : AppTheme.white,
          border: Border.all(color: _over ? AppTheme.ink : AppTheme.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(widget.icon, size: 18, color: AppTheme.accentDark),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: GoogleFonts.dmMono(
                    fontSize: 10,
                    color: AppTheme.muted,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  widget.value,
                  style: GoogleFonts.dmSans(fontSize: 10, color: AppTheme.ink),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  bool _sent = false;

  @override
  Widget build(BuildContext context) {
    if (_sent) {
      return Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: AppTheme.offWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          children: [
            const Text('✅', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 20),
            Text(
              "Message sent! I'll get back to you soon.",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Field(label: 'Name', controller: nameController, hint: 'Your name'),
        const SizedBox(height: 16),
        _Field(
          label: 'Email',
          controller: emailController,
          hint: 'your@email.com',
          type: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        _Field(
          label: 'Message',
          controller: messageController,
          hint: 'Tell me about your project...',
          maxLines: 5,
        ),
        const SizedBox(height: 28),
        PortfolioButton(
          label: 'Send message →',
          onTap: () {
            if (nameController.text.isNotEmpty &&
                emailController.text.isNotEmpty &&
                messageController.text.isNotEmpty) {
              setState(() => _sent = true);
            }
            sendMessage(
              nameController.text,
              emailController.text,
              messageController.text,
            );
          },
          filled: true,
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType? type;
  final int maxLines;

  const _Field({
    required this.label,
    required this.controller,
    required this.hint,
    this.type,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppTheme.inkLight,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        style: GoogleFonts.dmSans(fontSize: 15, color: AppTheme.ink),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.dmSans(color: AppTheme.muted, fontSize: 14),
          filled: true,
          fillColor: AppTheme.offWhite,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.ink, width: 1.5),
          ),
        ),
      ),
    ],
  );
}

// ─── Footer ──────────────────────────────────────────────────────────────────

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.ink,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      child: Centered(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PortfolioData.name,
                        style: GoogleFonts.dmSans(
                          color: AppTheme.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        PortfolioData.role,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _FooterLink('→ ${PortfolioData.github}', () {}),
                    const SizedBox(height: 8),
                    _FooterLink('→ ${PortfolioData.linkedin}', () {}),
                    const SizedBox(height: 8),
                    _FooterLink('→ ${PortfolioData.email}', () {}),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(height: 1, color: Colors.white12),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© ${DateTime.now().year} ${PortfolioData.name}. Built with Flutter.',
                  style: GoogleFonts.dmMono(
                    fontSize: 11,
                    color: Colors.white38,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  PortfolioData.location,
                  style: GoogleFonts.dmMono(
                    fontSize: 11,
                    color: Colors.white38,
                    letterSpacing: 0.3,
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

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink(this.label, this.onTap);

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _over = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _over = true),
    onExit: (_) => setState(() => _over = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: Text(
        widget.label,
        style: GoogleFonts.dmSans(
          fontSize: 13,
          color: _over ? AppTheme.accent : Colors.white54,
        ),
      ),
    ),
  );
}
