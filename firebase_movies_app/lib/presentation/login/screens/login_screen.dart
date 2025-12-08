import 'package:firebase_movies_app/core/const/assets_path_const.dart';
import 'package:firebase_movies_app/core/enums/size_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/mixins/loading_error_mixin.dart';
import 'package:firebase_movies_app/core/mixins/navigator_mixin.dart';
import 'package:firebase_movies_app/core/mixins/snack_bar_mixin.dart';
import 'package:firebase_movies_app/core/validators/email_validator.dart';
import 'package:firebase_movies_app/core/validators/password_validator.dart';
import 'package:firebase_movies_app/core/widgets/buttons/button_widget.dart';
import 'package:firebase_movies_app/core/widgets/inputs/text_form_field_widgets.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/presentation/login/controllers/login_controller.dart';
import 'package:firebase_movies_app/presentation/login/mixins/login_focus_node_mixin.dart';
import 'package:firebase_movies_app/presentation/login/mixins/login_text_editting_controllers.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:firebase_movies_app/presentation/singup/screens/singup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginFocusNodeMixin , LoginTextEdittingControllers, NavigatorMixin, LoadingErrorMixin, SnackBarMixin{
  late LoginController loginCtrl;
  
  @override
  void initState() {
    loginCtrl = LoginController();
    setIsLoading(false);
    super.initState();
  }

  void onLogin() async{
    setIsLoading(true);
    
    final error = await loginCtrl.onLogin(emailTEC.text, passwordTEC.text);
    
    if(error != null && context.mounted){
      setIsLoading(false);
      showSnackBar(context, error, MessageType.error);
    }else{
      setIsLoading(false);
      handleNavigation(context, NavScreen.routeName, clear: true);
    }
  }

  @override
  void dispose() {
    disposeLoginTECs();
    disposeFN();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginCtrl.loginFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal :SizesEnum.lg.getSize),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Lottie.asset(AssetsPathConst.animationLogin),
                  ),
                  SizedBoxWidget.md(),
                  TextWidget.title(text: "Movies App"),
                  SizedBoxWidget.md(),
                  TextFormFieldWidgets(
                    inputLabel: 'Email',
                    controller: emailTEC,
                    focusNode: emailFN,
                    isPassword: false,
                    validator: EmailValidator.validate,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => passwordFN.requestFocus(),
                    ),
                  SizedBoxWidget.md(),
                  TextFormFieldWidgets(
                    inputLabel: 'Senha',
                    controller: passwordTEC,
                    focusNode: passwordFN,
                    isPassword: true,
                    validator: PasswordValidator.validate,
                    textInputAction: TextInputAction.go,
                    ),
                  SizedBoxWidget.xxl(),
                  ButtonWidget(label: 'Login', onPressed: onLogin, isBlock: true, isLoading: isLoading,),
                  SizedBoxWidget.lg(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(text: "Ainda não possui um conta? "),
                        TextSpan(text: "Resgistre aqui!",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () => handleNavigation(context, SingUpScreen.routeName)
                      )
                      ]
                    )),
                ],
              ),
            ),
          ),
          )),
    );
  }
}