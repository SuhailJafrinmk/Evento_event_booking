import 'dart:developer' as developer;

const String _red = '\x1B[31m'; // Red
const String _green = '\x1B[32m'; // Green
const String _yellow = '\x1B[33m'; // Yellow
const String _reset = '\x1B[0m';  // Reset color
const String _black = '\x1B[30m'; 
const String _blue = '\x1B[34m'; 
const String _magenta = '\x1B[35m'; 
const String _cyan = '\x1B[36m'; 
const String _white = '\x1B[37m'; 


void logInfo(String message) {
  developer.log('$_green$message$_reset', name: 'INFO');
}

void logWarning(String message) {
  developer.log('$_yellow$message$_reset', name: 'WARNING');
}

void logError(String message) {
  developer.log('$_red$message$_reset', name: 'ERROR');
}
