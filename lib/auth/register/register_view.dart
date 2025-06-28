

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


import 'package:provider/provider.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';
import 'package:to_do/functions.dart';
import 'package:to_do/home/home_view.dart';
import 'package:to_do/home/task_list/widgets/custom_text_form_field.dart';
import 'package:to_do/models/my_user.dart';
import 'package:to_do/providers/user_provider.dart';
import 'package:to_do/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});
  static const String routeName = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPassowrdController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidate = AutovalidateMode.disabled;

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
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.create_account,
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
                      AppLocalizations.of(context)!.user_name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: MyTheme.primaryColor),
                    ),
                    CustomTextFormField(
                      controller: nameController,
                      hintText:
                          AppLocalizations.of(context)!.user_name_hint_text,
                      keyboradTpe: TextInputType.name,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!
                              .field_is_required;
                        } else {
                          return null;
                        }
                      },
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
                          return AppLocalizations.of(context)!
                              .field_is_required;
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text);
                        if (!emailValid) {
                          return AppLocalizations.of(context)!
                              .invalid_user_name_or_password_snack_bar;
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
                      controller: passwordController,
                      hintText:
                          AppLocalizations.of(context)!.password_hint_text,
                      keyboradTpe: TextInputType.number,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!
                              .field_is_required;
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
                    Text(
                      AppLocalizations.of(context)!.confirm_password,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: MyTheme.primaryColor,
                          ),
                    ),
                    CustomTextFormField(
                      controller: confirmPassowrdController,
                      hintText: AppLocalizations.of(context)!
                          .confirm_password_hint_text,
                      keyboradTpe: TextInputType.number,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!
                              .field_is_required;
                        }
                        if (text != passwordController.text) {
                          return AppLocalizations.of(context)!
                              .password_does_not_match;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            MyTheme.primaryColor),
                      ),
                      onPressed: () {
                        registerNewUser();
                      },
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerNewUser() async {
    if (formKey.currentState?.validate() == true) {
      try {
        print('==================== Try Function =====================');
        // isLoading = true;
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            });
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser user = MyUser(
            email: emailController.text,
            id: credential.user?.uid ?? '',
            name: nameController.text);
        //store user in provider to use it in all app
        // listen = flase because i want to call provider one time at this moment.
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(newUser: user);
        // store user in fireStore
        await FireBaseUtils.addUserToFireStore(user);
        // isLoading = false;
        Navigator.of(context).pop();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeView();
        }));
        print('==================== Register Success =====================');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('==================== weak-password =====================');
          //isLoading = false;
          Navigator.of(context).pop();
          showSnackBar(context, AppLocalizations.of(context)!.weak_password);
        } else if (e.code == 'email-already-in-use') {
          //isLoading = false;
          print(
              '==================== The account already exists for that email. =====================');
          Navigator.of(context).pop();
          showSnackBar(
              context, AppLocalizations.of(context)!.email_already_in_use);
        }
      } catch (e) {
        print('==================== ${e.toString()} =====================');
        Navigator.of(context).pop();
        //isLoading = false;
        showSnackBar(context, e.toString());
      }
    }
  }
}
