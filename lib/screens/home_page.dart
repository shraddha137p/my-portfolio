import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:porfolio/data/portfolio_data.dart';
import 'package:porfolio/models/project_model.dart';
import 'package:porfolio/screens/project_details_page.dart';
import 'package:porfolio/theme/app_theme.dart';
import 'package:porfolio/utils/animations.dart';
import 'package:porfolio/utils/link_helper.dart';
import 'package:porfolio/utils/responsive.dart';
import 'package:porfolio/widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  bool _isScrolled = false;
  bool _menuOpen = false;
  String _selectedFilter = 'ALL';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final scrolled = _scrollController.offset > 12;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
    setState(() => _menuOpen = false);
  }

  List<ProjectModel> get filteredProjects {
    if (_selectedFilter == 'ALL') return PortfolioData.projects;
    final selected = _selectedFilter.toUpperCase();
    return PortfolioData.projects.where((project) {
      final category = project.category.toUpperCase();
      if (selected == 'MOBILE APPS') return category.contains('PLATFORM') || category.contains('SOCIAL') || category.contains('INTERIOR');
      if (selected == 'REAL-TIME') return category.contains('REAL-TIME') || project.title == 'Car Comfort' || project.title == 'Tribe';
      if (selected == 'E-COMMERCE') return category.contains('BOOK') || category.contains('FOOD') || category.contains('VEHICLE');
      if (selected == 'SERVICES') return category.contains('SERVICE') || category.contains('VEHICLE');
      if (selected == 'WEB') return category.contains('INTERIOR') || category.contains('BOOK');
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              decoration: AppTheme.backgroundDecoration,
            ),
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  KeyedSubtree(
                    key: _homeKey,
                    child: FadeIn(delay: const Duration(milliseconds: 100), child: _heroSection(context)),
                  ),
                  _section(
                    key: _aboutKey,
                    title: 'Building products, not just screens.',
                    subtitle: 'About',
                    child: _aboutSection(context),
                  ),
                  _section(
                    key: _skillsKey,
                    title: 'Technologies I work with.',
                    subtitle: 'Skills',
                    child: _skillsSection(context),
                  ),
                  _section(
                    key: _projectsKey,
                    title: 'Selected Work',
                    subtitle: 'Real applications, real products, real development experience.',
                    child: _projectsSection(context),
                  ),
                  _section(
                    key: _experienceKey,
                    title: 'Professional Journey',
                    subtitle: 'Experience',
                    child: _experienceSection(context),
                  ),
                  _section(
                    key: _contactKey,
                    title: "LET'S BUILD\nSOMETHING GREAT.",
                    subtitle: 'Have a project, opportunity or idea?',
                    child: _contactSection(context),
                  ),
                  _footer(),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Navbar(
                onHome: () => scrollTo(_homeKey),
                onAbout: () => scrollTo(_aboutKey),
                onSkills: () => scrollTo(_skillsKey),
                onProjects: () => scrollTo(_projectsKey),
                onExperience: () => scrollTo(_experienceKey),
                onContact: () => scrollTo(_contactKey),
                isScrolled: _isScrolled,
                menuOpen: _menuOpen,
                onMenuToggle: () => setState(() => _menuOpen = !_menuOpen),
              ),
            ),
            if (_menuOpen && isMobile)
              Positioned(
                top: 92,
                right: 14,
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B1018),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: Column(
                    children: [
                      _menuLink('Home', () => scrollTo(_homeKey)),
                      _menuLink('About', () => scrollTo(_aboutKey)),
                      _menuLink('Skills', () => scrollTo(_skillsKey)),
                      _menuLink('Projects', () => scrollTo(_projectsKey)),
                      _menuLink('Experience', () => scrollTo(_experienceKey)),
                      _menuLink('Contact', () => scrollTo(_contactKey)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _menuLink(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(label, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _section({
    required Key key,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return FadeIn(
      child: Container(
        key: key,
        padding: const EdgeInsets.fromLTRB(20, 36, 20, 80),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppTheme.accent,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: Responsive.isMobile(context) ? 32 : 54,
                    height: 1.08,
                  ),
                ),
                const SizedBox(height: 30),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _heroSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final heroHeight = isMobile ? 680.0 : 700.0;

    return SizedBox(
      width: double.infinity,
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: screenWidth * (isMobile ? 0.9 : 0.58),
            child: Image.asset(
              'assets/images/user_img.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              color: const Color(0x26000000),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppTheme.background,
                  AppTheme.background.withOpacity(0.96),
                  AppTheme.background.withOpacity(0.72),
                  AppTheme.background.withOpacity(0.20),
                ],
                stops: const [0, 0.38, 0.68, 1],
              ),
            ),
          ),
          Positioned(
            left: -260,
            top: 120,
            child: IgnorePointer(
              child: Transform.rotate(
                angle: -0.48,
                child: Container(
                  width: 760,
                  height: 220,
                  color: AppTheme.accent.withOpacity(0.075),
                ),
              ),
            ),
          ),
          Positioned(
            left: -250,
            bottom: 85,
            child: IgnorePointer(
              child: Transform.rotate(
                angle: 0.25,
                child: Container(
                  width: 720,
                  height: 150,
                  color: AppTheme.accent.withOpacity(0.055),
                ),
              ),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppTheme.background, Colors.transparent],
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 28),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: isMobile ? screenWidth - 48 : 650,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, I'm",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontSize: isMobile ? 22 : 28,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          PortfolioData.name,
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: isMobile ? 48 : 72,
                            height: 1.02,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          PortfolioData.role,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppTheme.accent,
                            fontSize: isMobile ? 24 : 32,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _metaRow(),
                        const SizedBox(height: 16),
                        Text(
                          PortfolioData.heroSubheadline,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 26),
                        _ctaRow(),
                        const SizedBox(height: 14),
                        _socialRow(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaRow() {
    return Wrap(
      spacing: 18,
      runSpacing: 10,
      children: [
        _metaChip('Lucknow, India'),
        _metaChip('3+ Years Experience'),
      ],
    );
  }

  Widget _metaChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF101722),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500)),
    );
  }

  Widget _ctaRow() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        TextButton(
          onPressed: () => scrollTo(_projectsKey),
          style: TextButton.styleFrom(
            backgroundColor: AppTheme.accent,
            foregroundColor: const Color(0xFF05070B),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Explore My Work', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
        TextButton(
          onPressed: () => LinkHelper.openResume(),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Color(0x1AFFFFFF)),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Download Resume', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  Widget _socialRow() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _socialButton('GitHub', LinkHelper.openGitHub),
        _socialButton('LinkedIn', LinkHelper.openLinkedIn),
      ],
    );
  }

  Widget _socialButton(String label, Future<void> Function() onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white70,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _aboutSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(PortfolioData.aboutBody, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 26),
        GridView.count(
          crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          mainAxisExtent: Responsive.isMobile(context) ? 260 : 280,
          children: const [
            _infoCard('01', 'MOBILE DEVELOPMENT', ['Flutter', 'Dart', 'Responsive UI']),
            _infoCard('02', 'BACKEND & APIs', ['REST APIs', 'JWT', 'Firebase', 'WebSocket']),
            _infoCard('03', 'INTEGRATIONS', ['Mapbox', 'Razorpay', 'UPI', 'Supabase']),
          ],
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: [
            SizedBox(width: Responsive.isMobile(context) ? double.infinity : 220, child: _statItem('03+', 'Years Experience')),
            SizedBox(width: Responsive.isMobile(context) ? double.infinity : 220, child: _statItem('07', 'Featured Projects')),
            SizedBox(width: Responsive.isMobile(context) ? double.infinity : 220, child: _statItem('20+', 'Technologies')),
          ],
        ),
      ],
    );
  }

  Widget _skillsSection(BuildContext context) {
    return Wrap(
      spacing: 18,
      runSpacing: 18,
      children: PortfolioData.skillGroups.map((group) {
        final items = (group['items'] as String).split(', ');
        return Container(
          width: Responsive.isMobile(context) ? double.infinity : 270,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF101722),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(group['title'] as String, style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w700, letterSpacing: 0.9)),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: items.map((item) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Colors.white.withOpacity(0.04),
                  ),
                  child: Text(item, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
                )).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _projectsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: PortfolioData.filterTags.map((tag) {
            final active = _selectedFilter == tag;
            return ChoiceChip(
              label: Text(tag),
              selected: active,
              onSelected: (_) => setState(() => _selectedFilter = tag),
              selectedColor: AppTheme.accent,
              backgroundColor: const Color(0xFF101722),
              labelStyle: TextStyle(color: active ? const Color(0xFF05070B) : Colors.white70, fontWeight: FontWeight.w700),
            );
          }).toList(),
        ),
        const SizedBox(height: 26),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isMobile(context) ? 1 : Responsive.isTablet(context) ? 2 : 2,
            mainAxisExtent: Responsive.isMobile(context) ? 590 : 560,
            crossAxisSpacing: 22,
            mainAxisSpacing: 22,
          ),
          itemCount: filteredProjects.length,
          itemBuilder: (context, index) {
            final project = filteredProjects[index];
            return FadeIn(
              delay: Duration(milliseconds: index * 70),
              child: _projectCard(project),
            );
          },
        ),
      ],
    );
  }

  Widget _projectCard(ProjectModel project) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFF0B1018),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProjectDetailsPage(project: project))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.asset(
                  project.image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: const Color(0xFF101722),
                    child: const Center(child: Icon(Icons.phone_android_rounded, size: 50, color: AppTheme.accent)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.category.toUpperCase(), style: const TextStyle(color: AppTheme.accent, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                      const SizedBox(height: 10),
                      Text(project.title, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Text(
                        project.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.technologies.map((tech) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(tech, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
                        )).toList(),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Project Details',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ),
                          if (project.playStoreUrl != null)
                            TextButton.icon(
                              onPressed: () => LinkHelper.openPlayStore(project.playStoreUrl!),
                              icon: const Icon(Icons.open_in_new_rounded, size: 15),
                              label: const Text('Play Store'),
                              style: TextButton.styleFrom(
                                foregroundColor: AppTheme.accent,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _experienceSection(BuildContext context) {
    return Column(
      children: PortfolioData.experiences.asMap().entries.map((entry) {
        final experience = entry.value;
        final index = entry.key;
        final isLast = index == PortfolioData.experiences.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                experience['duration'] as String,
                style: const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B1018),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(experience['company'] as String, style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(experience['role'] as String, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (experience['projects'] as List<String>).map((project) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: Colors.white.withOpacity(0.04),
                        ),
                        child: Text(project, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 80,
                color: Colors.white.withOpacity(0.08),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _contactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Have a project, opportunity or idea?', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 18),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _contactButton('Email Me', () => LinkHelper.openEmail()),
            _contactButton('LinkedIn', LinkHelper.openLinkedIn),
            _contactButton('GitHub', LinkHelper.openGitHub),
            _contactButton('Download Resume', LinkHelper.openResume),
          ],
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 20,
          runSpacing: 12,
          children: [
            _detailItem('Email', PortfolioData.email),
            _detailItem('Phone', PortfolioData.phone),
            _detailItem('Location', PortfolioData.location),
          ],
        ),
      ],
    );
  }

  Widget _contactButton(String label, Future<void> Function() onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppTheme.accent,
        foregroundColor: const Color(0xFF05070B),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }

  Widget _detailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 1.2)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _footer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Portfolio.', style: TextStyle(color: AppTheme.accent, fontSize: 30, fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              const Text('Shraddha Pandey', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22)),
              const Text('Flutter Developer', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 18),
              Wrap(
                spacing: 18,
                children: const [
                  Text('About', style: TextStyle(color: Colors.white70)),
                  Text('Skills', style: TextStyle(color: Colors.white70)),
                  Text('Projects', style: TextStyle(color: Colors.white70)),
                  Text('Experience', style: TextStyle(color: Colors.white70)),
                  Text('Contact', style: TextStyle(color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: Color(0x1AFFFFFF)),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('© 2026 Shraddha Pandey. All rights reserved.', style: TextStyle(color: Colors.white54)),
                  Wrap(
                    spacing: 16,
                    children: const [
                      Text('GitHub', style: TextStyle(color: Colors.white70)),
                      Text('LinkedIn', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF101722),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(color: AppTheme.accent, fontSize: 28, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

class _infoCard extends StatelessWidget {
  final String number;
  final String title;
  final List<String> points;

  const _infoCard(this.number, this.title, this.points);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: const Color(0xFF101722),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number, style: const TextStyle(color: AppTheme.accent, fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 0.8),
          ),
          const SizedBox(height: 16),
          ...points.map((point) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '• $point',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              )),
        ],
      ),
    );
  }
}

