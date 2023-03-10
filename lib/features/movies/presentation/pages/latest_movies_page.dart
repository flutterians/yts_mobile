import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/features/auth/auth.dart';
import 'package:yts_mobile/features/movies/movies.dart';

class LatestMoviesPage extends ConsumerWidget {
  const LatestMoviesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollControllerProvider = ref.watch(moviesScrollControllerProvider);
    final isDarkTheme = ref.watch(themeProvider).isDarkTheme;
    final isSkipped = ref.watch(skippedProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () => scrollControllerProvider.animateTo(
              scrollControllerProvider.position.minScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            child: Image.asset(AppAssets.appLogo),
          ),
        ),
        actions: [
          Switch.adaptive(
            value: isDarkTheme,
            onChanged: (isDarkModeEnabled) {
              ref.read(themeProvider.notifier).updateCurrentThemeMode(
                    isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
                  );
            },
          ),
          if (!isSkipped)
            IconButton(
              onPressed: () async {
                final confirm =
                    await LogoutAlertDialogue.showAlert(context) ?? false;
                if (confirm) {
                  await ref.read(loginControllerProvider.notifier).logout();
                }
              },
              icon: const Icon(Icons.lock_open_rounded),
            )
        ],
      ),
      body: const LatestMoviesGridView(),
    );
  }
}
