import 'package:flutter/material.dart';

// Definições de Cores (Consistentes com as telas anteriores)
const Color primaryColor = Color(0xFF137FEC); // Cor principal ajustada conforme o turmas.html
const Color backgroundDark = Color(0xFF101922);
const Color cardDark = Color(0xFF182635); // Usando cor de card mais próxima
const Color textDarkPrimary = Colors.white; 
const Color textDarkSecondary = Color(0xFF94A3B8); // Gray 400
const Color textDarkTertiary = Color(0xFF64748B); // Gray 500 para "32 Alunos"

// Estrutura de Dados para as Turmas
class ClassData {
  final String title;
  final String school;
  final int studentCount;
  final IconData icon;

  ClassData({
    required this.title,
    required this.school,
    required this.studentCount,
    required this.icon,
  });
}

// Dados de Exemplo
final List<ClassData> mockClasses = [
  ClassData(
    title: '3º Ano B - Matemática',
    school: 'Escola Estadual Prof. Anísio Teixeira',
    studentCount: 45,
    icon: Icons.calculate_outlined, // calculate no HTML
  ),
  ClassData(
    title: '9º Ano A - Português',
    school: 'Colégio Objetivo Central',
    studentCount: 38,
    icon: Icons.translate, // translate no HTML
  ),
  ClassData(
    title: '1º Ano C - Ciências',
    school: 'Escola Estadual Prof. Anísio Teixeira',
    studentCount: 32,
    icon: Icons.science_outlined, // science no HTML
  ),
];
class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuração do Tema (mantendo o tema escuro)
    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: primaryColor,
      cardColor: cardDark,
      dividerColor: Colors.white.withOpacity(0.1),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textDarkPrimary),
        bodyMedium: TextStyle(color: textDarkPrimary),
        titleLarge: TextStyle(color: textDarkPrimary, fontWeight: FontWeight.bold),
      ),
      iconTheme: const IconThemeData(color: textDarkPrimary),
    );

    return Theme(
      data: darkTheme,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildClassList(),
        floatingActionButton: _buildFloatingActionButton(),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  // --- 1. AppBar ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundDark.withOpacity(0.8), // Com efeito blur/opacidade
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Minhas Turmas',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textDarkPrimary,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: textDarkPrimary),
          onPressed: () {
            print('Menu Mais Opções pressionado');
          },
        ),
      ],
      // Adiciona um placeholder na esquerda para simular o espaçamento do HTML
      leading: const SizedBox(width: 48), 
    );
  }

  // --- 2. Lista de Turmas (Body) ---

  Widget _buildClassList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      itemCount: mockClasses.length,
      itemBuilder: (context, index) {
        final classData = mockClasses[index];
        return _buildClassCard(classData);
      },
    );
  }

  Widget _buildClassCard(ClassData data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          print('Turma ${data.title} clicada');
          // Ação para navegar para os detalhes da turma
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05), // bg-white/5 no HTML
            borderRadius: BorderRadius.circular(12.0),
            // Não precisa de borda, pois o fundo escuro já fornece contraste
          ),
          child: Row(
            children: [
              // Ícone (Círculo Primário)
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Icon(data.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              // Detalhes da Turma
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textDarkPrimary,
                      ),
                    ),
                    Text(
                      data.school,
                      style: TextStyle(
                        fontSize: 14,
                        color: textDarkSecondary,
                      ),
                    ),
                    Text(
                      '${data.studentCount} Alunos',
                      style: TextStyle(
                        fontSize: 12,
                        color: textDarkTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              // Ícone de Seta (chevron_right)
              Icon(Icons.chevron_right, color: textDarkTertiary),
            ],
          ),
        ),
      ),
    );
  }

  // --- 3. Floating Action Button ---

  Widget _buildFloatingActionButton() {
    // Usamos um Padding para simular a posição elevada acima da nav bar
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0), // Ajuste para ficar acima da nav bar
      child: FloatingActionButton(
        onPressed: () {
          print('Adicionar Turma pressionado');
          // Ação para adicionar nova turma
        },
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0), // Meio círculo
        ),
        elevation: 6.0,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }

  // --- 4. Bottom Navigation Bar ---

  Widget _buildBottomNavigationBar(BuildContext context) {
    const int currentIndex = 0; // Turmas é o primeiro item

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
        color: backgroundDark.withOpacity(0.8),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.school, 'Turmas', 0, currentIndex, true),
          _buildNavItem(context, Icons.task_alt, 'Frequência', 1, currentIndex, false),
          _buildNavItem(context, Icons.grade, 'Notas', 2, currentIndex, false),
          _buildNavItem(context, Icons.summarize, 'Relatórios', 3, currentIndex, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context,
      IconData icon,
      String label,
      int index,
      int currentIndex,
      bool isFilled) {
    final bool isActive = index == currentIndex;
    final Color color = isActive ? primaryColor : textDarkSecondary;
    
    // Simula o ícone preenchido (fill) se necessário, embora não seja nativo do BottomNavigationBar
    final IconData displayIcon = (isActive && isFilled) 
        ? icon 
        : icon; // Flutter usa ícones outline por padrão, aqui mantemos o mesmo ícone

    return Expanded(
      child: InkWell(
        onTap: () {
          // Lógica de navegação baseada no índice
          String route = '';
          if (index == 0) route = '/turmas';
          else if (index == 1) route = '/frequencia';
          else if (index == 2) route = '/notas';
          else if (index == 3) route = '/relatorios';

          if (route.isNotEmpty) {
            // Usar pushReplacementNamed se for uma navegação entre abas principais
            Navigator.pushReplacementNamed(context, route);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              displayIcon,
              color: color,
              size: 28, // text-2xl no HTML
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10, // text-xs no HTML
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}