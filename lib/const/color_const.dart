import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:io';

const YELLOW = Color(0xfffbed96);
const BLUE = Color(0xffabecd6);
const BLUE_DEEP = Color(0xffA8CBFD);
const BLUE_LIGHT = Color(0xffAED3EA);
const PURPLE = Color(0xffccc3fc);
const RED = Color(0xffF2A7B3);
const GREEN = Color(0xffc7e5b4);
const RED_LIGHT = Color(0xffFFC3A0);
const TEXT_BLACK = Color(0xFF353535);
const TEXT_BLACK_LIGHT = Color(0xFF34323D);

Color lightGreen = Color(0xFF95E08E);
Color lightBlueIsh = Color(0xFF33BBB5);
Color darkGreen = Color(0xFF00AA12);
Color backgroundColor = Color(0xFFEFEEF5);
Color accentColor = Color(0xFF52DA75);
Color primaryColor = Color(0xFF32C96C);

const Color prodQuantColor = Colors.grey;
final Color prodMrpColor = Colors.grey;
final Color prodSpColor = Colors.black;
const Color prodDiscountColor = Colors.blue;

const Color addButtonBorderColor = Colors.teal;

TextStyle titleStyleWhite = GoogleFonts.lato(color: Colors.white, fontSize: 25);
TextStyle subStyleWhite = GoogleFonts.lato(color: Colors.white, fontSize: 12);

TextStyle jobCardTitileStyleBlue = new TextStyle(
    fontFamily: 'Avenir',
    color: lightBlueIsh,
    fontWeight: FontWeight.bold,
    fontSize: 12);
TextStyle jobCardTitileStyleBlack = new TextStyle(
    fontFamily: 'Avenir',
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 12);
TextStyle titileStyleLighterBlack = new TextStyle(
    fontFamily: 'Avenir',
    color: Color(0xFF34475D),
    fontWeight: FontWeight.bold,
    fontSize: 20);

TextStyle titileStyleBlack = new TextStyle(
    fontFamily: 'Helvetica',
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20);
TextStyle salaryStyle = new TextStyle(
    fontFamily: 'Avenir',
    color: darkGreen,
    fontWeight: FontWeight.bold,
    fontSize: 12);

Text verifiedText = Text('Verified Account',
    style: GoogleFonts.roboto(color: Colors.green, fontSize: 18));

Text notVerifiedText = Text('Account Not Verified',
    style: GoogleFonts.roboto(color: Colors.red, fontSize: 18));

TextStyle profileContent = GoogleFonts.ptSans(
  fontSize: 16,
);

TextStyle covidHead = GoogleFonts.lato(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white);



TextStyle covidDists = GoogleFonts.lato(fontSize: 15,color: Colors.indigoAccent);

TextStyle covidTotal = GoogleFonts.lato(fontSize: 15,color: Colors.orangeAccent);
TextStyle covidActive = GoogleFonts.lato(fontSize: 15,color: Colors.red);

TextStyle covidRecov = GoogleFonts.lato(fontSize: 15,color: Colors.green);
TextStyle covidDeceas = GoogleFonts.lato(fontSize: 15,color: Colors.grey);



//Phone Login
const Color phoneLoginIcon = Colors.deepPurple;
const Color phoneLoginText = Colors.deepPurple;

//Icons
Icon cancelRedIcon = Icon(Icons.cancel, color: Colors.redAccent);
Icon verifiedGreenIcon = Icon(Icons.verified_user, color: Colors.green);
