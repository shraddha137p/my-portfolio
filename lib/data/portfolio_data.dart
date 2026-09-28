import '../models/project_model.dart';

class PortfolioData {
  static const String name = 'Shraddha Pandey';
  static const String role = 'Flutter Developer';
  static const String location = 'Lucknow, India';
  static const String email = 'shraddhapandey103@gmail.com';
  static const String phone = '+91 8303662384';
  static const String github = 'https://github.com/shraddha137p';
  static const String linkedin =
      'https://www.linkedin.com/in/shraddha-pandey-29b144208/';
  static const String bio =
      'I am a Flutter Developer based in Lucknow with professional experience building mobile and web applications using Flutter and Dart.';

  static const String aboutTitle = 'Building products, not just screens.';
  static const String aboutBody =
      'I am a Flutter Developer based in Lucknow with professional experience building mobile and web applications using Flutter and Dart.\n\nMy experience includes state management, REST APIs, Firebase, WebSocket, real-time communication, authentication, databases, payment integrations and third-party services.';

  static const List<String> skills = [
    'Dart',
    'Java',
    'Kotlin',
    'Flutter',
    'GetX',
    'BLoC',
    'Provider',
    'REST APIs',
    'JWT Authentication',
    'WebSocket',
    'Socket.IO',
    'Firebase Authentication',
    'Cloud Firestore',
    'FCM',
    'SQLite',
    'Hive',
    'Shared Preferences',
    'Google APIs',
    'OAuth',
    'Mapbox',
    'Supabase',
    'Razorpay',
    'UPI',
    'Git',
    'GitHub',
    'VS Code',
    'Android Studio',
    'Postman',
  ];

  static const List<Map<String, String>> skillGroups = [
    {'title': 'PROGRAMMING', 'items': 'Dart, Java, Kotlin'},
    {'title': 'FLUTTER', 'items': 'Flutter, GetX, BLoC, Provider'},
    {
      'title': 'BACKEND/API',
      'items': 'REST APIs, JWT Authentication, WebSocket, Socket.IO',
    },
    {
      'title': 'FIREBASE',
      'items': 'Firebase Authentication, Cloud Firestore, FCM',
    },
    {'title': 'DATABASE', 'items': 'SQLite, Hive, Shared Preferences'},
    {'title': 'INTEGRATIONS', 'items': 'Google APIs, OAuth, Mapbox, Supabase'},
    {'title': 'PAYMENTS', 'items': 'Razorpay, UPI'},
    {
      'title': 'TOOLS',
      'items': 'Git, GitHub, VS Code, Android Studio, Postman',
    },
  ];

  static const List<String> serviceTitles = [
    'Flutter Application Development',
    'API Integration',
    'Real-Time Applications',
    'Firebase Integration',
    'Payment Integration',
    'Responsive Flutter Web',
  ];

  static const List<String> serviceDescriptions = [
    'Build modern cross-platform mobile applications using Flutter and Dart.',
    'REST API integration, authentication, data handling and backend communication.',
    'WebSocket / Socket.IO based real-time features and synchronization.',
    'Authentication, Firestore and Firebase Cloud Messaging.',
    'Razorpay and UPI payment workflows.',
    'Responsive Flutter interfaces that work across mobile, tablet and web.',
  ];

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Car Comfort',
      category: 'Vehicle Service Platform',
      description:
          'Flutter-based vehicle service platform for car wash, valet services and EV charging with real-time service tracking and bookings.',
      technologies: ['Flutter', 'Dart', 'GetX', 'REST API', 'Socket.IO'],
      image: 'assets/images/car-comfort.png',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=io.carcomfort.app&hl=en_IN',
      galleryImages: [
        'assets/images/img.png',
        'assets/images/img_1.png',
        'assets/images/img_2.png',
        'assets/images/img_3.png',
        'assets/images/img_4.png',
      ],
      keyFeatures: [
        'Real-time service tracking',
        'Booking flow',
        'Vehicle service management',
      ],
      responsibilities: [
        'Flutter application development',
        'API integration',
        'Real-time communication',
      ],
    ),
    ProjectModel(
      title: 'Whitetail Tactical',
      category: 'Geospatial Application',
      description:
          'Geospatial application with map-based workflows and field navigation support for tactical use cases.',
      technologies: ['Flutter', 'Mapbox', 'AWS Storage', 'Deer Vision'],
      image: 'assets/images/whitetail-techtical.png',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.whitetail.tactical&hl=en_IN',
      galleryImages: [
        'assets/images/img_6.png',
        'assets/images/img_7.png',
        'assets/images/img_8.png',
        'assets/images/img_9.png',
      ],
      keyFeatures: [
        'Map-based navigation',
        'Field data visualization',
        'Geospatial tools',
      ],
      responsibilities: [
        'Flutter app enhancement',
        'Mapbox integration',
        'Location-based UI',
      ],
    ),
    ProjectModel(
      title: 'Tribe',
      category: 'Social Media Application',
      description:
          'Social media application with posts, reels, stories, likes, comments, profiles and real-time interactions.',
      technologies: ['Flutter', 'Firebase', 'REST API', 'WebSocket'],
      image: 'assets/images/tribe-img.png',
      playStoreUrl: null,
      keyFeatures: ['Profiles', 'Stories', 'Real-time interactions'],
      responsibilities: [
        'Feature development',
        'Realtime communication',
        'Firebase data flow',
      ],
    ),
    ProjectModel(
      title: 'Heroes',
      category: 'Real-Time Application',
      description:
          'Flutter application using Supabase for real-time interactions and efficient data synchronization.',
      technologies: ['Flutter', 'Supabase', 'Dart'],
      image: 'assets/images/heroes.jpg',
      playStoreUrl: null,
      keyFeatures: [
        'Live synchronization',
        'Data-driven app flows',
        'Responsive UI',
      ],
      responsibilities: [
        'Realtime app setup',
        'Supabase integration',
        'Flutter UI build',
      ],
    ),
    ProjectModel(
      title: 'Bhukkads',
      category: 'Food Delivery',
      description:
          'Food ordering, dine-in, QR table ordering, order tracking and online payments.',
      technologies: ['Flutter', 'Firebase', 'REST API', 'Payment Gateway'],
      image: 'assets/images/bhukkads.jpeg',
      playStoreUrl: null,
      keyFeatures: ['QR ordering', 'Track order status', 'Online payments'],
      responsibilities: [
        'Flutter feature development',
        'Payments',
        'Order flow logic',
      ],
    ),
    ProjectModel(
      title: 'BFC Book Publication',
      category: 'Digital Bookstore',
      description:
          'Book discovery, search, cart management, authentication and online purchases.',
      technologies: [
        'Flutter',
        'BLoC',
        'REST API',
        'Firebase',
        'Payment Gateway',
      ],
      image: 'assets/images/bfc-img-1.png',
      galleryImages: [
        'assets/images/bfc-img1.png',
        'assets/images/bfc-img-3.png',
        'assets/images/bfc-img-4.png',
      ],
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.bfc.publications',
      keyFeatures: [
        'Search and discovery',
        'Authentication',
        'Cart and checkout',
      ],
      responsibilities: [
        'State management',
        'Checkout flow',
        'Firebase auth and API integration',
      ],
    ),
    ProjectModel(
      title: 'Naksa',
      category: 'Interior Design',
      description:
          'Online interior design application with responsive mobile and web UI.',
      technologies: ['Flutter', 'Dart', 'REST API', 'PWA'],
      image: 'assets/images/naksa.png',
      playStoreUrl: null,
      keyFeatures: [
        'Responsive mobile & web UX',
        'Design discovery flow',
        'API-driven content',
      ],
      responsibilities: [
        'Responsive UI development',
        'API-driven screens',
        'Cross-platform interface',
      ],
    ),
  ];

  static const List<Map<String, dynamic>> experiences = [
    {
      'company': 'SKYESTONE AI TECH PVT. LTD',
      'role': 'Flutter Developer',
      'duration': 'JAN 2026 — PRESENT',
      'projects': ['Car Comfort', 'Whitetail Tactical'],
    },
    {
      'company': 'JAMTECH TECHNOLOGIES PVT. LTD',
      'role': 'Flutter Developer',
      'duration': 'JAN 2025 — JAN 2026',
      'projects': ['Tribe', 'Heroes'],
    },
    {
      'company': 'BFC SOFTTECH PVT. LTD',
      'role': 'Flutter Developer',
      'duration': 'OCT 2023 — DEC 2024',
      'projects': [
        'Bhukkads',
        'BFC Book Publication',
        'Prodigy Pro : Mutual Fund & SIP.Project',
      ],
    },
    {
      'company': 'RAKLE IT SOLUTION PVT. LTD',
      'role': 'Flutter Developer',
      'duration': 'MAR 2023 — OCT 2023',
      'projects': ['Naksa'],
    },
  ];

  static const List<Map<String, String>> education = [
    {
      'title': 'Bachelor of Technology',
      'subtitle': 'Computer Science',
      'school': 'Prayag Institute of Technology & Management',
    },
    {
      'title': 'Diploma in Computer Science',
      'subtitle': '',
      'school': 'Government Girls Polytechnic',
    },
  ];

  static const List<Map<String, String>> certifications = [
    {'title': 'Flutter Development', 'source': 'Udemy'},
    {
      'title': 'Android Development / Java / SQL / HTML / CSS / Bootstrap',
      'source': 'SOFTPRO India',
    },
    {'title': 'Web Development', 'source': 'BTPS Pvt. Ltd.'},
  ];

  static const List<Map<String, String>> workflow = [
    {
      'step': '01',
      'title': 'UNDERSTAND',
      'body': 'Understand requirements, users and application flow.',
    },
    {
      'step': '02',
      'title': 'ARCHITECT',
      'body': 'Plan screens, state management, API structure and data flow.',
    },
    {
      'step': '03',
      'title': 'BUILD',
      'body': 'Develop responsive Flutter UI and application functionality.',
    },
    {
      'step': '04',
      'title': 'INTEGRATE',
      'body':
          'Connect APIs, Firebase, authentication, real-time systems and payments.',
    },
    {
      'step': '05',
      'title': 'TEST & OPTIMIZE',
      'body': 'Debug, test, optimize performance and improve user experience.',
    },
  ];

  static const Map<String, List<String>> aboutCards = {
    '01': ['MOBILE DEVELOPMENT', 'Flutter', 'Dart', 'Responsive UI'],
    '02': ['BACKEND & APIs', 'REST APIs', 'JWT', 'Firebase', 'WebSocket'],
    '03': ['INTEGRATIONS', 'Mapbox', 'Razorpay', 'UPI', 'Supabase'],
  };

  static const List<String> filterTags = [
    'ALL',
    'MOBILE APPS',
    'REAL-TIME',
    'E-COMMERCE',
    'SERVICES',
    'WEB',
  ];

  static const List<String> statLabels = [
    'Years Experience',
    'Featured Projects',
    'Technologies',
  ];
  static const List<int> statValues = [3, 7, 20];

  static const String heroGreeting = 'FLUTTER DEVELOPER';
  static const String heroHeadline = 'I BUILD\nDIGITAL\nEXPERIENCES.';
  static const String heroSubheadline =
      'Flutter Developer crafting scalable mobile applications, real-time experiences and polished digital products.';
}
