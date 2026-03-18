import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/app/core/ui/app_colors.dart';
import 'package:projeto_integrador_03/app/core/ui/widgets/app_button.dart';
import 'package:projeto_integrador_03/app/core/utils/responsive_context.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _pin = '';

  void _onNumberPressed(int number) {
    if (_pin.length < 6) {
      setState(() {
        _pin += number.toString();
      });
    }
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

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              
              // Título
              Text(
                'DIGITAR O PIN',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              
              SizedBox(height: context.responsiveValue<double>(mobile: 32, tablet: 48)),
              
              // Display do PIN
              Container(
                width: pinDisplayWidth,
                height: context.responsiveValue<double>(mobile: 56, tablet: 72),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  _pin.replaceAll(RegExp(r'.'), '*'),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                ),
              ),
              
              SizedBox(height: context.responsiveValue<double>(mobile: 32, tablet: 48)),
              
              // Teclado Numérico
              SizedBox(
                width: context.responsiveValue<double>(
                  mobile: 260, 
                  tablet: 380,
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: context.responsiveValue<double>(mobile: 16, tablet: 28),
                  runSpacing: context.responsiveValue<double>(mobile: 12, tablet: 24),
                  children: [
                    for (var i = 1; i <= 9; i++)
                      _buildNumberButton(i, numberButtonSize),
                    
                    // Espaço vazio para alinhar o zero
                    SizedBox(width: numberButtonSize),
                    _buildNumberButton(0, numberButtonSize),
                    
                    // Espaço vazio (para manter grid 3x4)
                    SizedBox(width: numberButtonSize),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Botões de ação
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
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
                        onPressed: () {
                          if (_pin.length >= 4) {
                            context.pushReplacement('/');
                          }
                        },
                        height: buttonHeight,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: context.responsiveValue<double>(mobile: 24, tablet: 40)),
            ],
          ),
        ),
      ),
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
}
