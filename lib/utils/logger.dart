class Logger {
  static void info(String message) {
    print('\x1B[34mℹ️  $message\x1B[0m');
  }

  static void success(String message) {
    print('\x1B[32m✅ $message\x1B[0m');
  }

  static void warning(String message) {
    print('\x1B[33m⚠️  $message\x1B[0m');
  }

  static void error(String message) {
    print('\x1B[31m❌ $message\x1B[0m');
  }
}