class ApiConstants {
  static const String baserUrl = "https://sma.alwafierp.com/api";
  static const String notifications = "/Notification";
  static const String markRead = "/Notification/markAllAsRead";
  static const String unreadCount = "/Notification/unreadCount";





  static  bool valid = false;
}

class ApiKey {
  static String id = "id";
  static String name = "name";
  static String phone = "phone";
  static String authorization = "Authorization";
  static String status = "status";
  static String message = "message";
  static String data = "data";
  static String img = "img";
  static String password = "password";
  static String language = "language";
  static String email = "email";
  static String tokenNewPassword = "tokenNewPassword";
  static String idAddHome = "idAddHome";
  static String fcm = "fcm";



}
class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}