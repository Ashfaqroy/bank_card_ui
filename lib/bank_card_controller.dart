import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankCardController extends GetxController {
  // Observables for the text field values
  RxString cardNumber = ''.obs;
  RxString cardHolder = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cvv = ''.obs;
  RxString logo = '/Users/ashfaq/packages/image_test_package/assets/images/visa.png'.obs; // Default Visa logo

  // Controllers for text fields
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    // Set up listeners to update observables whenever text changes
    cardNumberController.addListener(() {
      cardNumber.value = cardNumberController.text;
      updateLogo(cardNumber.value);
    });
    cardHolderController.addListener(() => cardHolder.value = cardHolderController.text);
    expiryDateController.addListener(() => expiryDate.value = expiryDateController.text);
    cvvController.addListener(() => cvv.value = cvvController.text);
  }

  void updateLogo(String number) {
    var types = detectCCType(number);

    if (number.isNotEmpty) {
      if (types.contains(CreditCardType.visa())) {
        logo.value = '/Users/ashfaq/packages/bank_card_ui/assets/images/visa.png';
      } else if (types.contains(CreditCardType.mastercard())) {
        logo.value = '/Users/ashfaq/packages/bank_card_ui/assets/images/master.png';
      } else if (types.contains(CreditCardType.americanExpress())) {
        logo.value = '/Users/ashfaq/packages/bank_card_ui/assets/images/amex.png';
      } else if (types.contains(CreditCardType.discover())) {
        logo.value = '/Users/ashfaq/packages/bank_card_ui/assets/images/discover.png';
      } else if (types.contains(CreditCardType.jcb())) {
        logo.value = '/Users/ashfaq/packages/bank_card_ui/assets/images/jcb.png';
      } else if (types.contains(CreditCardType.dinersClub())) {
        logo.value = '/Users/ashfaq/packages/bank_card_ui/assets/images/diners.png';
      } else {
        logo.value = '/Users/ashfaq/packages/bank_card_ui/assets/images/default.png';
      }
    }
  }

  @override
  void onClose() {
    // Dispose of controllers when no longer needed
    cardNumberController.dispose();
    cardHolderController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.onClose();
  }
}
