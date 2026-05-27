import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/user.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/pages/sign_in_view.dart';
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:provider/provider.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController _usernameController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(ImatDataHandler iMat) {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final rawUsers = iMat.getExtras()['users'];

    if (rawUsers == null) {
      setState(() {
        _errorMessage =
            'Inga konton finns registrerade ännu.';
      });
      return;
    }

    final users = (rawUsers as List)
        .map((u) => User.fromJson(
              Map<String, dynamic>.from(u),
            ))
        .toList();

    final user = users.where(
      (u) => u.userName == username,
    );

    if (user.isEmpty) {
      setState(() {
        _errorMessage =
            'Kontot finns inte.';
      });
      return;
    }

    final foundUser = user.first;

    if (foundUser.password != password) {
      setState(() {
        _errorMessage =
            'Fel lösenord.';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    iMat.login(foundUser);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Inloggning lyckades!'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();

    return Scaffold(
      appBar: const BaseAppBar(),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(
              AppTheme.paddingHuge,
            ),

            decoration: BoxDecoration(
              color: AppTheme.brightColor,
              borderRadius: BorderRadius.circular(
                AppTheme.radius,
              ),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Logga in',
                  style: AppTheme.titleFont.copyWith(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: AppTheme.paddingLarge,
                ),

                if (_errorMessage != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 250, 200, 206),
                      borderRadius:
                          BorderRadius.circular(
                        AppTheme.radius,
                      ),
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style:
                          AppTheme.textFont.copyWith(
                        color: const Color.fromARGB(255, 185, 29, 29),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.whiteColor,
                    hintText: 'Email address',
                    prefixIcon:
                        const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        AppTheme.radius,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.whiteColor,
                    hintText: 'Lösenord',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        AppTheme.radius,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: AppTheme.paddingLarge,
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.darkColor,
                          padding: const EdgeInsets.symmetric(vertical: 16,),
                        ),
                        onPressed: () => _login(iMat),
                        child: Text(
                          'Logga in',
                          style: AppTheme.textFont.copyWith(
                            color: AppTheme.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppTheme.darkColor,),
                          padding: const EdgeInsets.symmetric(vertical: 16,),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInView())
                          );
                        },
                        child: Text(
                          'Skapa konto',
                          style: AppTheme.textFont.copyWith( 
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    iMat.removeExtra('users');

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Användare borttagna',
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Rensa users (debug)',
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}