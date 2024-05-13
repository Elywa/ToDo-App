import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:to_do/auth/register/register_view.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';
import 'package:to_do/functions.dart';
import 'package:to_do/home/home_view.dart';
import 'package:to_do/home/task_list/widgets/custom_text_form_field.dart';
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
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              'Login',
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
                      'Welcome Back!',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 25, color: MyTheme.primaryColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Email',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: MyTheme.primaryColor),
                    ),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'please enter email',
                      keyboradTpe: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'field is required';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text);
                        if (!emailValid) {
                          return 'email should be like this "example.email123@example.com"';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Password',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: MyTheme.primaryColor),
                    ),
                    CustomTextFormField(
                      obsecureText: true,
                      controller: passwordController,
                      hintText: 'please enter Password',
                      keyboradTpe: TextInputType.number,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'field is required';
                        }
                        if (text.length < 6) {
                          return 'password must have over 6 numbers';
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
                          'Forgot Password ? ',
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
                          'Login',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RegisterView.routeName,
                        );
                      },
                      child: Center(
                        child: Text(
                          'Create new Account',
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
      ),
    );
  }

  void loginUser() async {
    if (formKey.currentState?.validate() == true) {
      try {
        print('==================== Try Function =====================');
        isLoading = true;
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = await FireBaseUtils.getUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        isLoading = false;
        Navigator.pushNamed(context, HomeView.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          print(
              '====================== No user found for that email.===============');
          isLoading = false;
          showSnackBar(context, 'invalid user name or password');
        } else if (e.code == 'invalid-credential') {
          print(' ================== ${e.code.toString()} =================');
          isLoading = false;
          showSnackBar(context, 'invalid user name or password ');
        }
      } catch (e) {
        print('==================== ${e.toString()} =====================');
        isLoading = false;
        showSnackBar(context, e.toString());
      }
    }
  }
}
