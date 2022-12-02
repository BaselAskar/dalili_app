import 'package:dalili_app/src/screens/home_screen.dart';
import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/widgets/login/login_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode _userNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();

  TextEditingController _passwordController = TextEditingController();

  String? _validUserName;
  String? _validEmail;
  String? _validPassword;
  String? _validConfirmPassword;

  Map<String, String?> _registerInfo = {
    'userName': null,
    'email': null,
    'password': null
  };

  @override
  void dispose() {
    _userNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  Future<void> _submitForm(BuildContext context) async {
    setState(() {
      _validUserName = null;
      _validEmail = null;
      _validPassword = null;
      _validConfirmPassword = null;
    });

    bool isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    _formKey.currentState?.save();

    try {
      await Provider.of<Auth>(context, listen: false).register(_registerInfo);

      Navigator.of(context).pushReplacementNamed(HomeScreen.path);
    } catch (error) {
      if ((error as Map).containsKey('userNameError')) {
        setState(() {
          _validUserName = error['userNameError'];
          _formKey.currentState?.validate();
        });
      }

      if (error.containsKey('emailError')) {
        setState(() {
          _validEmail = error['emailError'];
          _formKey.currentState?.validate();
        });
      }

      if (error.containsKey('password')) {
        setState(() {
          _validPassword = error['passwordError'];
          _formKey.currentState?.validate();
        });
      }

      if (error.containsKey('message')) {
        setState(() {
          ScaffoldMessengerState().removeCurrentSnackBar();

          Scaffold.of(context)
              // ignore: deprecated_member_use
              .showSnackBar(SnackBar(content: error['message']['message']));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary75,
      child: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                LoginField(
                  labelText: 'اسم المستخدم',
                  focusNode: _userNameFocus,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocus);
                  },
                  onSave: (value) {
                    _registerInfo['userName'] = value;
                  },
                  validator: (value) {
                    if (value?.trim() == '') return 'الرجاء إضافة اسم المستخدم';

                    return _validUserName;
                  },
                ),
                LoginField(
                  labelText: 'البريد الالكتروني',
                  keyboartType: TextInputType.emailAddress,
                  focusNode: _emailFocus,
                  onSave: (value) {
                    _registerInfo['email'] = value;
                  },
                  validator: ((value) {
                    RegExp regx = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                    if (value != null &&
                        value.trim() != '' &&
                        !regx.hasMatch(value))
                      return 'البريد الإلكتروني غير صحيح';

                    return _validEmail;
                  }),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocus);
                  },
                ),
                LoginField(
                  labelText: 'كلمة المرور',
                  type: TextType.password,
                  focusNode: _passwordFocus,
                  controller: _passwordController,
                  onSave: (value) {
                    _registerInfo['password'] = value;
                  },
                  validator: ((value) {
                    if (value == null || value.trim() == '')
                      return 'يحب إضافة كلمة المرور';

                    if (value.trim().length < 4 && value.trim().length > 30)
                      return 'كلمة المرور بين 4 إلى 30 محرف';

                    return _validEmail;
                  }),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_confirmPasswordFocus);
                  },
                ),
                LoginField(
                  labelText: 'تأكيد كلمة المرور',
                  type: TextType.password,
                  focusNode: _confirmPasswordFocus,
                  validator: (value) {
                    if (_passwordController.text != value)
                      return 'تأكيد كلمة المرور غير مطابق';

                    return null;
                  },
                  onFieldSubmitted: (_) {
                    _submitForm(context);
                  },
                  isLastField: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green[700]),
                    onPressed: () => _submitForm(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      child: Text('تسجيل'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
