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
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:firebase_movies_app/presentation/singup/controller/signup_controller.dart';
import 'package:firebase_movies_app/presentation/singup/mixins/signup_focus_node_mixin.dart';
import 'package:firebase_movies_app/presentation/singup/mixins/signup_text_editing_controller_mixin.dart';
import 'package:flutter/material.dart';

class SingUpScreen extends StatefulWidget {
  static const String routeName = '/singUp';

  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> with NavigatorMixin, LoadingErrorMixin , SnackBarMixin,SignupFocusNodeMixin, SignupTextEditingControllerMixin{
  
  late SignupController signupCtrl;

  @override
  void initState() {
    setIsLoading(false);
    signupCtrl = SignupController();
    super.initState();
  }
  
  @override
  void dispose() {
    disposeTEC();
    disposeFN();
    super.dispose();
  }

  void onSignUP(BuildContext context) async {
    setIsLoading(true);
    setError(null);

    final (errorMessage , sucess) = await signupCtrl.onSignUP(emailTEC.text, passwordTEC.text);

    if(sucess && context.mounted){
      handleNavigation(context, NavScreen.routeName);
    }else{
      setIsLoading(false);
      if(errorMessage != null ){
        showSnackBar(context, errorMessage, MessageType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: signupCtrl.signupFormKey,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: SizesEnum.lg.getSize),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBoxWidget.lg(),
                TextWidget.title(text: "Registro"),
                SizedBoxWidget.md(),
                TextFormFieldWidgets(
                  inputLabel: "Email",
                  controller: emailTEC,
                  focusNode: emailFN,
                  validator: EmailValidator.validate,
                  textInputType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) => passwordFN.requestFocus(),
                  ),
                SizedBoxWidget.md(),
                TextFormFieldWidgets(
                  inputLabel: "Senha",
                  controller: passwordTEC,
                  focusNode: passwordFN,
                  validator: PasswordValidator.validate,
                  isPassword: true,
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (_) => onSignUP(context),
                  ),
                SizedBoxWidget.xxl(),
                ButtonWidget(label: "Registrar", onPressed: () => onSignUP(context), isBlock: true, isLoading: isLoading,)

              ],
            ),
          ),
          )),
    );
  }
}