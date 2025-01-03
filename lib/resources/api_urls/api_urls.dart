class ApiUrls{
  static const String baseUrl='https://api.evento.ink';
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
  static const String getEventCategories='/events/categories/';
  static const String getTrendingEvents='/events/trending-events/';
  static const String getWishlistedEvents='/events/wishlist/';
  static String byLocation (int id){
    return '${ApiUrls.baseUrl}/events/by_location/$id/';
  }
  static String eventDetails(int id){
    return '${ApiUrls.baseUrl}/events/event_details/$id';
  }
  static String addToWishlist(int id)=>'/events/wishlist/$id/';
  static String removeFromWishlist(int id)=>'/events/wishlist/$id/';
  static String bookATicket='/events/ticket/booking/';
  static String confirmTicket='/events/confirm-payment/';
  static String getBookedTickets='/accounts/user-tickets/';
  static String updateProfile='/accounts/user-profile/';
}