import 'package:flutter/material.dart';
import 'package:movies_app/theme/app_button_style.dart';
import 'package:movies_app/theme/app_colors.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          const _FormWidget(),
          const SizedBox(height: 25),
          const Text(
            'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.',
            style: textStyle,
          ),
          const SizedBox(height: 5),
          TextButton(
            style: AppButtonStyle.linkButton,
            onPressed: () {},
            child: const Text('Register'),
          ),
          const Text(
            'If you signed up but did not get your verification email.',
            style: textStyle,
          ),
          const SizedBox(height: 5),
          TextButton(
            style: AppButtonStyle.linkButton,
            onPressed: () {},
            child: const Text('Verify email'),
          ),
        ],
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController(text: 'admin');
  final _passwordTextController = TextEditingController(text: 'admin');
  String? errorText;

  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordTextController.text;
    if (login == 'admin' && password == 'admin') {
      errorText = null;
      Navigator.of(context).pushReplacementNamed('/main_screen');
    } else {
      errorText = 'Не верный логин или пароль';
    }
    setState(() {});
  }

  void _resetPassword() {}

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Color(0xff212529),
      fontSize: 14.0,
    );
    const color = Color(0xff01B4E4);
    const textFieldDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: AppColors.mainLightBlue,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: AppColors.mainLightBlue,
        ),
      ),
      isCollapsed: true,
      contentPadding: EdgeInsets.all(12.0),
    );
    final errorText = this.errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null) ...[
          Text(
            errorText,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
        ],
        const Text(
          'Username',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: _loginTextController,
          decoration: textFieldDecoration,
        ),
        const SizedBox(height: 20),
        const Text(
          'Password',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: _passwordTextController,
          decoration: textFieldDecoration,
          obscureText: true,
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                ),
              ),
              onPressed: _auth,
              child: const Text('Login'),
            ),
            const SizedBox(width: 30),
            TextButton(
              style: AppButtonStyle.linkButton,
              onPressed: _resetPassword,
              child: const Text('Reset password'),
            ),
          ],
        ),
      ],
    );
  }
}
