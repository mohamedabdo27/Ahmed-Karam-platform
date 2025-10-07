String? validatePassword({required String? value}) {
  if (value?.isEmpty ?? true) {
    return 'Password must not be empty';
  }
  if (value!.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}

// String? validateConfirmPassword(
//     {required String? value, required String? password}) {
//   if (value?.isEmpty ?? true) {
//     return 'Password must not be empty';
//   }
//   if (value!.length < 8) {
//     return 'Password must be at least 8 characters';
//   }
//   if (value != password) {
//     return 'Passwords do not match';
//   }

// return null;
// }

String? validateEmail({required String? value}) {
  if (value?.isEmpty ?? true) {
    return 'Please enter an email';
  }
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(value!)) {
    return 'Enter a valid email';
  }
  return null;
}

String? validateText({required String? value, required String title}) {
  if (value?.isEmpty ?? true) {
    return '$title must not be empty';
  }
  if (value!.length < 8) {
    return '$title must be at least 8 characters';
  }
  return null;
}

String? validateTextField({required String? value, required String title}) {
  if (value?.isEmpty ?? true) {
    return '$title must not be empty';
  }
  // if (value!.length < 8) {
  //   return '$title must be at least 8 characters';
  // }
  return null;
}
