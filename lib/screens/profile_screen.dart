import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import '../core/app_color.dart';
import '../core/constant.dart';
import '../providers/auth_provider.dart';
import '../widgets/dialog_utils.dart';
import 'login.dart';
import 'main_wrapper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _picker = ImagePicker();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = context.read<AuthProvider>().currentUser;
    _nameController.text = user?.name ?? '';

  }

  Future<void> _pickImage () async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      if(!mounted) return ; context.read<AuthProvider>().setProfileImage(pickedFile.path);
    }

  }

  void _saveProfile() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name cannot be empty.'),backgroundColor: AppColor.error,),
      );
      return;
    }

    context.read<AuthProvider>().setProfileName(name);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile saved successfully.',style: TextStyle(color: AppColor.backgroundLight),),backgroundColor: AppColor.success),
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainWrapper()),
          (route) => false,
    );
  }

  void _logout() async{
    final confirm = await showLogoutConfirmation(
      title: 'Are you sure ?',
      context: context,
      content: 'Do you want to log out?',
    );
    if(!confirm) return;

    context.read<AuthProvider>().logout(context);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final theme = Theme.of(context);
    if (user == null) {
      return const Center(child: Text('User not found'));
    }

    return Scaffold(
      appBar: AppBar(
          title:  Text('My Profile',style: theme.appBarTheme.titleTextStyle),
          centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding , vertical: defaultPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: user.profileImagePath != null ? FileImage(File(user.profileImagePath!)) : null,
                  child: user.profileImagePath == null ? Icon(PhosphorIcons.camera(PhosphorIconsStyle.regular),size: 40,color: Colors.white70,) : null ,
                ),
              ),
              SizedBox(height: defaultPadding),
              Text('Phone number : ${user.phoneNumber}',
                  style: theme.textTheme.bodyLarge),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                  cursorColor: AppColor.primary,
                  cursorHeight: 20,
                  cursorWidth: 2,
                  cursorRadius: Radius.circular(15),
                  showCursor: true,
                 maxLength: 20,
                decoration:  InputDecoration(
                  prefixIcon: Icon(PhosphorIcons.user(PhosphorIconsStyle.thin),size: 30,),
                  filled: true,
                  fillColor: AppColor.backgroundMedium,
                  labelText: 'name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultPadding)
                  ),
                ),
                  style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save changes'),
              ),
              const SizedBox(height: defaultPadding * 2),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Log out'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
