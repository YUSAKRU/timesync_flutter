import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.dev')
abstract class EnvDev {
  @EnviedField(varName: 'API_BASE_URL', obfuscate: true)
  static final String apiBaseUrl = _EnvDev.apiBaseUrl;

  @EnviedField(varName: 'GOOGLE_MAPS_KEY', obfuscate: true)
  static final String googleMapsKey = _EnvDev.googleMapsKey;
}

@Envied(path: '.env.prod')
abstract class EnvProd {
  @EnviedField(varName: 'API_BASE_URL', obfuscate: true)
  static final String apiBaseUrl = _EnvProd.apiBaseUrl;

  @EnviedField(varName: 'GOOGLE_MAPS_KEY', obfuscate: true)
  static final String googleMapsKey = _EnvProd.googleMapsKey;
}
