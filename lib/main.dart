import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_overflow_app/bloc/search_bloc.dart';
import 'package:stack_overflow_app/helper/Themes/app_colors.dart';
import 'package:stack_overflow_app/helper/Themes/theme.dart';
import 'package:stack_overflow_app/helper/nav_helper.dart';
import 'package:stack_overflow_app/helper/nav_observer.dart';
import 'package:stack_overflow_app/helper/utils.dart';

void main() {
  // Add license for Google Fonts
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/licence/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  // Run the app
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Provide SearchBloc to all widgets in the app
      providers: [
        BlocProvider(create: (_) => SearchBloc()),
      ],
      child: MaterialApp(
        // Use NavObserver to observe navigation events
        navigatorObservers: [NavObserver.instance],
        // Set the navigation key to NavObserver.navKey
        navigatorKey: NavObserver.navKey,
        // Hide the debug banner
        debugShowCheckedModeBanner: false,
        // Set the title of the app
        title: 'Stack Overflow',
        // Set the light theme with custom color scheme and text theme
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: textTheme,
        ),
        // Set the dark theme with custom color scheme and text theme
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: textTheme,
        ),
        // Specify the initial route of the app
        initialRoute: route,
        // Generate routes for the app based on specified routes
        onGenerateRoute: generateRoute,
        // Build the widget tree for the app
        builder: (context, child) {
          return SafeArea(
            // Show a loading indicator until Google Fonts are loaded asynchronously
            child: FutureBuilder(
              future: googleFontsPending,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  // Show a loading indicator if Google Fonts are still loading
                  return Scaffold(
                    body: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }
                // Return the child widget once Google Fonts are loaded
                return Scaffold(body: child ?? Container());
              },
            ),
          );
        },
      ),
    );
  }
}
