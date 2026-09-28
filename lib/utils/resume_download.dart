import 'dart:typed_data';

import 'resume_download_stub.dart'
    if (dart.library.html) 'resume_download_web.dart' as implementation;

Future<void> downloadResume(Uint8List bytes, String filename) {
  return implementation.downloadResume(bytes, filename);
}