import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';
import 'package:to_do/functions.dart';
import 'package:to_do/home/home_view.dart';
import 'package:to_do/home/task_list/widgets/custom_text_form_field.dart';
import 'package:to_do/models/my_user.dart';
import 'package:to_do/providers/user_provider.dart';
import 'package:to_do/theme.dart';

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
              'Create Account',
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
                      'User Name',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: MyTheme.primaryColor),
                    ),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: 'please enter user name',
                      keyboradTpe: TextInputType.name,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'field is required';
                        } else {
                          return null;
                        }
                      },
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
                    Text(
                      'Confirm Password',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: MyTheme.primaryColor,
                          ),
                    ),
                    CustomTextFormField(
                      controller: confirmPassowrdController,
                      hintText: 'please Confirm Password',
                      keyboradTpe: TextInputType.number,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'field is required';
                        }
                        if (text != passwordController.text) {
                          return 'password does not match';
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
                          'Register',
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
          showSnackBar(context, 'Weak Password');
        } else if (e.code == 'email-already-in-use') {
          //isLoading = false;
          print(
              '==================== The account already exists for that email. =====================');
          Navigator.of(context).pop();
          showSnackBar(context, 'The account already exists for that email.');
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
