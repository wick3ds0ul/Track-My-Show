//Form validation-Email
String validatePassword(String value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  } else if (value.length < 6) {
    return 'Password must be greater than 6 character';
  } else
    return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null)
    return 'Enter a valid email address';
  else
    return null;
}

String revalidatePassword(String value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  } else if (value.length < 6) {
    return 'Password must be greater than 6 character';
  } else
    return null;
}
