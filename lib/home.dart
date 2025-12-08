import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF4f80ff);
const Color backgroundDark = Color(0xFF121212);
const Color cardDark = Color(0xFF1e1e1e);
const Color textDarkPrimary = Color(0xFFF0F0F0); // Corrigido para a cor de texto primário
const Color textDarkSecondary = Color(0xFF9E9E9E); 
const Color errorColor = Color(0xFFEF5350);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Seção de Ações Principais
            _MainActionSection(),
            SizedBox(height: 32),
            // Seção de Relatórios
            _ReportSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // --- Widgets Auxiliares ---

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundDark,
      automaticallyImplyLeading: false, // Remove a seta de voltar padrão
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                // Foto de perfil
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/100'), // Imagem de perfil de exemplo
                ),
                const SizedBox(width: 12),
                // Saudação
                const Text(
                  'Olá, Professor!',
                  style: TextStyle(
                    color: textDarkPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // Ícones de Notificações e Sair
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: textDarkPrimary, size: 24),
                  onPressed: () {
                    print('Notificações pressionado');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: errorColor, size: 24),
                  onPressed: () {
                    // Lógica de logout: volta para a tela de login e remove as telas anteriores
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    // Index 0 é 'Início'
    const int currentIndex = 0; 

    // O Material 3 usa NavigationBar por padrão, mas BottomNavigationBar
    // é mais simples para este layout
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade800)),
        color: backgroundDark.withOpacity(0.9), // Efeito de transparência/blur
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // Lógica para navegar entre as telas usando as rotas nomeadas
          switch (index) {
            case 0:
              // Já está na Home, não faz nada
              break;
            case 1: // Turmas
              Navigator.pushNamed(context, '/turmas');
              break;
            case 2: // Calendário
              Navigator.pushNamed(context, '/calendario');
              break;
            case 3: // Relatórios
              Navigator.pushNamed(context, '/relatorios');
              break;
          }
        },
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove a sombra
        type: BottomNavigationBarType.fixed, // Garante que todos os itens fiquem visíveis
        selectedItemColor: primaryColor,
        unselectedItemColor: textDarkSecondary,
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ícone preenchido para o item ativo
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
            icon: Icon(Icons.assessment_outlined),
            label: 'Relatórios',
          ),
        ],
      ),
    );
  }
}

// --- Seção de Ações Principais (Lançamentos) ---

class _MainActionSection extends StatelessWidget {
  const _MainActionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Lançar Conteúdo e Frequência
        _buildActionCard(
          icon: Icons.edit_calendar,
          title: 'Lançar Conteúdo e Frequência',
          subtitle: 'Registre a aula de hoje',
          backgroundColor: primaryColor,
          textColor: Colors.white,
          subtitleColor: Colors.white.withOpacity(0.8),
          onTap: () {
            print('Lançar Conteúdo e Frequência pressionado');
            Navigator.pushNamed(context, '/registration');
          },
        ),
        const SizedBox(height: 16),
        // 2. Lançar Notas
        _buildActionCard(
          icon: Icons.school,
          title: 'Lançar Notas',
          subtitle: 'Insira as notas bimestrais',
          backgroundColor: cardDark,
          textColor: textDarkPrimary,
          subtitleColor: textDarkSecondary,
          iconColor: primaryColor,
          onTap: () {
            print('Lançar Notas pressionado');
            Navigator.pushNamed(context, '/lancar_notas');
          },
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required Color textColor,
    required Color subtitleColor,
    Color iconColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 96,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          border: backgroundColor == cardDark ? Border.all(color: Colors.grey.shade800) : null,
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 40, color: iconColor),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Seção de Relatórios ---

class _ReportSection extends StatelessWidget {
  const _ReportSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Relatórios',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textDarkPrimary,
          ),
        ),
        const SizedBox(height: 16),
        // Lista de Relatórios
        _buildReportItem(
          icon: Icons.assessment,
          title: 'Relatório de Notas',
          onTap: () => Navigator.pushNamed(context, '/relatorio_notas'),
        ),
        const SizedBox(height: 12),
        _buildReportItem(
          icon: Icons.menu_book,
          title: 'Relatório de Conteúdos',
          onTap: () => Navigator.pushNamed(context, '/relatorio_conteudos'),
        ),
        const SizedBox(height: 12),
        _buildReportItem(
          icon: Icons.task_alt,
          title: 'Relatório de Frequência',
          onTap: () => Navigator.pushNamed(context, '/relatorio_frequencia'),
        ),
      ],
    );
  }

  Widget _buildReportItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardDark,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade800),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: primaryColor),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textDarkPrimary,
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: textDarkSecondary),
          ],
        ),
      ),
    );
  }
}
