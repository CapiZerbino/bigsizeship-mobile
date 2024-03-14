import 'package:bigsizeship_mobile/core/common/app/providers/user_provider.dart';
import 'package:bigsizeship_mobile/core/common/widgets/gradient_background.dart';
import 'package:bigsizeship_mobile/core/common/widgets/rounded_button.dart';
import 'package:bigsizeship_mobile/core/resources/fonts.dart';
import 'package:bigsizeship_mobile/core/resources/media_resources.dart';
import 'package:bigsizeship_mobile/src/authentication/data/models/user_model.dart';
import 'package:bigsizeship_mobile/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:bigsizeship_mobile/src/authentication/presentation/widgets/login_form.dart';
import 'package:bigsizeship_mobile/src/home/presentation/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const routeName = '/login';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailController = TextEditingController(text: 'customer@gmail.com');
  final passwordController = TextEditingController(text: 'bss123456');
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (_, state) {
          if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is Logined) {
            context.read<UserProvider>().initUser(state.user as UserModel);
            Navigator.pushReplacementNamed(
              context,
              HomeScreen.routeName,
            );
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaResources.whiteBackground,
            child: SafeArea(
              child: Center(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const Image(
                      image: AssetImage(MediaResources.brandImage),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bigsize Ship',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: Fonts.notoSans,
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      'Chào mừng bạn quay lại Bigsize Ship',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    LoginForm(
                      emailController: emailController,
                      passwordController: passwordController,
                      formKey: formKey,
                    ),
                    const SizedBox(height: 10),
                    if (state is LoginLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      RoundedButton(
                        label: 'Đăng nhập',
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.currentState!.validate()) {
                            context.read<AuthenticationBloc>().add(
                                  LoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                      ),
                    const TextButton(
                      onPressed: null,
                      child: Text('Đăng nhập bằng FaceID'),
                    ),
                    const Text(
                      'Kết nối các đơn vị vận chuyển',
                      textAlign: TextAlign.center,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(MediaResources.NJVLogo),
                          width: 40,
                          height: 40,
                        ),
                        Image(
                          image: AssetImage(MediaResources.GHTKLogo),
                          width: 40,
                          height: 40,
                        ),
                        Image(
                          image: AssetImage(MediaResources.GHNLogo),
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
