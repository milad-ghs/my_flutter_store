import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:store/core/constant.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(defaultPadding),
        children: [
          const Text(
            "Setting",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: defaultPadding + 4),

          const Text("Account", style: TextStyle(fontWeight: FontWeight.bold)),
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

          const Text("Theme", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: defaultPadding / 2),
          SettingsTile(
            title: "Dark / Light",
            icon: LineAwesomeIcons.moon,
            iconColor: blClr,
            backgroundColor: blClr.withAlpha(50),
            onTap: () {},
          ),

          const Divider(height: defaultPadding * 2),

          // --- Support
          const Text("Support", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: defaultPadding / 2),
          SettingsTile(
            title: "About us",
            icon: LineAwesomeIcons.info_circle_solid,
            iconColor: greenClr,
            backgroundColor: greenClr.withAlpha(50),
            onTap: () {},
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
            onTap: () {},
          ),
        ],
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
      title: Text(title, style: TextStyle(color: textColor ?? Colors.black)),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
