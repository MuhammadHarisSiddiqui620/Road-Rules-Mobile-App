import 'package:flutter/material.dart';

const primaryTextStyle = TextStyle(
    color: Color(0xFF141522),
    fontSize: 30,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const secondaryTextStyle = TextStyle(
    color: Color(0xFF202020),
    fontSize: 40,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w700);

final primaryButton = ElevatedButton.styleFrom(
  minimumSize: Size(100, 52),
  backgroundColor: Color(0xFF0E0F23), // make button background transparent
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
);

const thirdlyTextStyle = TextStyle(
    color: Color(0xFF202020),
    fontSize: 18,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const searchText = TextStyle(
    color: Color(0xFF000000),
    fontSize: 17,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w300);

const birthdaySecondaryText = TextStyle(
    color: Color(0xFF000000),
    fontSize: 16,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const descriptionText = TextStyle(
    color: Color(0xFF000000),
    fontSize: 16,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const postCardInputText = TextStyle(
    color: Color(0xFF000000),
    fontSize: 13,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const searchScreen = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const mainScreenText = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w600);

const questionHeader = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const questionSubHeader = TextStyle(
    color: Color(0xFFFE3B01),
    fontSize: 20,
    decoration: TextDecoration.underline,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);
