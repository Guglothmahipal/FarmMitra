import 'package:farmmitra_app/shared/widgets/app_page_scaffold.dart';
import 'package:flutter/material.dart';

class SimpleInfoPage extends StatelessWidget {
  const SimpleInfoPage({
    required this.title,
    required this.message,
    this.icon = Icons.info_outline,
    super.key,
  });

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppPageScaffold(
      title: title,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 36),
                  const SizedBox(height: 16),
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(message),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
