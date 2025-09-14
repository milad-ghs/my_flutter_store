import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../core/app_color.dart';
import '../core/constant.dart';
import '../providers/auth_provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});


  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;
    final displayName = (user?.name != null && user!.name!.isNotEmpty)
        ? user.name!
        : (user?.phoneNumber ?? 'کاربر');

    final displayPhone = (user?.phoneNumber != null && user!.phoneNumber.isNotEmpty)
        ? user.phoneNumber
        : (user?.phoneNumber ?? 'empty');

    return SafeArea(
      child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white.withAlpha(60),
                    backgroundImage: (user?.profileImagePath != null &&
                        File(user!.profileImagePath!).existsSync())
                        ? FileImage(File(user.profileImagePath!))
                        : null,
                    child: (user?.profileImagePath == null ||
                        !(File(user!.profileImagePath!).existsSync()))
                        ? Icon(
                      PhosphorIcons.user(PhosphorIconsStyle.regular),
                      size: 40,
                      color: Colors.white70,
                    ) : null,
            ),
                SizedBox(height: defaultPadding - 6),
                Text( displayName, style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 24),),
                Text(displayPhone , style: TextStyle(fontWeight: FontWeight.w300,color: Colors.grey,fontSize: 15),),
                SizedBox(height : 20),
                SizedBox(
                    width: 120,
                    child: ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(backgroundColor: AppColor.primary,side: BorderSide.none,shape: StadiumBorder()), child: FittedBox(child: Text('edit profile',style: TextStyle(color: AppColor.primaryText))),
                    )),
                SizedBox(height: 40),
                ProfileMenuWidget(title: 'My Orders',onPress: (){},icon: LineAwesomeIcons.box_open_solid),
                ProfileMenuWidget(title: 'Billing Details ',onPress: (){},icon:  LineAwesomeIcons.wallet_solid),
                ProfileMenuWidget(title: 'User Management',onPress: (){},icon:  LineAwesomeIcons.user_check_solid),
                ProfileMenuWidget(title: 'Information',onPress: (){},icon:  LineAwesomeIcons.info_solid),
                ],
            ),
          ),
        ),
    );

  }
}

class ProfileMenuWidget extends StatelessWidget {

  final String title ;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? txtColor;

  const ProfileMenuWidget({super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.txtColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
        child: ListTile(
          onTap: onPress,
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.primaryLight
            ),
            child: Icon(icon,color: textColor,),
          ),
          title: Text(title,style: TextStyle(color: txtColor ?? textColor)),
          trailing: endIcon ? Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey[100]
            ),
            child: Icon(LineAwesomeIcons.angle_right_solid,size: 18 ,color: Colors.grey,),
          ) : null,
        ),
      ),
    );
  }
}
