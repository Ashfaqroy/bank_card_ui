library image_test_package;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'bank_card_controller.dart';

// Controller for managing bank card details

// Main BankCard Widget
// ignore: must_be_immutable
class BankCard extends StatelessWidget {
  final BankCardController controller = Get.put(BankCardController());
  bool isFront = true;
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  BankCard({super.key});

  // Methods to access card details
  String getCardNumber() => controller.cardNumber.value;
  String getExpiryDate() => controller.expiryDate.value;
  String getCardHolder() => controller.cardHolder.value;
  String getCVV() => controller.cvv.value;
  @override
  Widget build(BuildContext context) {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: Scaffold.of(context), // Use an appropriate vsync
    );
    _flipAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    return GestureDetector(
      onTap: flipCard,
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective
              ..rotateY(_flipAnimation.value * pi), // Flip the card
            child: _flipAnimation.value < 0.5
                ? buildFrontCard() // Front side
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(-1.0, 1.0, 1.0), // Flip the back side
                    child: buildBackCard(), // Back side
                  ),
          );
        },
      ),
    );
  }

  void flipCard() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    isFront = !isFront;
  }

Widget buildFrontCard() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    elevation: 8,
    child: Container(
      height: 200,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC69C6D), Color(0xFF9E7B4F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Obx(() => Image.asset(
                  controller.logo.value,
                  height: 40,
                )),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.cardNumberController,
            keyboardType: TextInputType.number,
            maxLength: 19,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
              CardNumberInputFormatter(),
            ],
            decoration: const InputDecoration(
              counterText: "",
              hintText: '**** **** **** 5678',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: controller.cardHolderController,
                  decoration: const InputDecoration(
                    hintText: 'Card Holder',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller.expiryDateController,
                  maxLength: 5,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                    LengthLimitingTextInputFormatter(5),
                    DateInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: 'MM/YY',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildBackCard() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    elevation: 8,
    child: Container(
      height: 200,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: const LinearGradient(
          colors: [Color(0xFFC69C6D), Color(0xFF9E7B4F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            color: Colors.black,
            margin: const EdgeInsets.only(bottom: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: controller.cvvController,
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: 'CVV',
                    hintStyle: TextStyle(color: Colors.black54),
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(width: 16),
              GetBuilder<BankCardController>(
                builder: (controller) => Text(
                  'Expiry: ${controller.expiryDate.isNotEmpty ? controller.expiryDate : 'MM/YY'}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const Spacer(),
          GetBuilder<BankCardController>(
            builder: (controller) => Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '**** **** **** ${controller.cardNumber.isNotEmpty ? controller.cardNumber.substring(controller.cardNumber.value.length - 4) : '5678'}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textDirection: TextDirection.ltr,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}

// Input formatter for card number
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    StringBuffer newText = StringBuffer();
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newText.write(' ');
      }
      newText.write(digitsOnly[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

// Input formatter for expiry date
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    StringBuffer newText = StringBuffer();
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9/]'), '');

    // If the old value and new value are the same, the user is pressing backspace
    if (oldValue.text.length > newValue.text.length) {
      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2 && digitsOnly.length < 5) {
        newText.write('/');
      }
      newText.write(digitsOnly[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

