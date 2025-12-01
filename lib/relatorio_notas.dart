import 'package:flutter/material.dart';

// Cores e constantes
const Color primaryColor = Color(0xFF137fec);
const Color scorePass = Color(0xFF22c55e); // green-500
const Color scoreWarning = Color(0xFFf59e0b); // amber-500
const Color scoreFail = Color(0xFFef4444); // red-500

// Modelo de Dados para a Tabela
class StudentReport {
  final String name;
  final List<double?> scores; // Pode ser null se a nota não foi lançada

  const StudentReport({required this.name, required this.scores});
}

class GradeReportScreen extends StatelessWidget {
  const GradeReportScreen({super.key});

  // Dados de exemplo para o relatório
  static const List<StudentReport> reportData = <StudentReport>[
    StudentReport(name: 'Ana Clara Souza', scores: <double?>[9.5, 8.8, 9.2, null]),
    StudentReport(name: 'Bruno Oliveira', scores: <double?>[7.0, 8.0, 7.5, null]),
    StudentReport(name: 'Carlos Pereira', scores: <double?>[5.5, 5.8, 6.5, null]),
    StudentReport(name: 'Daniela Martins', scores: <double?>[10.0, 9.8, 9.0, null]),
    StudentReport(name: 'Eduardo Costa', scores: <double?>[8.2, 7.1, 5.9, null]),
    StudentReport(name: 'Fernanda Lima', scores: <double?>[4.5, 5.0, 5.5, null]),
  ];

  // Função para determinar a cor da nota baseado no valor
  Color _getScoreColor(BuildContext context, double score) {
    if (score >= 7.0) return scorePass;
    if (score >= 6.0) return scoreWarning;
    return scoreFail;
  }

  // --- Widgets de Estrutura ---

  @override
  Widget build(BuildContext context) {
    final Color cardBg = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1e293b).withValues(alpha: 0.5) // slate-800/50
        : Colors.white;
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context, textColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
        child: Column(
          children: <Widget>[
            // Filtros de Turma e Disciplina
            const SizedBox(height: 16),
            _buildFilterDropdown(context, 'Turma 9A', ['Turma 9A', 'Turma 9B']),
            const SizedBox(height: 12),
            _buildFilterDropdown(context, 'Matemática', ['Matemática', 'Português', 'Ciências', 'História', 'Geografia']),
            const SizedBox(height: 24),

            // Tabela de Notas
            _buildGradesTable(context, cardBg),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingShareButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, Color textColor) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: textColor, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Relatório de Notas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(width: 48), // Espaço para centralizar o título
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
          height: 1.0,
        ),
      ),
    );
  }

  // --- Componentes de Filtro (Dropdown) ---

  Widget _buildFilterDropdown(BuildContext context, String initialValue, List<String> items) {
    final Color inputBg = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade800
        : Colors.white;
    final Color inputBorder = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade700
        : Colors.grey.shade300;
    final Color dropdownIconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade400
        : Colors.grey.shade500;
    final Color itemTextColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: inputBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: inputBorder),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButtonFormField<String>(
        initialValue: initialValue,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        icon: Icon(Icons.unfold_more, color: dropdownIconColor),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: itemTextColor,
        ),
        dropdownColor: inputBg,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // Lógica para filtrar o relatório
        },
      ),
    );
  }

  // --- Tabela de Notas ---

  Widget _buildGradesTable(BuildContext context, Color cardBg) {
    final Color headerBg = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade800
        : Colors.grey.shade50;
    final Color headerTextColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade400
        : Colors.grey.shade600;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 10,
            horizontalMargin: 0,
            dataRowMinHeight: 56,
            dataRowMaxHeight: 56,
            headingRowColor: WidgetStateProperty.all(headerBg),
            dividerThickness: 1,
            columns: [
              DataColumn(
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('ALUNO', style: TextStyle(fontWeight: FontWeight.bold, color: headerTextColor, fontSize: 12)),
                ),
              ),
              ...List.generate(4, (index) => DataColumn(
                label: SizedBox(
                  width: 50, // w-16 aprox.
                  child: Text('${index + 1}º BIM', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: headerTextColor, fontSize: 12)),
                ),
              )),
            ],
            rows: reportData.map((data) => _buildDataRow(context, data)).toList(),
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(BuildContext context, StudentReport data) {
    final Color rowTextColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    final Color unlaunchedScoreColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade400
        : Colors.grey.shade500;

    return DataRow(
      cells: [
        // Coluna do Aluno
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(data.name, style: TextStyle(fontWeight: FontWeight.w500, color: rowTextColor)),
        )),
        // Colunas de Notas (B1 a B4)
        ...data.scores.map((score) {
          final String displayScore = score?.toStringAsFixed(1) ?? '-';
          final Color scoreColor = score == null
              ? unlaunchedScoreColor
              : _getScoreColor(context, score);

          return DataCell(SizedBox(
            width: 50,
            child: Text(
              displayScore,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: scoreColor,
              ),
            ),
          ));
        }),
      ],
    );
  }

  // --- Botão Flutuante (Compartilhar) ---

  Widget _buildFloatingShareButton() {
    return FloatingActionButton(
      onPressed: () {
        // Ação: Compartilhar ou exportar relatório
      },
      backgroundColor: primaryColor,
      shape: const CircleBorder(),
      elevation: 6,
      child: const Icon(Icons.ios_share, color: Colors.white, size: 30),
    );
  }
}