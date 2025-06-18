import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/core/namoo_textstyle.dart';
import 'package:namoo/features/sign_up/data/sign_up_data.dart';
import 'package:namoo/widgets/namoo_button_widget.dart';
import 'package:namoo/widgets/namoo_text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 입력 컨트롤러
  late TextEditingController idController;
  late TextEditingController pwdController;
  late TextEditingController nameController;

  // 포커스 노드
  late FocusNode idFocusNode;
  late FocusNode pwdFocusNode;
  late FocusNode nameFocusNode;

  // 상태
  bool areAllFieldsFilled = false;
  bool isLoading = false;
  String? errorMessage;

  final SignUpService _signUpService = SignUpService(); // 서비스 인스턴스

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwdController = TextEditingController();
    nameController = TextEditingController();
    idFocusNode = FocusNode();
    pwdFocusNode = FocusNode();
    nameFocusNode = FocusNode();

    idController.addListener(_checkFields);
    pwdController.addListener(_checkFields);
    nameController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      areAllFieldsFilled = idController.text.isNotEmpty &&
          pwdController.text.isNotEmpty &&
          nameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    idController.dispose();
    pwdController.dispose();
    nameController.dispose();
    idFocusNode.dispose();
    pwdFocusNode.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final success = await _signUpService.signup(
      nameController.text,
      idController.text,
      pwdController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      context.push('/navigation');
    } else {
      setState(() {
        errorMessage = '회원가입에 실패했습니다. 다시 시도해주세요.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NaMooColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 116),
            Image.asset('assets/images/logo/main_icon.png'),
            const SizedBox(height: 22),
            Text(
              '나무와 함께 하루를 기록하고',
              style: NaMooTextStyle.heading1(color: NaMooColor.main500),
            ),
            Text(
              '감정의 변화를 알아보세요!',
              style: NaMooTextStyle.heading1(color: NaMooColor.main500),
            ),
            const SizedBox(height: 35),

            // 이름
            NaMooTextFieldWidget(
              controller: nameController,
              focusNode: nameFocusNode,
              title: '이름',
              widgetTitle: '이름을 입력하세요',
            ),
            const SizedBox(height: 18),

            // 아이디
            NaMooTextFieldWidget(
              controller: idController,
              focusNode: idFocusNode,
              title: '아이디',
              widgetTitle: '아이디를 입력하세요',
            ),
            const SizedBox(height: 18),

            // 비밀번호
            NaMooTextFieldWidget(
              controller: pwdController,
              focusNode: pwdFocusNode,
              title: '비밀번호',
              widgetTitle: '비밀번호를 입력하세요',
              type: NaMooTextFieldType.password,
            ),

            const SizedBox(height: 10),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),

            const Spacer(),

            // 회원가입 버튼
            GestureDetector(
              onTap: areAllFieldsFilled && !isLoading ? _handleSignUp : null,
              child: NamooButtonWidget(
                color: NaMooColor.white,
                text: '회원가입',
                backgroundColor: areAllFieldsFilled
                    ? NaMooColor.main500
                    : const Color(0xFFBED995),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
