import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../core/auth/auth_cubit.dart';
import '../../core/auth/auth_state.dart';
import '../../core/ui/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Verifica o estado de autenticação ao iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Redirecionamento será feito pelo GoRouter automaticamente via AuthGuard
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.rocket_launch, size: 80, color: Colors.white),
              const SizedBox(height: 24),
              LoadingAnimationWidget.threeArchedCircle(
                color: Colors.white,
                size: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
