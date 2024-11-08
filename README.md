<!--
A Flutter package for creating a customizable and animated bank card widget. This widget allows users to flip between the front and back sides of a bank card, displaying card details like the card number, cardholder's name, expiration date, CVV, and more. The widget also includes input fields for card details with formatters ensuring consistent and valid entries.
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

**Animated Card Flip**: Users can flip between the front and back of the card with smooth animations.
**Customizable UI**: Customize the appearance of the front and back sides of the card, including gradients and shadow effects.
**Input Fields with Formatters**: Card number, expiration date, and CVV input fields with formatters to ensure proper formatting.
**Responsive Design**: Built to work smoothly across various screen sizes.
**State Management with GetX**: The card details are managed with GetX for easy state management.
## Getting started

To get started, add the image_test_package (or the package name you choose) to your pubspec.yaml:
`dependencies:
image_test_package: ^1.0.0`
Then, run:
`flutter pub get
`

## Usage
Here’s a simple example of how to use the BankCard widget in your Flutter app:

`import 'package:flutter/material.dart';
import 'package:image_test_package/bank_card_ui.dart';
void main() {
runApp(MyApp());
}
class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
home: Scaffold(
appBar: AppBar(title: Text('Bank Card UI')),
body: Center(
child: BankCard(),),),); } }`

## Customization
You can customize the card details by setting the controller's values. For example:

`final BankCardController controller = Get.put(BankCardController());
// Set custom values
controller.cardNumber.value = '1234 5678 9876 5432';
controller.cardHolder.value = 'John Doe';
controller.expiryDate.value = '12/25';
controller.cvv.value = '123';`

## Additional information
**Documentation**: For more details, including advanced usage and customization, refer to the documentation here.
**Contributing**: Contributions are welcome! Feel free to submit a pull request with improvements or bug fixes.
**Issues**: If you encounter any issues, please report them on the GitHub Issues page.
**Support**: For further support, feel free to reach out via GitHub.


# bank_card_ui
