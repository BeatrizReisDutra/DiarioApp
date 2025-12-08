import 'package:flutter/material.dart';

// Definições de Cores (Consistentes com as telas anteriores)
const Color primaryColor = Color(0xFF4f80ff);
const Color backgroundDark = Color(0xFF121212);
const Color cardDark = Color(0xFF1e1e1e);
const Color textDarkPrimary = Color(0xFFF0F0F0); 
const Color textDarkSecondary = Color(0xFF9E9E9E); 
const Color errorColor = Color(0xFFEF5350); 

// Estrutura de Dados para os Relatórios
class ReportItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  ReportItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}

// Lista de Relatórios
final List<ReportItem> mockReports = [
  ReportItem(
    title: 'Relatório de Notas',
    subtitle: 'Visualize as notas dos alunos',
    icon: Icons.assessment, // assessment
    route: '/relatorio_notas',
  ),
  ReportItem(
    title: 'Relatório de Conteúdos',
    subtitle: 'Acesse o conteúdo lecionado',
    icon: Icons.menu_book, // menu_book
    route: '/relatorio_conteudos',
  ),
  ReportItem(
    title: 'Relatório de Frequência',
    subtitle: 'Confira a frequência das turmas',
    icon: Icons.task_alt, // task_alt
    route: '/relatorio_frequencia',
  ),
];
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuração do Tema (mantendo o tema escuro)
    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: primaryColor,
      cardColor: cardDark,
      dividerColor: Colors.grey.shade800,
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
        body: _buildReportList(context),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  // --- 1. AppBar ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundDark,
      automaticallyImplyLeading: false, // Oculta o botão Back/Voltar padrão
      elevation: 0,
      title: const Text(
        'Central de Relatórios',
        style: TextStyle(
          fontSize: 20, // text-xl no HTML
          fontWeight: FontWeight.bold,
          color: textDarkPrimary,
        ),
      ),
      actions: [
        // Ícone de Filtro (filter_list)
        IconButton(
          icon: const Icon(
            Icons.filter_list,
            color: textDarkPrimary,
          ),
          onPressed: () {
            print('Filtro pressionado');
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // --- 2. Lista de Relatórios (Body) ---

  Widget _buildReportList(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        children: mockReports.map((report) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildReportCard(context, report),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, ReportItem report) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, report.route),
      child: Container(
        height: 96,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardDark,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade800),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            // Ícone do Relatório
            Icon(
              report.icon,
              size: 40, // !text-4xl no HTML
              color: primaryColor,
            ),
            const SizedBox(width: 16),
            // Título e Subtítulo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    report.title,
                    style: const TextStyle(
                      fontSize: 18, // text-lg no HTML
                      fontWeight: FontWeight.bold,
                      color: textDarkPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    report.subtitle,
                    style: TextStyle(
                      fontSize: 14, // text-sm no HTML
                      color: textDarkSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 3. Bottom Navigation Bar ---

  Widget _buildBottomNavigationBar(BuildContext context) {
    const int currentIndex = 3; // Relatórios é o último item (índice 3)

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade800)),
        color: backgroundDark.withOpacity(0.9),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/turmas');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/calendario');
              break;
            case 3:
              // Já está na tela Relatórios
              break;
          }
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: textDarkSecondary,
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: 'Turmas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment), // Ícone preenchido para o item ativo (assessment)
            label: 'Relatórios',
          ),
        ],
      ),
    );
  }
}