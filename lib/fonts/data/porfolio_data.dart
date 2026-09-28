import 'dart:ui';

class ProjectModel {
  final String title;
  final String description;
  final String category;
  final List<String> tags;
  final String? liveUrl;
  final String? githubUrl;
  final Color? accentColor;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    this.liveUrl,
    this.githubUrl,
    this.accentColor,
  });
}


class PortfolioData {
  // ── Personal ────────────────────────────────────────────────────────────────
  static const String name = 'Shraddha Pandey';
  static const String role = 'Flutter Developer & UI Designer';
  static const String heroHeadline = 'Crafting\nbeautiful\ndigital\nexperiences.';
  static const String heroCopy =
      'I design and build polished mobile and web applications '
      'with Flutter. Pixel-perfect UIs, clean architecture, and '
      'smooth animations — always.';

  static const String aboutTitle = 'I turn ideas\ninto products\npeople love.';
  static const String aboutBody =
      'With 3+ years of experience shipping Flutter apps across iOS, '
      'Android, and Web, I specialise in performance-first development, '
      'delightful micro-interactions, and scalable codebases. I work '
      'closely with designers and founders to bring their vision to life — '
      'from first wireframe to App Store launch.';

  static const String email = 'shraddhapandey103@gmail.com';
  static const String github = 'https://github.com/shraddha137p';
  static const String linkedin = 'https://www.linkedin.com/in/shraddha-pandey-29b144208/';
  static const String location = 'Lucknow';

  // ── Stats ───────────────────────────────────────────────────────────────────
  static const List<Map<String, String>> stats = [
    {'value': '3+', 'label': 'Years of experience'},
    {'value': '20+', 'label': 'Apps shipped'},
    {'value': '12+', 'label': 'Happy clients'},
    {'value': '100%', 'label': 'On-time delivery'},
  ];

  // ── Services ────────────────────────────────────────────────────────────────
  static const List<Map<String, String>> services = [
    {
      'icon': '📱',
      'title': 'Mobile Apps',
      'body':
      'Native-quality Flutter apps for iOS and Android. Smooth animations, offline support, and App Store-ready builds.',
    },
    {
      'icon': '🌐',
      'title': 'Flutter Web',
      'body':
      'Responsive web applications built with Flutter Web — fast, SEO-friendly, and pixel-perfect across all screen sizes.',
    },
    {
      'icon': '🎨',
      'title': 'UI/UX Design',
      'body':
      'From wireframes in Figma to production-ready components. I bridge the gap between design and code seamlessly.',
    },
    {
      'icon': '⚡',
      'title': 'Performance',
      'body':
      'Profiling, optimisation, and architecture reviews. I help teams ship faster, smoother apps without rewrites.',
    },
  ];

  // ── Projects ────────────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'Tribe',
      'category': 'Social Media App',
      'description':
      'Tribe is the future of social media as it is a “niche” platform that combines the features and functionality of Instagram, TikTok and Clubhouse audio rooms in a single app that focuses on building “niche” communities',
      'tags': ['Flutter', 'Dart', 'Firebase', 'Getx'],
      'liveUrl': 'https://play.google.com/store/apps/details?id=com.sikhona.tribe&hl=en_IN',
      'bg': Color(0xFFEFF9F6),
      'accent': Color(0xFF00B896),
    },
    {
      'title': 'BFC Book Publication and Book Store Application',
      'category': 'E-Commerce App',
      'description':
      'A mobile Application for managing book publications and a book store '
          'with categories such as motivational, poetry, and fiction books, '
          'as well as subcategories like New Releases, Most Popular, and '
          'Upcoming Launches. Publishing Packages: Integrated options for '
          'Publishing books in Paperback amd eBook formats.',
      'tags': ['Flutter', 'SQLite', 'Google Maps', 'BLoC'],
      'bg': Color(0xFFF3F0FF),
      'accent': Color(0xFF6C63FF),
    },
    {
      'title': 'Bhukkads',
      'category': 'Food App',
      'description':
      'Bhukkads is a Feature-rich food application offering users the ability'
          ' to pre-order, dine-in and take away food from  their selected '
          'restaurants. It provides a location-based restaurant display '
          'within a 5 Km radius. Designed a responsive UI',
      'tags': ['Flutter', 'Dart', 'Dio', 'SQLite','Firebase','Push '
          'Notifications,'
          ' Geolocator'],
      'liveUrl': 'https://example.com',
      'bg': Color(0xFFFFF5EE),
      'accent': Color(0xFFFF7043),
    },
    {
      'title': 'Prodigy Pro : Mutual Fund & SIP.Project',
      'category': 'Mutual Fund App',
      'description':
      'Developing the calculator modules and the user interface.',
      'tags': ['Flutter', 'SQLite', 'Google Maps', 'Getx','Firebase'],
      'liveUrl': 'https://play.google.com/store/apps/details?id=com.bfc_mf.prodigy_app',
      'bg': Color(0xFFF0F4FF),
      'accent': Color(0xFF3B7DDD),
    },
  ];

  // ── Skills ──────────────────────────────────────────────────────────────────
  static const List<String> skills = [
    'Flutter', 'Dart', 'Firebase', 'Riverpod', 'BLoC',
    'GetX', 'Supabase', 'REST APIs', 'SQLite', 'Hive',
    'Figma', 'Git', 'CI/CD', 'Fastlane', 'iOS', 'Android',
  ];

  // ── Experience ──────────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> experience = [
    {
      'role': 'Flutter Developer',
      'company': 'Skyestone AI Pvt.Ltd. Full-Time',
      'period': 'Jan 2026',
      'current': true,
    },
    {
      'role': 'Flutter Developer',
      'company': 'Jamtech Technologies Pvt.Ltd. Full-Time',
      'period': 'Jan 2025 – Jan 2026',
      'current': false,
    },
    {
      'role': 'Flutter Developer',
      'company': 'BFC Softtech Pvt.Ltd.',
      'period': 'Oct 2023 – Jan 2025',
      'current': false,
    },
    {
      'role': 'Flutter Developer',
      'company': 'Rakle It Solutions',
      'period': 'Mat 2023 – Oct 2023',
      'current': false,
    },
  ];

  // ── Testimonials ────────────────────────────────────────────────────────────
  static const List<Map<String, String>> testimonials = [
    {
      'quote':
      'Working with this developer was a game-changer. The app launched on time, looked incredible, and our users love it.',
      'name': 'Sarah K.',
      'role': 'CEO, StartupXYZ',
    },
    {
      'quote':
      'Exceptional attention to detail and a true partner throughout the whole process. Our Flutter app exceeded expectations.',
      'name': 'Marcus T.',
      'role': 'Product Lead, TechCorp',
    },
    {
      'quote':
      'If you want someone who can think like a designer and code like an engineer — this is your person.',
      'name': 'Priya R.',
      'role': 'Founder, FinApp',
    },
  ];
}