import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/widgets/login/login_form.dart';
import 'package:dalili_app/src/widgets/login/register_form.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> with TickerProviderStateMixin {
  bool _initialed = false;

  final tab = TabBar(
    tabs: [Tab(text: 'تسجيل الدخول'), Tab(text: 'مستخدم جديد')],
    indicatorColor: AppColors.primary,
    labelColor: AppColors.primary,
    labelStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  );

  late AnimationController _translateController;
  late Animation<double> _translateAnimaition;

  late AnimationController _opacityController;
  late Animation<double> _opacityAnimi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _translateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _translateAnimaition = Tween<double>(
      begin: 75,
      end: 0,
    ).animate(
        CurvedAnimation(parent: _translateController, curve: Curves.easeInOut));

    _translateAnimaition.addListener(() => setState(() {}));

    _opacityController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _opacityAnimi = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _opacityController, curve: Curves.linear))
      ..addListener(() => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    if (!_initialed) {
      _translateController.forward();
      _opacityController.forward();
      _initialed = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, _translateAnimaition.value),
      child: Opacity(
        opacity: _opacityAnimi.value,
        child: Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.primary75,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset.zero,
                color: AppColors.loginColor.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ],
          ),
          child: DefaultTabController(
            length: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: AppColors.primary75,
                    bottom: tab,
                  ),
                ),
                body: TabBarView(
                  children: [
                    LoginForm(),
                    RegisterForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
