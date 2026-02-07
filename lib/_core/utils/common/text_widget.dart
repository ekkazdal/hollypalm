import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hollypalm/_features/data/enums/holly_text_type.dart';

class HollyText extends StatelessWidget {
  const HollyText({super.key, required this.text, this.type = HollyTextType.body, this.color, this.textAlign, this.maxLines, this.overflow});

  final String text;
  final HollyTextType type;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  TextStyle _style() {
    switch (type) {
      case HollyTextType.title:
        return GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, height: 1.3);
      case HollyTextType.subtitle:
        return GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500);
      case HollyTextType.price:
        return GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700);
      case HollyTextType.caption:
        return GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500);
      case HollyTextType.button:
        return GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600);
      case HollyTextType.body:
        return GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, height: 1.43);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: _style().copyWith(color: color),
    );
  }
}
