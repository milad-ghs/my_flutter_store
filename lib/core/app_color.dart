import 'package:flutter/material.dart';

class AppColor {
  // ==========================
  // 1. رنگ‌های اصلی (Primary)
  // ==========================
  /// هویت بصری اپ، دکمه‌ها و المان‌های مهم
  static const Color primary = Color(0xFFF67952); // نارنجی اصلی
  static const Color primaryLight = Color(0xFFFFA078); // نسخه روشن برای hover یا بک‌گراند
  static const Color primaryDark = Color(0xFFC25B3D);  // نسخه تیره برای حالت فعال یا سایه
  static const Color primaryText = Colors.white;      // متن روی Primary

  // ==========================
  // 2. رنگ ثانویه / Accent
  // ==========================
  /// برای دکمه‌های ثانویه، هایلایت، لینک‌ها
  static const Color secondary = Color(0xFF4E5AE8); // آبی
  static const Color secondaryLight = Color(0xFF6D7CFF);
  static const Color secondaryDark = Color(0xFF373FBE);
  static const Color accent = Color(0xFFFF4667);    // صورتی/قرمز برای جلب توجه

  // ==========================
  // 3. رنگ پس‌زمینه (Background)
  // ==========================
  /// پایه صفحات، کارت‌ها، بخش‌های فرعی
  static const Color backgroundLight = Color(0xFFFBFBFD); // روشن و ملایم
  static const Color backgroundMedium = Color(0xFFF2F2F2); // کارت‌ها یا بخش‌های فرعی
  static const Color backgroundDark = Color(0xFFE0E0E0); // سایه‌ها یا بخش‌های برجسته

  // ==========================
  // 4. رنگ متن
  // ==========================
  /// متن اصلی، کم اهمیت، روی المان‌های رنگی
  static const Color textPrimary = Color(0xFF1B1B1B);   // متن اصلی روی پس‌زمینه روشن
  static const Color textSecondary = Color(0xFF757575); // متن کم اهمیت
  static const Color textOnPrimary = Colors.white;      // متن روی دکمه‌ها یا المان‌های رنگی
  static const Color textOnSecondary = Colors.white;    // متن روی رنگ ثانویه

  // ==========================
  // 5. رنگ وضعیت / Feedback
  // ==========================
  /// موفقیت، هشدار، خطا، ستاره‌ها، نوتیفیکیشن
  static const Color success = Color(0xFF99C24D);   // سبز موفقیت
  static const Color successLight = Color(0xFFB8E27D);
  static const Color warning = Color(0xFFEEA638);   // زرد هشدار
  static const Color warningLight = Color(0xFFF5C16B);
  static const Color error = Color(0xFFFF4667);     // قرمز خطا
  static const Color errorLight = Color(0xFFFF738B);
  static const Color star = Color(0xFFFFDF00);      // رنگ ستاره / امتیاز

  // ==========================
  // 6. گرادیانت‌ها
  // ==========================
  /// برای بک‌گراندهای خاص یا آواتار
  static final List<Color> avatarGradient = [
    primary.withOpacity(0.05),
    primary.withOpacity(0.5),
    primary,
  ];

  static final List<Color> buttonGradient = [
    primaryLight,
    primary,
    primaryDark,
  ];

  // ==========================
  // 7. رنگ‌های کمکی / Optional
  // ==========================
  /// رنگ‌های کمکی برای لینک‌ها، آیکون‌ها، جزئیات
  static const Color lightBlue = Color(0xFF48CAE4); // لینک‌ها و المان‌های کم اهمیت
  static const Color softGreen = Color(0xFFA5D6A7); // پس‌زمینه کارت‌های کوچک یا تگ‌ها
  static const Color softPink = Color(0xFFFFC1C1);  // هشدارهای غیر حیاتی یا برجسته‌سازی

// ==========================
// 8. پیشنهاد کاربرد دسته‌ها
// ==========================
/*
  Primary: هدر، دکمه اصلی، المان مهم
  Secondary / Accent: دکمه ثانویه، لینک، هایلایت
  Background: صفحات، کارت‌ها، بخش‌های فرعی
  Text: متن اصلی، کم اهمیت، روی المان رنگی
  Status / Feedback: موفقیت، هشدار، خطا، ستاره
  Gradient: آواتار، بک‌گراندهای ویژه
  Optional: لینک‌ها، جزئیات کوچک، المان‌های کم اهمیت
  */
}
