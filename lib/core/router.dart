import 'package:go_router/go_router.dart';
import 'package:namoo/features/bottom_navigation/presentation/bottom_navigation.dart';
import 'package:namoo/features/diary/presentation/view/diary_screen.dart';
import 'package:namoo/features/diary/presentation/view/diary_success_screen.dart';
import 'package:namoo/features/login/presentation/view/login_screen.dart';
import 'package:namoo/features/on_boarding/presentation/view/on_boarding_screen.dart';
import 'package:namoo/features/sign_up/presentation/view/sign_up_screen.dart';
import 'package:namoo/features/splash/presentation/view/splash_screen.dart';
import 'package:namoo/features/statistics/presentation/view/statistics_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/sign_up',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/navigation',
      builder: (context, state) {
        final extra = state.extra;
        String? emotion;

        if (extra is String) {
          emotion = extra;
        } else if (extra is Map<String, dynamic>) {
          emotion = extra['emotion'] as String?;
        }

        return BottomNavigation(emotion: emotion);
      },
    ),
    GoRoute(
      path: '/mypage',
      builder: (context, state) => const StatisticsScreen()
    ),
    GoRoute(
      path: '/diary',
      builder: (context, state) => const DiaryScreen(),
    ),
    GoRoute(
      path: '/diarySuccess',
      builder: (context, state) {
        final extra = state.extra;
        String emotion;

        if (extra is String) {
          emotion = extra;
        } else if (extra is Map<String, dynamic>) {
          emotion = extra['emotion'] as String? ?? '알 수 없음';
        } else {
          emotion = '알 수 없음';
        }

        return DiarySuccessScreen(emotion: emotion);
      },
    ),
  ]
);