import 'dart:typed_data';

import 'package:url_launcher/url_launcher.dart';

Future<void> downloadResume(Uint8List bytes, String filename) async {
  final uri = Uri.dataFromBytes(
    bytes,
    mimeType: 'application/pdf',
    parameters: {'filename': filename},
  );
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not open resume');
  }
}