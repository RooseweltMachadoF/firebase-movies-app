import 'package:firebase_movies_app/core/const/assets_path_const.dart';
import 'package:firebase_movies_app/core/mixins/navigator_mixin.dart';
import 'package:firebase_movies_app/core/services/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/presentation/login/screens/login_screen.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});
  
  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}
class _SplashScreenWidgetState extends State<SplashScreenWidget> with NavigatorMixin {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      
      await Future.delayed(const Duration(seconds: 10));
      final user = FirebaseAuthService.getUser;

      if(context.mounted){
        if(user == null){
        handleNavigation(context, LoginScreen.routeName, clear: true);
      }else{
        handleNavigation(context, NavScreen.routeName,clear: true);
      }
      }
    }); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Lottie.asset(AssetsPathConst.animationSplash),
          ),
        ),
        SizedBoxWidget.md(),
        TextWidget.title(text: 'Loading ...'),
      ],
    );
  }
}