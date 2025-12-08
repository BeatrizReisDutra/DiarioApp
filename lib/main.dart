import 'package:flutter/material.dart';
import 'calendario.dart';
import 'home.dart';
import 'lancar_notas.dart';
import 'registro_conteudo_frequencia.dart';
import 'relatorio_conteudos.dart';
import 'relatorio_frequencia.dart';
import 'relatorio_notas.dart';
import 'relatorios.dart';
import 'turmas.dart';

void main() {
  runApp(const DiarioApp());
}

class DiarioApp extends StatelessWidget {
  const DiarioApp({super.key});

  static const Color primaryColor = Color(0xFF137fec);
  static const Color backgroundDark = Color(0xFF101922);
  static const Color foregroundDark = Color(0xFF182635);
  static const Color textDarkPrimary = Color(0xFFf8fafc);
  static const Color textDarkSecondary = Color(0xFF94a3b8);
  static const Color borderDark = Color(0xFF334155);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login DiárioApp',
      // Definição do tema para Modo Escuro
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        // Configurações do Scaffold/Background
        scaffoldBackgroundColor: backgroundDark,
        // Configurações de Input
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: foregroundDark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: borderDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: borderDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: primaryColor, width: 2.0),
          ),
          labelStyle: const TextStyle(color: textDarkPrimary),
          hintStyle: const TextStyle(color: textDarkSecondary),
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        ),
        // Configurações de Botão
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56), // h-14
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Configurações de Texto
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: textDarkPrimary),
          bodyMedium: TextStyle(color: textDarkPrimary),
          titleMedium: TextStyle(color: textDarkSecondary),
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: primaryColor,
        ),
        // A fonte 'Lexend' precisa ser adicionada ao pubspec.yaml para ser usada
        // O código a seguir assume que uma fonte padrão será usada se 'Lexend' não estiver disponível
        // fontFamily: 'Lexend', 
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/turmas': (context) => const ClassesScreen(),
        '/calendario': (context) => const CalendarioScreen(),
        '/relatorios': (context) => const ReportsScreen(),
        '/registration': (context) => const ClassAttendanceScreen(),
        '/lancar_notas': (context) => const GradeEntryScreen(),
        '/relatorio_frequencia': (context) => const AttendanceReportScreen(),
        '/relatorio_notas': (context) => const RelatorioNotasScreen(),
        '/relatorio_conteudos': (context) => const ContentReportScreen(),
        // Adicione outras rotas aqui conforme necessário
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
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400), // max-w-md
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // --- Logo e Título ---
                const Column(
                  children: [
                    Icon(
                      Icons.school, // Ícone 'school' do Material Symbols
                      size: 96, // text-8xl
                      color: DiarioApp.primaryColor,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'DiárioApp',
                      style: TextStyle(
                        fontSize: 32, // text-4xl
                        fontWeight: FontWeight.bold,
                        color: DiarioApp.textDarkPrimary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 48), // mt-8 + espaço

                // --- Campo E-mail ou Usuário ---
                const Text(
                  'E-mail ou Usuário',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: DiarioApp.textDarkPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'seuemail@dominio.com',
                    prefixIcon: Icon(Icons.person, color: DiarioApp.textDarkSecondary),
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0), // Aumenta a altura para h-14
                  ),
                ),

                const SizedBox(height: 16),

                // --- Campo Senha ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text(
                      'Senha',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: DiarioApp.textDarkPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Ação Esqueci minha senha
                      },
                      child: const Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: DiarioApp.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Digite sua senha',
                    prefixIcon: const Icon(Icons.lock, color: DiarioApp.textDarkSecondary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: DiarioApp.textDarkSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0), // Aumenta a altura para h-14
                  ),
                ),

                const SizedBox(height: 24), // Espaço antes do botão

                // --- Botão Entrar ---
                ElevatedButton(
                  onPressed: () {
                    // Navega para a tela Home e remove a tela de login da pilha
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Entrar'),
                ),

                const SizedBox(height: 24),

                // --- Link Cadastre-se ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ainda não tem uma conta? ',
                      style: TextStyle(
                        fontSize: 14,
                        color: DiarioApp.textDarkSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Ação Cadastre-se
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Cadastre-se',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: DiarioApp.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}