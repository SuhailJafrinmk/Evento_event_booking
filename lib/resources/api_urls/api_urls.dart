class ApiUrls{
  static const String baseUrl='https://evento-backend-new.onrender.com';
  static const String emailOtpRequest='/accounts/email-otp-request/';
  static const String emailOtpVerification='/accounts/email-otp-verification/';
  static const String phoneOtpRequest='/accounts/phone-otp-request/';
  static const String phoneOtpVerification='/accounts/phone-otp-verification/';
  static const String resentOtp='/accounts/resend-otp/';
  static const String googleAuthentication='/accounts/google/oauth1/';
  static const String updateEmail='/accounts/update-email/';
  static const String updatePhone='/accounts/update-phone/';
  static const String updatePhoneVerify='/accounts/verify-update-phone-otp/';
  static const String updateEmailVerify='/accounts/verify-update-phone-otp/';
  static const String refreshToken='/api/token/refresh/';
  static const String getEvents='/events/list_all_events/';
  static const String getLocations='/events/locations/';
  static const String eventDetails='/events/event_details/{id}/';
  static const String getEventCategories='/events/categories/';
  static const String eventsByLocation='/events/by_location/{location_id}/';
  static const String getTrendingEvents='/events/trending-events/';
  static const String getWishlistedEvents='/events/wishlist/';
  static const String addToWishlist='/events/wishlist/';
}