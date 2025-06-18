import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/features/login/data/login_data.dart';
import 'package:namoo/widgets/namoo_button_widget.dart';
import 'package:namoo/widgets/namoo_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController idController;
  late TextEditingController pwdController;
  late FocusNode idFocusNode;
  late FocusNode pwdFocusNode;

  bool areAllFieldsFilled = false;
  bool isLoading = false;
  String? errorMessage;

  final LoginService _loginService = LoginService();

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwdController = TextEditingController();
    idFocusNode = FocusNode();
    pwdFocusNode = FocusNode();

    idController.addListener(_checkFields);
    pwdController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      areAllFieldsFilled =
          idController.text.isNotEmpty && pwdController.text.isNotEmpty;
    });
  }

  Future<void> _handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final success = await _loginService.login(
      idController.text.trim(),
      pwdController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      context.push('/navigation');
    } else {
      setState(() {
        errorMessage = '아이디 또는 비밀번호가 잘못되었습니다.';
      });
    }
  }

  @override
  void dispose() {
    idController.dispose();
    pwdController.dispose();
    idFocusNode.dispose();
    pwdFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NaMooColor.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 45, right: 45, top: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/logo/title_icon.svg'),
            const SizedBox(height: 60),

            NaMooTextFieldWidget(
              controller: idController,
              focusNode: idFocusNode,
              title: '아이디',
            ),
            const SizedBox(height: 25),

            NaMooTextFieldWidget(
              controller: pwdController,
              focusNode: pwdFocusNode,
              title: '비밀번호',
              widgetTitle: '비밀번호를 입력하세요',
              type: NaMooTextFieldType.password,
            ),

            if (errorMessage != null) ...[
              const SizedBox(height: 5),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],

            const Spacer(),

            GestureDetector(
              onTap: areAllFieldsFilled && !isLoading ? _handleLogin : null,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : NamooButtonWidget(
                color: NaMooColor.white,
                text: '로그인',
                backgroundColor: areAllFieldsFilled
                    ? const Color(0xFFC39856)
                    : const Color(0xFFE0C08B),
              ),
            ),

            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
