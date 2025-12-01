import 'package:flutter/material.dart';

// Cores baseadas no seu HTML/Tailwind para o Dark Mode
const Color primaryColor = Color(0xFF1173d4);
const Color backgroundDark = Color(0xFF101922);
const Color cardBgDark = Color(0xFF1f2937); // gray-800
const Color inputBgDark = Color(0xFF374151); // gray-800
const Color inputBorderDark = Color(0xFF4b5563); // gray-700
const Color textDarkPrimary = Colors.white;
const Color textDarkSecondary = Color(0xFFd1d5db); // gray-300
const Color textHeaderDark = Color(0xFFd1d5db); // gray-300
const Color scorePresent = Color(0xFF10b981); // green-500
const Color scoreAbsent = Color(0xFFef4444); // red-500

// Modelo de Dados para a Tabela
class AttendanceReport {
  final String name;
  // Lista de status: 'P', 'F', 'J', etc.
  final List<String> status; 

  const AttendanceReport({required this.name, required this.status});
}

class AttendanceReportScreen extends StatelessWidget {
  const AttendanceReportScreen({super.key});

  static const List<String> dates = <String>['01/08', '03/08', '08/08', '10/08', '15/08', '17/08'];
  
  static const List<AttendanceReport> reportData = <AttendanceReport>[
    AttendanceReport(name: 'Ana Silva', status: ['P', 'P', 'F', 'P', 'P', 'P']),
    AttendanceReport(name: 'Bruno Costa', status: ['P', 'P', 'P', 'P', 'F', 'P']),
    AttendanceReport(name: 'Carla Dias', status: ['F', 'F', 'P', 'P', 'P', 'P']),
    AttendanceReport(name: 'Daniel Faria', status: ['P', 'P', 'P', 'P', 'P', 'P']),
    AttendanceReport(name: 'Eduarda Lima', status: ['P', 'F', 'P', 'F', 'P', 'P']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          // 1. Filtros de Seleção (Turma, Disciplina, Bimestre)
          _buildFiltersSection(),
          
          // 2. Tabela de Frequência
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildAttendanceTable(),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingDownloadButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- Widgets de Estrutura ---

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundDark,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Relatório de Frequência',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 48), // Espaço para centralizar o título
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.shade700, // border-gray-700
          height: 1.0,
        ),
      ),
    );
  }
  
  // --- 1. Filtros de Seleção ---

  Widget _buildFiltersSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Turma (linha inteira)
          _buildFilterDropdown(
            label: 'Turma',
            initialValue: 'Selecione a turma',
            items: const ['Selecione a turma', 'Turma 101', 'Turma 102', 'Turma 103'],
          ),
          const SizedBox(height: 16),
          
          // Disciplina e Bimestre (em linha)
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(
                  label: 'Disciplina',
                  initialValue: 'Selecione a disciplina',
                  items: const ['Selecione a disciplina', 'Matemática', 'Português', 'História'],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildFilterDropdown(
                  label: 'Bimestre',
                  initialValue: 'Selecione o bimestre',
                  items: const ['Selecione o bimestre', '1º Bimestre', '2º Bimestre', '3º Bimestre', '4º Bimestre'],
                ),
              ),
            ],
          ),
        ],
      ),
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
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textDarkSecondary,
            ),
          ),
        ),
        Container(
          height: 56, // h-14
          decoration: BoxDecoration(
            color: inputBgDark, // gray-800
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: inputBorderDark), // gray-700
          ),
          child: DropdownButtonFormField<String>(
            initialValue: initialValue,
            isExpanded: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: textDarkSecondary),
            style: const TextStyle(
              fontSize: 16,
              color: textDarkPrimary,
            ),
            dropdownColor: inputBgDark,
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

  // --- 2. Tabela de Frequência ---

  Widget _buildAttendanceTable() {
    return Container(
      decoration: BoxDecoration(
        color: cardBgDark, // gray-800
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 12,
            horizontalMargin: 12,
            dataRowMinHeight: 56,
            dataRowMaxHeight: 56,
            headingRowHeight: 56,
            dividerThickness: 1,
            // A cor da linha separadora e do cabeçalho é tratada abaixo
            
            columns: [
              // Coluna ALUNO (Fixo à esquerda)
              DataColumn(
                label: Container(
                  width: 120, // Largura suficiente para o nome
                  padding: const EdgeInsets.only(left: 16),
                  child: const Text('ALUNO', style: TextStyle(fontWeight: FontWeight.bold, color: textHeaderDark, fontSize: 14)),
                ),
              ),
              // Colunas de Datas
              ...dates.map((date) => DataColumn(
                label: SizedBox(
                  width: 50, // Largura para a data
                  child: Text(date, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: textHeaderDark, fontSize: 14)),
                ),
              )),
            ],
            rows: reportData.map((data) => _buildDataRow(data)).toList(),
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(AttendanceReport data) {
    // Para simular a coluna ALUNO fixa com um fundo diferente
    const Color stickyBgColor = cardBgDark; 

    return DataRow(
      color: WidgetStateProperty.all(cardBgDark),
      cells: [
        // Célula do Aluno (Fixo)
        DataCell(Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: const BoxDecoration(
            color: stickyBgColor,
            border: Border(right: BorderSide(color: inputBorderDark, width: 0.5)),
          ),
          alignment: Alignment.centerLeft,
          child: Text(data.name, style: const TextStyle(fontWeight: FontWeight.normal, color: textDarkPrimary, fontSize: 14)),
        )),
        // Células de Status (P/F)
        ...data.status.map((status) {
          final Color statusColor = status == 'P' ? scorePresent : scoreAbsent;

          return DataCell(SizedBox(
            width: 50,
            child: Center(
              child: Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
          ));
        }),
      ],
      // Linha divisória
      // Nota: A linha divisória da DataTable do Flutter é controlada pelo 'dividerThickness'.
      // Para o tema escuro, a cor padrão do divisor será escura, simulando 'divide-gray-700'.
    );
  }

  // --- Botão Flutuante (Download) ---

  Widget _buildFloatingDownloadButton() {
    return FloatingActionButton(
      onPressed: () {
        // Ação: Exportar/baixar o relatório
      },
      backgroundColor: primaryColor,
      shape: const CircleBorder(),
      elevation: 6,
      child: const Icon(Icons.download, color: Colors.white, size: 30),
    );
  }
  
  // --- Barra de Navegação Inferior ---

  Widget _buildBottomNavBar() {
    return Container(
      height: 64, 
      decoration: BoxDecoration(
        color: inputBgDark, // gray-800
        border: Border(top: BorderSide(color: inputBorderDark)), // border-gray-700
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.menu_book, label: 'Conteúdo e Frequência', isSelected: true),
          _buildNavItem(icon: Icons.grade, label: 'Notas', isSelected: false),
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
          SizedBox(
            width: 120, // Largura fixa para texto de duas linhas
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: itemColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}