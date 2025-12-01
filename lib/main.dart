import 'package:flutter/material.dart';
import 'registro_conteudo_frequencia.dart';
import 'home.dart';
import 'lancar_notas.dart';
import 'relatorio_notas.dart';
import 'relatorio_conteudos.dart';
import 'relatorio_frequencia.dart';
import 'calendario.dart';
import 'turmas.dart';
import 'relatorios.dart';

const Color primaryColor = Color(0xFF137FEC);
const Color backgroundDark = Color(0xFF101922);
const Color foregroundDark = Color(0xFF182635);
const Color textDarkPrimary = Color(0xFFF8FAFC);
const Color textDarkSecondary = Color(0xFF94A3B8);
const Color errorColor = Color(0xFFEF4444); // Cor para ícones de erro/logout
const Color cardDark = Color(0xFF182635); // Cor de fundo para cards
const Color borderDark = Color(0xFF334155);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiárioApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Usando o tema escuro como base
        scaffoldBackgroundColor: backgroundDark,
        primaryColor: primaryColor,
        // Define o tema de entrada (InputDecorationTheme) para os TextField
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: foregroundDark,
          hintStyle: const TextStyle(color: textDarkSecondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: borderDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: borderDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: primaryColor, width: 2.0),
          ),
        ),
        textTheme: const TextTheme(
          // Define a cor primária para a maioria dos textos
          bodyLarge: TextStyle(color: textDarkPrimary),
          bodyMedium: TextStyle(color: textDarkPrimary),
          titleLarge: TextStyle(color: textDarkPrimary),
        ),
        // Estiliza o botão elevado (Entrar)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56), // Largura total e altura de 56 (h-14 do seu HTML)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Lexend'),
          ),
        ),
        // Define a fonte base
        fontFamily: 'Lexend',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/lancar_notas': (context) => const GradeEntryScreen(),
        '/relatorio_notas': (context) => const GradeReportScreen(),
        '/relatorio_conteudos': (context) => const ContentReportScreen(),
        '/relatorio_frequencia': (context) => const AttendanceReportScreen(),
        '/calendario': (context) => const CalendarScreen(),
        '/turmas': (context) => const ClassesScreen(),
        '/relatorios': (context) => const ReportsScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        // padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Container(
          constraints: BoxConstraints(minHeight: screenHeight),
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // 1. Ícone
              const Icon(
                Icons.school,
                size: 64,
                color: primaryColor,
              ),
              const SizedBox(height: 16),

              // 2. Título "Bem-vindo(a) de volta!"
              const Text(
                'Bem-vindo(a) de volta!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: textDarkPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // 3. Subtítulo
              const Text(
                'Acesse seu Diário Digital para continuar',
                style: TextStyle(
                  fontSize: 16,
                  color: textDarkSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // 4. Campo E-mail ou Usuário
              _buildInputField(
                label: 'E-mail ou Usuário',
                hintText: 'seuemail@dominio.com',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),

              // 5. Campo Senha
              _buildPasswordField(
                label: 'Senha',
                hintText: 'Digite sua senha',
                forgotPasswordPressed: () {
                  // Ação Esqueci minha senha
                },
              ),
              const SizedBox(height: 24),

              // 6. Botão Entrar
              ElevatedButton(
                onPressed: () {
                  // Navegar para a tela Home
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 24),

              // 7. Link Cadastre-se
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Ainda não tem uma conta? ',
                    style: TextStyle(color: textDarkSecondary),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Ação Cadastre-se
                    },
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textDarkPrimary,
            ),
          ),
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: textDarkPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: textDarkSecondary),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hintText,
    required VoidCallback forgotPasswordPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textDarkPrimary,
                ),
              ),
            ),
            GestureDetector(
              onTap: forgotPasswordPressed,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Esqueci minha senha',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        TextField(
          obscureText: _isPasswordObscured, // Para esconder a senha
          style: const TextStyle(color: textDarkPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: const Icon(Icons.lock, color: textDarkSecondary),
            // Ícone de olho (visibility)
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                color: textDarkSecondary,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordObscured = !_isPasswordObscured;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}