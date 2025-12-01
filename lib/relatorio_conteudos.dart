import 'package:flutter/material.dart';

// Cores baseadas no seu HTML/Tailwind para o Dark Mode
const Color primaryColor = Color(0xFF135bec);
const Color backgroundDark = Color(0xFF101622);
const Color cardBg = Color(0xFF1e293b); // gray-800/50
const Color textDarkPrimary = Colors.white; 
const Color textDarkSecondary = Color(0xFF94a3b8); // gray-400
const Color inputBg = Color(0xFF334155); // gray-800
const Color inputBorder = Color(0xFF475569); // gray-700
const Color dateBoxBg = Color(0xFF475569); // gray-700


// Modelo para os dados do conteúdo (Aula)
class ContentEntry {
  final String dateDay;
  final String dateMonth;
  final String title;
  final String description;
  final String discipline;

  const ContentEntry({
    required this.dateDay,
    required this.dateMonth,
    required this.title,
    required this.description,
    required this.discipline,
  });
}

class ContentReportScreen extends StatelessWidget {
  const ContentReportScreen({super.key});

  static const List<ContentEntry> contentData = <ContentEntry>[
    ContentEntry(
      dateDay: '25',
      dateMonth: 'AGO',
      title: 'Álgebra: Resolução de equações de 2º grau',
      description: 'Introdução à fórmula de Bhaskara e exercícios práticos em sala. Discussão sobre as raízes reais e complexas.',
      discipline: 'Matemática',
    ),
    ContentEntry(
      dateDay: '23',
      dateMonth: 'AGO',
      title: 'Geometria: Teorema de Pitágoras',
      description: 'Aplicação do teorema em problemas práticos e demonstração geométrica. Atividades em duplas.',
      discipline: 'Matemática',
    ),
    ContentEntry(
      dateDay: '21',
      dateMonth: 'AGO',
      title: 'Trigonometria no triângulo retângulo',
      description: 'Definição de seno, cosseno e tangente. Resolução de exercícios com ângulos notáveis.',
      discipline: 'Matemática',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 1. Filtros de Seleção
                  _buildFiltersSection(),
                  const SizedBox(height: 24),
                  
                  // 2. Lista de Conteúdos
                  _buildContentList(),
                ],
              ),
            ),
          ),
          // 3. Barra de Navegação Inferior
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  // --- Widgets de Estrutura ---

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundDark.withValues(alpha: 0.8), // Fundo semi-transparente
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Relatório de Conteúdos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 40), // Espaço para centralizar o título
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.white.withValues(alpha: 0.1), // border-white/10
          height: 1.0,
        ),
      ),
    );
  }

  // --- 1. Filtros de Seleção ---

  Widget _buildFiltersSection() {
    return Column(
      children: [
        // Turma e Disciplina (em linha)
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _buildFilterDropdown(
                label: 'Turma',
                initialValue: '9º Ano A',
                items: const ['9º Ano A', 'Todas as Turmas'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFilterDropdown(
                label: 'Disciplina',
                initialValue: 'Matemática',
                items: const ['Matemática', 'Todas as Disciplinas'],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Bimestre (linha inteira)
        _buildFilterDropdown(
          label: 'Bimestre',
          initialValue: '1º Bimestre',
          items: const ['1º Bimestre', '2º Bimestre', '3º Bimestre', '4º Bimestre'],
        ),
      ],
    );
  }

  Widget _buildFilterDropdown({
    required String label,
    required String initialValue,
    required List<String> items,
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
              color: Color(0xFF94a3b8), // gray-300
            ),
          ),
        ),
        Container(
          height: 48, // Ajuste a altura do container do dropdown
          decoration: BoxDecoration(
            color: inputBg, // gray-800
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: inputBorder), // gray-700
          ),
          child: DropdownButtonFormField<String>(
            initialValue: initialValue,
            isExpanded: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            icon: const Icon(Icons.expand_more, color: textDarkSecondary),
            style: const TextStyle(
              fontSize: 16,
              color: textDarkPrimary,
            ),
            dropdownColor: inputBg,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              // Lógica de filtro
            },
          ),
        ),
      ],
    );
  }

  // --- 2. Lista de Conteúdos ---

  Widget _buildContentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contentData.map((content) => _buildContentCard(content)).toList(),
    );
  }

  Widget _buildContentCard(ContentEntry content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundDark.withValues(alpha: 0.5), // gray-800/50
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Caixa de Data
            Container(
              width: 60,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: dateBoxBg, // gray-700
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    content.dateMonth,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textDarkSecondary, // gray-400
                    ),
                  ),
                  Text(
                    content.dateDay,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDarkPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Título e Descrição
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textDarkPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: textDarkSecondary, // gray-400
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tag da Disciplina
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.2), // primary/20
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      content.discipline,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
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

  // --- 3. Barra de Navegação Inferior ---

  Widget _buildBottomNavBar() {
    // Para replicar o layout com BottomNavigationBar (ou Container fixo)
    return Container(
      height: 64, 
      decoration: BoxDecoration(
        color: backgroundDark.withValues(alpha: 0.8), // bg-background-dark/80 backdrop-blur-sm
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))), // border-white/10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.home, label: 'Início', isSelected: false),
          _buildNavItem(icon: Icons.calendar_today, label: 'Agenda', isSelected: false),
          _buildNavItem(icon: Icons.groups, label: 'Turmas', isSelected: false),
          _buildNavItem(icon: Icons.summarize, label: 'Relatórios', isSelected: true),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required bool isSelected}) {
    Color itemColor = isSelected ? primaryColor : textDarkSecondary; 
    
    return InkWell(
      onTap: () {
        // Lógica de navegação
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: itemColor,
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: itemColor,
            ),
          ),
        ],
      ),
    );
  }
}