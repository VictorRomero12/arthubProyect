import 'package:flutter/material.dart';
import 'package:arthub/Home/home_page.dart';
import 'package:arthub/authentication/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Center(
        child: isSmallScreen
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _Logo(),
                  _FormContent(),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: const [
                    Expanded(child: _Logo()),
                    Expanded(
                      child: Center(child: _FormContent()),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // FlutterLogo(size: isSmallScreen ? 100 : 200), // Esta línea elimina el icono de Flutter
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headline5
                : Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  late String _email;
  late String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _InputField(
              hintText: 'Nombre de usuario',
              labelText: 'Nombre de usuario',
              icon: Icons.person_2_rounded,
              onChanged: (value) {
               
              },
              
            ),
            const SizedBox(height: 16.0),
            _InputField(
              hintText: 'Contraseña',
              labelText: 'Contraseña',
              icon: Icons.lock_outline,
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _password = value;
                  print('El Password es $_password');
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce una contraseña';
                }
                if (value.length < 6) {
                  return 'La contraseña debe tener al menos 6 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent,
                  onPrimary: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Navegar a la pantalla MainPage al hacer clic en el botón de inicio de sesión
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SimpleBottomNavigation()),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'NerkoOne'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Navegar a la pantalla de registro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text(
                "¿No tienes una cuenta? Crea una",
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
