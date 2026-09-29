/* ==========================================================================
   PORTFOLIO CONTENT — edit everything here. No other file needs touching.
   Lines marked  TODO  still need your input.
   Images: drop files into /assets and reference them as "assets/…".
   ========================================================================== */

window.PORTFOLIO = {
  // Colour palette: "midnight" (navy + indigo, emerald tags) · "violet" (Midnight Violet)
  //                 "gold" (Champagne Gold) · "crimson" (Crimson Luxe) · "emerald" (Emerald Noir)
  theme: "midnight",

  name: "Shraddha Pandey",
  initials: "SP",
  role: "Flutter Developer",
  email: "shraddhapandey103@gmail.com",
  location: "Lucknow, India",
  resume: "",                                        // TODO: add your résumé PDF (e.g. "assets/Shraddha-Pandey-Resume.pdf"); empty hides the Resume buttons

  hero: {
    availability: "Available for work",
    available: true,                                 // false → grey dot, "Currently booked"
    tagline:
      "Flutter Developer crafting scalable mobile applications, real-time experiences and polished digital products.",
    // "Impact, at a glance" cards. value = the number, plus = show a "+"
    stats: [
      { value: "3",  plus: true,  label: "Years experience",   note: "Building production Flutter apps across four companies." },
      { value: "7",  plus: false, label: "Featured projects",  note: "Mobility, geospatial, social, food, e-commerce and more." },
      { value: "20", plus: true,  label: "Technologies",       note: "From Firebase and Supabase to Mapbox, Razorpay and Socket.IO." },
    ],
  },

  // Wrap words in *asterisks* to paint them in the accent colour.
  sections: {
    impact:     { title: "Impact, *at a glance*", sub: "Real applications, real products, real development experience." },
    stack:      { eyebrow: "Skills",            title: "Technologies *I work with*" },
    work:       { eyebrow: "Selected work",     title: "Featured *projects*",
                  sub: "Apps I've built and shipped, several of them live on the Play Store." },
    experience: { eyebrow: "Experience",        title: "Professional *journey*" },
    about:      { eyebrow: "About",             title: "Building products, *not just screens.*" },
    contact:    { eyebrow: "Contact" },
  },

  // Icons: any SVG/PNG URL. Leave icon "" to show a lettermark instead.
  stack: [
    { name: "Flutter",       note: "GetX · BLoC · Provider",   icon: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" },
    { name: "Dart",          note: "Primary language",         icon: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.svg" },
    { name: "Firebase",      note: "Auth · Firestore · FCM",   icon: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/firebase/firebase-original.svg" },
    { name: "Supabase",      note: "Realtime · Postgres",       icon: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/supabase/supabase-original.svg" },
    { name: "REST APIs",     note: "JWT · WebSocket · Socket.IO", icon: "" },
    { name: "Kotlin",        note: "Android",                  icon: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/kotlin/kotlin-original.svg" },
    { name: "Java",          note: "Android",                  icon: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/java/java-original.svg" },
    { name: "SQLite",        note: "Hive · Shared Preferences", icon: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/sqlite/sqlite-original.svg" },
    { name: "Git",           note: "GitHub",                   icon: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg" },
    { name: "Android Studio", note: "VS Code",                 icon: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/androidstudio/androidstudio-original.svg" },
    { name: "Postman",       note: "API testing",              icon: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/postman/postman-original.svg" },
  ],

  // Second marquee row
  capabilities: [
    "GetX", "BLoC", "Provider", "JWT Authentication", "WebSocket & Socket.IO",
    "Cloud Firestore", "Push notifications (FCM)", "Google APIs & OAuth",
    "Mapbox", "Razorpay & UPI", "Hive & SQLite", "Supabase Realtime",
  ],

  // featured: true → full-width showcase panel (use it on ONE project).
  // image + imageType control the preview:
  //   "screen" → a plain app screenshot, shown inside the phone frame
  //   "mockup" → an image that already has a phone drawn around it
  //   "poster" → a store graphic / banner, shown as a rounded poster
  //   "logo"   → an app logo, shown as an app icon
  // No image → a designed placeholder screen (mock: "feed" · "stats" · "shop" · "tasks" · "chat")
  projects: [
    {
      title: "Car Comfort",
      category: "Vehicle service platform",
      company: "Skyestone AI Tech",
      featured: true,
      description:
        "Flutter-based vehicle service platform for car wash, valet services and EV charging, with real-time service tracking and bookings.",
      highlights: ["Real-time service tracking", "Booking flow", "Vehicle service management"],
      tech: ["Flutter", "Dart", "GetX", "REST API", "Socket.IO"],
      image: "assets/projects/car-comfort.png", imageType: "mockup",
      links: { playStore: "https://play.google.com/store/apps/details?id=io.carcomfort.app&hl=en_IN" },
    },
    {
      title: "Whitetail Tactical",
      category: "Geospatial application",
      company: "Skyestone AI Tech",
      description: "Geospatial application with map-based workflows and field navigation support for tactical use cases.",
      tech: ["Flutter", "Mapbox", "AWS Storage"],
      image: "assets/projects/whitetail-techtical.png", imageType: "mockup",
      links: { playStore: "https://play.google.com/store/apps/details?id=com.whitetail.tactical&hl=en_IN" },
    },
    {
      title: "BFC Book Publication",
      category: "Digital bookstore",
      company: "BFC Softtech",
      description: "Book discovery, search, cart management, authentication and online purchases.",
      tech: ["Flutter", "BLoC", "REST API", "Firebase", "Payment Gateway"],
      image: "assets/projects/bfc-img-1.png", imageType: "poster",
      links: { playStore: "https://play.google.com/store/apps/details?id=com.bfc.publications" },
    },
    {
      title: "Heroes",
      category: "Real-time application",
      company: "Jamtech Technologies",
      description: "Flutter application using Supabase for real-time interactions and efficient data synchronization.",
      tech: ["Flutter", "Supabase", "Dart"],
      image: "assets/projects/heroes.jpg", imageType: "logo",
      links: {},
    },
    {
      title: "Tribe",
      category: "Social media application",
      company: "Jamtech Technologies",
      description: "Social media application with posts, reels, stories, likes, comments, profiles and real-time interactions.",
      tech: ["Flutter", "Firebase", "REST API", "WebSocket"],
      image: "assets/projects/tribe-img.png", imageType: "logo",
      links: {},
    },
    {
      title: "Bhukkads",
      category: "Food delivery",
      company: "BFC Softtech",
      description: "Food ordering, dine-in, QR table ordering, order tracking and online payments.",
      tech: ["Flutter", "Firebase", "REST API", "Payment Gateway"],
      image: "assets/projects/bhukkads.jpeg", imageType: "logo",
      links: {},
    },
    {
      title: "Naksa",
      category: "Interior design",
      company: "Rakle IT Solution",
      description: "Online interior design application with a responsive mobile and web UI.",
      tech: ["Flutter", "Dart", "REST API", "PWA"],
      image: "assets/projects/naksa.png", imageType: "screen",
      links: {},
    },
  ],

  // Newest first. TODO: add the dates for each role in `period` (e.g. "2024 — Present").
  experience: [
    {
      role: "Flutter Developer",
      company: "Skyestone AI Tech Pvt. Ltd.",
      type: "",
      period: "",
      summary: "Built and enhanced production Flutter apps for vehicle services and geospatial field work.",
      points: ["Car Comfort: car wash, valet and EV-charging bookings with real-time tracking", "Whitetail Tactical: Mapbox-based navigation and field tools"],
      tech: ["Flutter", "GetX", "Socket.IO", "Mapbox"],
    },
    {
      role: "Flutter Developer",
      company: "Jamtech Technologies Pvt. Ltd.",
      type: "",
      period: "",
      summary: "Worked on real-time and social apps backed by Supabase and Firebase.",
      points: ["Tribe: posts, reels, stories, comments and live interactions", "Heroes: real-time Supabase app setup and UI build"],
      tech: ["Flutter", "Supabase", "Firebase", "WebSocket"],
    },
    {
      role: "Flutter Developer",
      company: "BFC Softtech Pvt. Ltd.",
      type: "",
      period: "",
      summary: "Delivered commerce features: ordering, checkout and payment flows.",
      points: ["Bhukkads: QR table ordering, order tracking and payments", "BFC Book Publication: search, cart, auth and checkout", "Prodigy Pro: Mutual Fund & SIP app"],
      tech: ["Flutter", "BLoC", "Firebase", "Razorpay"],
    },
    {
      role: "Flutter Developer",
      company: "Rakle IT Solution Pvt. Ltd.",
      type: "",
      period: "",
      summary: "Built responsive, API-driven mobile and web interfaces.",
      points: ["Naksa: interior design app with mobile and web (PWA) UI"],
      tech: ["Flutter", "REST API", "PWA"],
    },
  ],

  about: {
    // visual: "flutter3d" → interactive 3D Flutter logo · or set photo: "assets/you.jpg" and visual: "" for a photo
    visual: "flutter3d",
    chips: ["Dart", "Widgets", "Hot reload", "60 fps"],
    photo: "",
    photoAlt: "Portrait of Shraddha Pandey",
    caption: "Based in Lucknow · Open to opportunities",
    paragraphs: [                                    // TODO: tweak the wording so it sounds like you
      "I'm Shraddha, a Flutter developer from Lucknow with 3+ years of experience building production mobile apps across four companies.",
      "I've shipped apps for EV charging and car care, geospatial field navigation, social media, food ordering and book publishing, working across GetX, BLoC and Provider, Firebase and Supabase, real-time APIs, maps and payments.",
    ],
    facts: [
      { label: "Focus",      value: "Flutter · Dart" },
      { label: "Backend",    value: "Firebase · Supabase" },
      { label: "Based in",   value: "Lucknow, India" },
      { label: "Experience", value: "3+ years" },
    ],
  },

  contact: {
    headline: "Let's build something",
    highlight: "great.",
    sub: "Have a project, opportunity or idea? My inbox is open, and I'd love to hear about it.",
    // Optional: a Formspree/Getform endpoint to receive messages directly.
    // Leave "" to open the visitor's email app instead.
    formEndpoint: "",
  },

  // Supported icons: github, linkedin, x, instagram, medium, dribbble, mail
  socials: [
    { label: "GitHub",   icon: "github",   url: "https://github.com/shraddha137p" },
    { label: "LinkedIn", icon: "linkedin", url: "https://www.linkedin.com/in/shraddha-pandey-29b144208" },
    { label: "Email",    icon: "mail",     url: "mailto:shraddhapandey103@gmail.com" },
  ],
};
