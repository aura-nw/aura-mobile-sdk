///region type
enum AuraWalletEnvironment {
  mainNet,
  testNet,
}

///endregion

abstract class AuraMobileSdk<T> {
  bool isReadyInit = false;
  Future<void> init({
    AuraWalletEnvironment environment = AuraWalletEnvironment.testNet,
    T ?parameter,
  });
}