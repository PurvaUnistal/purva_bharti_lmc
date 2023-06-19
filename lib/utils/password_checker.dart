// import 'package:flutter/material.dart';
//
// class PasswordChecker extends StatelessWidget {
//   PasswordChecker(this._passwordChecker);
//   final PasswordValidationModel _passwordChecker;
//   // final _passwordChecker = PasswordValidationModel();
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextButton.icon(
//           icon: _passwordChecker.hasUppercase == true
//               ? Icon(Icons.done)
//               : Icon(Icons.clear),
//           label: Text(
//             'Must have at least one upperCase letter',
//           ),
//           onPressed: () {},
//         ),
//         TextButton.icon(
//           icon: _passwordChecker.hasLowercase == true
//               ? Icon(Icons.done)
//               : Icon(Icons.clear),
//           label: Text(
//             'Must have at least one lowerCase letter',
//           ),
//           onPressed: () {},
//         ),
//         TextButton.icon(
//           icon: _passwordChecker.hasDigits == true
//               ? Icon(Icons.done)
//               : Icon(Icons.clear),
//           label: Text(
//             'Must have at least one number',
//           ),
//           onPressed: () {},
//         ),
//         TextButton.icon(
//           icon: _passwordChecker.hasSpecialCharacters == true
//               ? Icon(Icons.done)
//               : Icon(Icons.clear),
//           label: Text(
//             'Must have at least one special character',
//           ),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }
// }