import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({
    required this.title,
    required this.body,
    this.actions,
    this.fallbackRoute = AppRoutes.home,
    this.showBackButton = true,
    super.key,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final String fallbackRoute;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: showBackButton ? 0 : NavigationToolbar.kMiddleSpacing,
        leading: showBackButton
            ? IconButton(
                tooltip: 'Back',
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    context.pop();
                  } else {
                    context.go(fallbackRoute);
                  }
                },
              )
            : null,
        title: Text(title),
        actions: actions,
      ),
      body: SafeArea(child: body),
    );
  }
}
