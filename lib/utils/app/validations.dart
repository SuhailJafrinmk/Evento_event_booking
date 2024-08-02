class Validations{
   static String? emailValidation(value) {
    final emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailPattern.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

    static String? phoneNumberValidate(value) {
    final RegExp pattern = RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');
    if (!pattern.hasMatch(value)) {
      return 'Invalid mobile number';
    }
    return null;
  }
}