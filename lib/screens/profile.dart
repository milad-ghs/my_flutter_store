import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../core/constant.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: AssetImage('assets/images/myprofile.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: defaultPadding - 6),
                Text('Milad ghs' , style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 24),),
                Text('Milad@gmail.com' , style: TextStyle(fontWeight: FontWeight.w300,color: Colors.grey,fontSize: 15),),
                SizedBox(height : 20),
                SizedBox(
                    width: 120,
                    child: ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(backgroundColor: primaryColor,side: BorderSide.none,shape: StadiumBorder()), child: FittedBox(child: Text('edit profile',style: TextStyle(color: textColor))),
                    )),
                SizedBox(height: 30),
                Divider(),
                SizedBox(height: 10),
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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
      child: ListTile(
        onTap: onPress,
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: secondaryColor
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
    );
  }
}
