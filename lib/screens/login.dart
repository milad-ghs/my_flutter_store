import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';
import 'package:store/core/constant.dart';
import 'package:store/screens/profile_screen.dart';

import '../core/app_color.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../screens/main_wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  Future<void> _continue() async {
    if (!_formKey.currentState!.validate()) return;

    final phone = _phoneController.text.trim();
    final auth = context.read<AuthProvider>();
     auth.loginOrRegister(phone);

    final userId = auth.currentUser!.phoneNumber;
    await context.read<CartProvider>().initUserCart(userId);

    if (auth.currentUser?.name == null || auth.currentUser!.name!.isEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    } else {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainWrapper()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: theme.appBarTheme.titleTextStyle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding,vertical: 200),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please enter your phone number',
                  style:theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(height: defaultPadding * 2),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  cursorColor: AppColor.primary,
                  cursorHeight: 20,
                  cursorWidth: 2,
                  cursorRadius: Radius.circular(15),
                  showCursor: true,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    prefixIcon: Icon(PhosphorIcons.phone(PhosphorIconsStyle.thin),size: 30,),
                    filled: true,
                    fillColor: AppColor.backgroundMedium,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        defaultBorderRadius,
                      ),
                    ),
                    // icon: Icon(
                    //   PhosphorIcons.phone(PhosphorIconsStyle.thin),size: 30,
                    // ),
                    labelText: 'phone number',
                    hintText: 'example: 0911xxxxxxx',
                    hintStyle: TextStyle(color: Colors.black45),
                  ),
                  validator:
                      ValidationBuilder()
                          .required('Mobile number is required.')
                          .minLength(11, 'The number must be 11 digits.')
                          .maxLength(11, 'The number must be 11 digits.')
                          .regExp(
                            RegExp(r'^09\d{9}$'),
                            'Mobile number is not valid.',
                          )
                          .build(),
                  onFieldSubmitted: (_) => _continue(),
                ),
                const SizedBox(height: defaultPadding * 2),
                ElevatedButton(
                  onPressed: _continue,
                  child:  Text('Continue',style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
