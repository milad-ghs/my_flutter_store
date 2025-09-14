import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store/core/constant.dart';
import 'package:store/providers/auth_provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/dialog_utils.dart';
import 'login.dart';



class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Setting', style: theme.textTheme.titleLarge),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            LineAwesomeIcons.arrow_left_solid,
            color: theme.iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(defaultPadding),
          children: [
            const Text(
              "Setting",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: defaultPadding + 4),

            Text(
              "Account",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: defaultPadding / 2),
            SettingsTile(
              title: "Edit Profile",
              icon: LineAwesomeIcons.user_edit_solid,
              iconColor: pnkClr,
              backgroundColor: pnkClr.withAlpha(50),
              onTap: () {},
            ),
            SettingsTile(
              title: "Change Password",
              icon: LineAwesomeIcons.lock_solid,
              iconColor: prColor,
              backgroundColor: prColor.withAlpha(50),
              onTap: () {},
            ),

            const Divider(height: defaultPadding * 2),

            Text(
              "Theme",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: defaultPadding / 2),
            SettingsTile(
              title: "Dark / Light",
              icon: LineAwesomeIcons.moon,
              iconColor: blClr,
              backgroundColor: blClr.withAlpha(50),
              onTap: () {
                _showThemeBottomSheet(context);
              },
            ),

            const Divider(height: defaultPadding * 2),

            // --- Support
            Text(
              "Support",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: defaultPadding / 2),
            SettingsTile(
              title: "About us",
              icon: LineAwesomeIcons.info_circle_solid,
              iconColor: greenClr,
              backgroundColor: greenClr.withAlpha(50),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  // اگر محتوای زیاد باشه Scrollable باشه
                  backgroundColor: Colors.transparent,
                  // برای داشتن گوشه‌های گرد واقعی
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.4,
                      minChildSize: 0.4,
                      maxChildSize: 0.9,
                      builder: (context, scrollController) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, -5),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Header با آیکون
                                Container(
                                  width: 50,
                                  height: 5,
                                  margin: EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Icon(
                                  Icons.info_outline,
                                  size: 50,
                                  color: Colors.green,
                                ),
                                SizedBox(height: 16),

                                Text(
                                  "درباره ما",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      "این اپلیکیشن فروشگاهی توسط میلاد قصاب کلایی ساخته شده تا بتوانید تجربه خرید آنلاین را به صورت ساده و جذاب داشته باشید. می‌توانید محصولات را مشاهده کنید، سفارش دهید و از تجربه خرید لذت ببرید",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[700],
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 32),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    label: Text(
                                      "بستن",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            SettingsTile(
              title: "Contact us",
              icon: LineAwesomeIcons.phone_solid,
              iconColor: blueClr,
              backgroundColor: blueClr.withAlpha(50),
              onTap: () {},
            ),

            const Divider(height: defaultPadding * 2),

            SettingsTile(
              title: "Log out",
              icon: LineAwesomeIcons.sign_out_alt_solid,
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? textColor;

  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: defaultPadding / 2,
      ),
      onTap: onTap,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: backgroundColor ?? Colors.grey.shade200,
        child: Icon(icon, color: iconColor ?? Colors.black),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}

void _showThemeBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          final isDark = themeProvider.themeMode == ThemeMode.dark;
          return SizedBox(
            height: 150,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(
                      PhosphorIcons.sun(PhosphorIconsStyle.regular),
                    ),
                    title: Text("Light theme"),
                    trailing:
                        !isDark ? Icon(Icons.check, color: Colors.green) : null,
                    onTap: () {
                      themeProvider.toggleTheme(false);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      PhosphorIcons.moon(PhosphorIconsStyle.regular),
                    ),
                    title: Text("Dark theme"),
                    trailing:
                        isDark ? Icon(Icons.check, color: Colors.green) : null,
                    onTap: () {
                      themeProvider.toggleTheme(true);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
