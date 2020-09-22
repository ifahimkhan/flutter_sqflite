
class ValidationMixin{

  String ValidateEmail (String value) {
    if (value.isEmpty) {
      return 'Please Enter Email Address';
    } else if (!value.contains("@")) {
      return "Please Enter Valid Email!";
    }
    return null;
  }

  String ValidatePassword (String value) {
    if (value.isEmpty) {
      return 'Please Enter Password';
    }
    return null;
  }
}