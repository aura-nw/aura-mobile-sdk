import 'package:local_auth/local_auth.dart';

class AuraInternalVerifyAuth {
  static AuraInternalVerifyAuth ?_auth;

  factory AuraInternalVerifyAuth(){
    _auth??=AuraInternalVerifyAuth._();

    return _auth!;
  }

  AuraInternalVerifyAuth._();

  Future<bool> authenticateWithBiometrics({String? localizedReason}) async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    try {
      final bool canAuthenticateWithBiometrics = await localAuthentication.canCheckBiometrics;

      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await localAuthentication.isDeviceSupported();

      bool isAuthenticated = false;

      if (canAuthenticate) {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason:
              localizedReason ?? 'Please complete the biometrics to proceed.',
          options: const AuthenticationOptions(
            stickyAuth: true,
          ),
        );
      }

      return isAuthenticated;
    } catch (e) {
      rethrow;
    }
  }
}
