import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/core/app_colors.dart';
import 'package:projeto_integrador_03/core/responsive_context.dart';
import 'package:projeto_integrador_03/core/utils/app_messages.dart';
import 'package:projeto_integrador_03/cubits/auth_cubit.dart';
import 'package:projeto_integrador_03/core/utils/app_loading_overlay.dart';
import 'package:projeto_integrador_03/cubits/auth_state.dart';
import 'package:projeto_integrador_03/features/operators/presentation/cubit/operator_cubit.dart';
import 'package:projeto_integrador_03/features/operators/presentation/cubit/operator_state.dart';
import 'package:projeto_integrador_03/views/widgets/app_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _pin = '';

  void _onNumberPressed(int number) {
    if (_pin.length < 6) {
      setState(() => _pin += number.toString());
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  Future<void> _continuar() async {
    final operatorState = context.read<OperatorCubit>().state;
    if (operatorState is! OperatorLoaded || operatorState.selected == null) {
      return;
    }
    final operator = operatorState.selected!;
    await context.read<AuthCubit>().login(
      operatorId: operator.operatorId,
      pin: int.parse(_pin),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = context.responsiveValue<double>(
      mobile: 32.0,
      tablet: 120.0,
    );
    final titleSize = context.responsiveValue<double>(
      mobile: 32.0,
      tablet: 48.0,
    );
    final pinDisplayWidth = context.responsiveValue<double>(
      mobile: context.screenWidth * 0.75,
      tablet: 400.0,
    );
    final numberButtonSize = context.responsiveValue<double>(
      mobile: 64.0,
      tablet: 90.0,
    );
    final buttonHeight = context.responsiveValue<double>(
      mobile: 50.0,
      tablet: 60.0,
    );

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide(context);
        }
        if (state.isAuthenticated) {
          context.go('/');
        } else if (state.status == AuthStatus.error) {
          AppMessages.showError(
            context,
            state.error ?? 'Erro ao realizar login',
          );
          setState(() => _pin = '');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    'DIGITAR O PIN',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: titleSize,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveValue<double>(
                      mobile: 32,
                      tablet: 48,
                    ),
                  ),
                  Container(
                    width: pinDisplayWidth,
                    height: context.responsiveValue<double>(
                      mobile: 56,
                      tablet: 72,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _pin.replaceAll(RegExp(r'.'), '*'),
                      style: TextStyle(
                        fontSize: context.responsiveValue<double>(
                          mobile: 26.0,
                          tablet: 36.0,
                        ),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 8,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveValue<double>(
                      mobile: 32,
                      tablet: 48,
                    ),
                  ),
                  SizedBox(
                    width: context.responsiveValue<double>(
                      mobile: 260,
                      tablet: 380,
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: context.responsiveValue<double>(
                        mobile: 16,
                        tablet: 28,
                      ),
                      runSpacing: context.responsiveValue<double>(
                        mobile: 12,
                        tablet: 24,
                      ),
                      children: [
                        for (var i = 1; i <= 9; i++)
                          _buildNumberButton(i, numberButtonSize),
                        _buildBackspaceButton(numberButtonSize),
                        _buildNumberButton(0, numberButtonSize),
                        SizedBox(width: numberButtonSize),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingHorizontal,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Cancelar',
                            backgroundColor: const Color(0xFFF28B82),
                            onPressed: () => context.pop(),
                            height: buttonHeight,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: AppButton(
                            label: 'Continuar',
                            onPressed: _pin.isEmpty ? null : _continuar,
                            height: buttonHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveValue<double>(
                      mobile: 24,
                      tablet: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNumberButton(int number, double size) {
    return Material(
      color: const Color(0xFFC2C2C2),
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        onTap: () => _onNumberPressed(number),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: size * 0.45,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton(double size) {
    return Material(
      color: const Color(0xFFC2C2C2),
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        onTap: _onBackspace,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: Icon(Icons.backspace_outlined, size: size * 0.4),
        ),
      ),
    );
  }
}
