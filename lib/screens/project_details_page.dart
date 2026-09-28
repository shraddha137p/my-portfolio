import 'package:flutter/material.dart';
import 'package:porfolio/data/portfolio_data.dart';
import 'package:porfolio/models/project_model.dart';
import 'package:porfolio/utils/link_helper.dart';
import 'package:porfolio/theme/app_theme.dart';

class ProjectDetailsPage extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFF05070B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(project.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: ColoredBox(
                      color: const Color(0xFF101722),
                      child: Image.asset(
                        project.image,
                        fit: BoxFit.contain,
                        height: 360,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => const SizedBox(
                          height: 360,
                          child: Center(
                            child: Icon(Icons.smartphone_rounded, size: 52, color: AppTheme.accent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (project.galleryImages.isNotEmpty) ...[
                    const SizedBox(height: 28),
                    _sectionTitle('Screenshots'),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.35,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: project.galleryImages.length,
                      itemBuilder: (context, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ColoredBox(
                          color: const Color(0xFF101722),
                          child: Image.asset(project.galleryImages[index], fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(project.category, style: textTheme.labelLarge),
                  const SizedBox(height: 8),
                  Text(project.title, style: textTheme.displaySmall),
                  const SizedBox(height: 16),
                  Text(project.description, style: textTheme.bodyLarge),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: project.technologies
                        .map((tech) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF101722),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(color: Colors.white.withOpacity(0.08)),
                              ),
                              child: Text(tech, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 28),
                  if (project.keyFeatures.isNotEmpty) ...[
                    _sectionTitle('Key Features'),
                    const SizedBox(height: 12),
                    ...project.keyFeatures.map((feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle_rounded, color: AppTheme.accent, size: 18),
                              const SizedBox(width: 10),
                              Expanded(child: Text(feature, style: textTheme.bodyLarge)),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                  ],
                  if (project.responsibilities.isNotEmpty) ...[
                    _sectionTitle('Responsibilities'),
                    const SizedBox(height: 12),
                    ...project.responsibilities.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• ', style: TextStyle(color: AppTheme.accent, fontSize: 20)),
                              Expanded(child: Text(item, style: textTheme.bodyLarge)),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                  ],
                  _sectionTitle('Technology Stack'),
                  const SizedBox(height: 12),
                  Text(project.technologies.join(' • '), style: textTheme.bodyLarge),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      if (project.playStoreUrl != null)
                        _actionButton(
                          'View on Play Store',
                          () => LinkHelper.openPlayStore(project.playStoreUrl!),
                        ),
                      if (project.githubUrl != null)
                        _actionButton(
                          'GitHub',
                          () => LinkHelper.openGitHub(),
                        ),
                      _actionButton('Back to portfolio', () => Navigator.pop(context)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _actionButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppTheme.accent,
        foregroundColor: const Color(0xFF05070B),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}
