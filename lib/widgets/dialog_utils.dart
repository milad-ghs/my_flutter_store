import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_color.dart';
import '../providers/auth_provider.dart';
import '../screens/login.dart';
void logout(BuildContext context) async {
  final confirm = await showLogoutConfirmation(
    title: 'Are you sure ?',
    context: context,
    content: 'Do you want to log out?',
  );
  if (!confirm) return;
  context.read<AuthProvider>().logout(context);
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
  );
}

Future<bool> showLogoutConfirmation(
{
  required BuildContext context,
  required String title,
  required String  content,
  String cancelText = 'No',
  String confirmText = 'Yes',
  Color? confirmColor,
}) async {
  return await showDialog(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: AppColor.backgroundLight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white.withOpacity(0.3),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                title,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
               Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child:  Text(
                        cancelText,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: confirmColor ?? Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child:  Text(
                        confirmText,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  ) ?? false;
}