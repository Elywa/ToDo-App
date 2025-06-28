import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:to_do/auth/register/register_view.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';
import 'package:to_do/functions.dart';
import 'package:to_do/home/home_view.dart';
import 'package:to_do/home/task_list/widgets/custom_text_form_field.dart';
import 'package:to_do/providers/user_provider.dart';
import 'package:to_do/theme.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});
  static const String routeName = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.backgroundColor,
        image: const DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.login,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              autovalidateMode: autoValidate,
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .24,
                  ),
                  Text(
                    AppLocalizations.of(context)!.welcome_back,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 25, color: MyTheme.primaryColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!.email,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: MyTheme.primaryColor),
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: AppLocalizations.of(context)!.email_hint_text,
                    keyboradTpe: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return AppLocalizations.of(context)!.field_is_required;
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailController.text);
                      if (!emailValid) {
                        return AppLocalizations.of(context)!.email_invalid;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!.password,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: MyTheme.primaryColor),
                  ),
                  CustomTextFormField(
                    obsecureText: true,
                    controller: passwordController,
                    hintText: AppLocalizations.of(context)!.password_hint_text,
                    keyboradTpe: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return AppLocalizations.of(context)!.field_is_required;
                      }
                      if (text.length < 6) {
                        return AppLocalizations.of(context)!.password_regex;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.forgot_password,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyTheme.primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          MyTheme.primaryColor),
                    ),
                    onPressed: () {
                      loginUser();
                    },
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RegisterView.routeName,
                      );
                    },
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.create_new_account,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyTheme.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    if (formKey.currentState?.validate() == true) {
      try {
        print('==================== Try Function =====================');
        //isLoading = true;
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            });
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // store user in fireStore
        var user = await FireBaseUtils.getUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        // stroe user in provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(newUser: user);
        //isLoading = false;
        Navigator.of(context).pop();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeView();
        }));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          print(
              '====================== No user found for that email.===============');
          //isLoading = false;
          Navigator.of(context).pop();
          showSnackBar(
              context,
              AppLocalizations.of(context)!
                  .invalid_user_name_or_password_snack_bar);
        }
      } catch (e) {
        print('==================== ${e.toString()} =====================');
        //isLoading = false;
        Navigator.of(context).pop();
        showSnackBar(context, e.toString());
      }
    }
  }
}
