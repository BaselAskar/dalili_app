import 'package:dalili_app/src/screens/home_screen.dart';
import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/widgets/login/login_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dalili_app/src/providers/auth_provider.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String? _validUserName;
  String? _validPassword;

  Map<String, String?> _loginInfo = {'userName': null, 'passwrod': null};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  HttpRequest loginReq = HttpRequest(
    url: '/api/account/login',
    method: Methods.post,
    contentType: APPLICATION_JSON,
  );

  void _onSubmit(BuildContext context) {
    setState(() {
      _validUserName = null;
      _validPassword = null;
    });

    final bool formValid = _formKey.currentState!.validate();

    if (!formValid) return;

    _formKey.currentState?.save();

    Provider.of<Auth>(context, listen: false)
        .login(_loginInfo)
        .then(
            (_) => Navigator.of(context).pushReplacementNamed(HomeScreen.path))
        .catchError((error) {
      if ((error as Map).containsKey('userNameError')) {
        setState(() {
          _validUserName = error['userNameError'];
          _formKey.currentState?.validate();
        });
      }

      if (error.containsKey('passwordError')) {
        setState(() {
          _validPassword = error['passwordError'];
          _formKey.currentState?.validate();
        });
      }

      if (error.containsKey('message')) {
        ScaffoldMessengerState().removeCurrentSnackBar();
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(SnackBar(content: error['message']));
      }
    });
  }

  void _applyError(error) {
    if ((error as Map).containsKey('userNameError')) {
      setState(() {
        _validUserName = error['userNameError'];
      });
    }

    if (error.containsKey('passwordError')) {
      setState(() {
        _validPassword = error['passwordError'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary75,
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              LoginField(
                labelText: 'اسم السمتخدم',
                focusNode: _userNameFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                onSave: (value) {
                  _loginInfo['userName'] = value?.trim();
                },
                validator: (value) {
                  if (value?.trim() == '') return 'الرجاء إضافة اسم المستخدم';

                  return _validUserName;
                },
              ),
              SizedBox(height: 20),
              LoginField(
                labelText: 'كلمة المرور',
                type: TextType.password,
                focusNode: _passwordFocus,
                isLastField: true,
                onSave: (value) {
                  _loginInfo['password'] = value?.trim();
                },
                onFieldSubmitted: (_) => _onSubmit(context),
                validator: (value) {
                  if (value?.trim() == '') return 'الرجاء إضافة كلمة المرور';

                  return _validPassword;
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _onSubmit(context),
                child: Text('تسجيل دخول', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
