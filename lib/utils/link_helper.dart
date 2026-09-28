import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'resume_download.dart';

class LinkHelper {
  static const String email = 'shraddhapandey103@gmail.com';
  static const String github = 'https://github.com/shraddha137p';
  static const String linkedin = 'https://www.linkedin.com/in/shraddha-pandey-29b144208/';
  static const String resumeAsset = 'assets/resume/resume.pdf';

  static Future<void> openEmail() async => _open('mailto:$email');

  static Future<void> openGitHub() async => _open(github);

  static Future<void> openLinkedIn() async => _open(linkedin);

  static Future<void> openResume() async {
    final bytes = await rootBundle.load(resumeAsset);
    await downloadResume(bytes.buffer.asUint8List(), 'Shraddha-Pandey-Resume.pdf');
  }

  static Future<void> openPlayStore(String url) async => _open(url);

  static Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
