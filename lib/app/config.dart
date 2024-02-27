import 'flavor.dart';

class AppConfig {
  static const String appName = 'YOUAPP TEST';
  static const String fontFamily = 'Inter';

  static const FlavorConfig<String> baseUrl = FlavorConfig<String>(
    prod: 'https://techtest.youapp.ai/api',
  );

  static const bool autoStringifyEquatable = true;
  static const bool transparentStatusBar = true;
}

class FlavorConfig<T> {
  const FlavorConfig({
    required this.prod,
    this.fallback,
  }) : assert(
   prod == null  ? fallback != null : true,
  '[fallback]cannot be null if there is one flavor whose value is null',
  );

  final T? prod;
  final T? fallback;

  T get value {
    switch (F.flavor) {
      case Flavor.prod:
        return prod ?? fallback!;
    }
  }
}
