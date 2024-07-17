import 'dart:developer';

class HideMeLogger {
  static logMessage({required String message}) {
    log("""
        ~~~~~~~~~~~~MESSAGE~~~~~~~~~~~~~~~
                 Message: $message 
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
""");
  }

  static logWithException({required String message, required Object e}) {
    log("""
       ======================ERROR===========================
          Message: $message || Exception: ${e.toString()} 
       ======================================================
""");
  }
}
