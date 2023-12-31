part of styles;

class AppFonts {
  static TextStyle getAppFont({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
  }) {
     return TextStyle(
      fontFamily: 'SFPro', 
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

class HeaderFonts {
  static final primaryText = AppFonts.getAppFont(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: TextColor.secondaryColor,
  );
  static final seconadryText = AppFonts.getAppFont(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: TextColor.ternaryColor,
  );
}
class TextFonts {
  static final primaryText = AppFonts.getAppFont(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: TextColor.primaryColor,
  );
  static final seconadryText = AppFonts.getAppFont(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: TextColor.primaryColor,
  );
   static final ternaryText = AppFonts.getAppFont(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: TextColor.ternaryColor,
  );

    static final specialText = AppFonts.getAppFont(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: TextColor.primaryColor,
  );
}
class HintFonts {
  static final primaryText = AppFonts.getAppFont(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: HintColor.primaryColor,
  );

}

