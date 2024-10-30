import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenSansText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign alignment;
  final Color textColor;
  final double fontSize;

  OpenSansText.regular(this.text, this.textColor, this.fontSize,{Key? key, TextAlign align = TextAlign.start})
      : style = regularOpenSansStyle(textColor, fontSize, FontWeight.w400), alignment = align, super(key: key);

  OpenSansText.medium(this.text, this.textColor, this.fontSize, {Key? key, TextAlign align = TextAlign.start})
      : style = mediumOpenSansStyle(textColor, fontSize, FontWeight.w500), alignment = align, super(key: key);

  OpenSansText.bold(this.text, this.textColor, this.fontSize, {Key? key, TextAlign align = TextAlign.start})
      : style = boldSOpenSansStyle(textColor, fontSize, FontWeight.w700), alignment = align, super(key: key);

  OpenSansText.semiBold(this.text, this.textColor, this.fontSize, {Key? key, TextAlign align = TextAlign.start})
      : style = semiBoldSOpenSansStyle(textColor, fontSize, FontWeight.w600), alignment = align, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: alignment,
    );
  }
}

///Font Weight
//Regular w400
//Medium w500
//Bold w700
//SemiBold w600

TextStyle regularOpenSansStyle(color, fontSize, FontWeight weight) => GoogleFonts.openSans(fontSize: fontSize ?? 14.0, color: color, fontStyle: FontStyle.normal, fontWeight: weight);
TextStyle mediumOpenSansStyle(color, fontSize, FontWeight weight) => GoogleFonts.openSans(fontSize: fontSize?? 16.0, color: color, fontStyle: FontStyle.normal, fontWeight: weight);
TextStyle boldSOpenSansStyle(color, fontSize, FontWeight weight) => GoogleFonts.openSans(fontSize: fontSize?? 18.0, color: color, fontStyle: FontStyle.normal, fontWeight: weight);
TextStyle italicOpenSansStyle(color, fontSize, FontWeight weight) => GoogleFonts.cabin(fontSize: fontSize ?? 14.0, color: color, fontStyle: FontStyle.italic, fontWeight: weight);
TextStyle semiBoldSOpenSansStyle(color, fontSize, FontWeight weight) => GoogleFonts.openSans(fontSize: fontSize?? 18.0, color: color, fontStyle: FontStyle.normal, fontWeight: weight);
