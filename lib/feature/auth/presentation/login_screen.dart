import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/auth/presentation/widgets/social_login_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final ValueNotifier<bool> _showPassword;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _showPassword = ValueNotifier(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            leadingWidth: 100,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset(
                AppAssets.appLogo,
                fit: BoxFit.contain,
              ),
            ),
          ),
          body: InkWell(
            splashFactory: NoSplash.splashFactory,
            splashColor: Theme.of(context).coreTransparent,
            focusColor: Theme.of(context).coreTransparent,
            highlightColor: Theme.of(context).coreTransparent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height / 10),
                        Text(
                          'Welcome Back,'.hardcoded,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Sign in to continue'.hardcoded,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email'.hardcoded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: Validators.emailValidator,
                        ),
                        const SizedBox(height: 10),
                        ValueListenableBuilder<bool>(
                          valueListenable: _showPassword,
                          builder: (context, value, child) {
                            return CustomTextField(
                              obscureText: value,
                              controller: _passwordController,
                              hintText: 'Password'.hardcoded,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              validator: Validators.passwordValidator,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _showPassword.value = !value;
                                },
                                child: Icon(
                                  value
                                      ? Ionicons.eye_off_outline
                                      : Ionicons.eye_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: CustomButton(
                            title: 'Sign in'.hardcoded,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            const Expanded(
                              child: Divider(thickness: 1.5),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'OR'.hardcoded,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Expanded(
                              child: Divider(thickness: 1.5),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SocialLoginButton(asset: AppAssets.facebookLogo),
                            SizedBox(width: 20),
                            SocialLoginButton(asset: AppAssets.googleLogo),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                if (!isKeyboardVisible) ...[
                  EntranceFader(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ".hardcoded,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  context.push(RoutePaths.signupRoute.path),
                            text: 'Sign Up'.hardcoded,
                            style:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: Theme.of(context).coreRed,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
