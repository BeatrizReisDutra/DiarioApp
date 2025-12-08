import 'package:flutter/material.dart';

class RelatorioNotasApp extends StatelessWidget {
  const RelatorioNotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relatório de Notas',
      theme: ThemeData(
        brightness: Brightness.dark, // Simula o tema escuro do HTML
        colorSchemeSeed: Colors.blue, // Cor primária semelhante ao "primary": "#137fec"
        fontFamily: 'Lexend', // Se a fonte não estiver carregada, usará a padrão
        useMaterial3: true,
      ),
      home: const RelatorioNotasScreen(),
    );
  }
}

class RelatorioNotasScreen extends StatelessWidget {
  const RelatorioNotasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar / Cabeçalho
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Relatório de Notas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          SizedBox(width: 48), // Espaço para centralizar o título
        ],
      ),
      // 2. Corpo Principal
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Campos de Seleção (Dropdowns)
            const SizedBox(height: 8.0),
            const _CustomDropdown(
              value: 'Turma 9A',
              items: ['Turma 9A', 'Turma 9B'],
            ),
            const SizedBox(height: 12.0),
            const _CustomDropdown(
              value: 'Matemática',
              items: ['Matemática', 'Português', 'Ciências', 'História', 'Geografia'],
            ),
            const SizedBox(height: 20.0),

            // Tabela de Notas
            _NotasTable(),
          ],
        ),
      ),
      // 3. Botão Flutuante (Floating Action Button)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação de Compartilhar
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.ios_share, color: Colors.white),
      ),
    );
  }
}

// Widget Customizado para simular o Dropdown com ícone
class _CustomDropdown extends StatelessWidget {
  final String value;
  final List<String> items;

  const _CustomDropdown({required this.value, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937), // Cor de fundo do campo (dark:bg-slate-800)
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFF475569)), // Cor da borda (dark:border-slate-700)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.unfold_more, color: Color(0xFF94A3B8)), // Cor do ícone (text-slate-400)
          isExpanded: true,
          style: const TextStyle(
            color: Colors.white, // Cor do texto do valor selecionado
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: const Color(0xFF1F2937), // Cor do fundo do menu dropdown
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Lógica para mudança de valor (omissa para este exemplo estático)
          },
        ),
      ),
    );
  }
}

// Widget para a Tabela de Notas
class _NotasTable extends StatelessWidget {
  final List<Map<String, dynamic>> notas = const [
    {'aluno': 'Ana Clara Souza', 'b1': 9.5, 'b2': 8.8, 'b3': 9.2, 'b4': '-'},
    {'aluno': 'Bruno Oliveira', 'b1': 7.0, 'b2': 8.0, 'b3': 7.5, 'b4': '-'},
    {'aluno': 'Carlos Pereira', 'b1': 5.5, 'b2': 5.8, 'b3': 6.5, 'b4': '-'},
    {'aluno': 'Daniela Martins', 'b1': 10.0, 'b2': 9.8, 'b3': 9.0, 'b4': '-'},
    {'aluno': 'Eduardo Costa', 'b1': 8.2, 'b2': 7.1, 'b3': 5.9, 'b4': '-'},
    {'aluno': 'Fernanda Lima', 'b1': 4.5, 'b2': 5.0, 'b3': 5.5, 'b4': '-'},
  ];

  // Função para determinar a cor da nota
  Color _getNotaColor(dynamic nota) {
    if (nota is double) {
      if (nota >= 7.0) return Colors.green.shade500; // text-green-500
      if (nota >= 6.0) return Colors.amber.shade500; // text-amber-500
      return Colors.red.shade500; // text-red-500
    }
    return Colors.grey.shade400; // Cor padrão para '-' (text-slate-400)
  }

  // Estilo do cabeçalho da coluna de notas
  final TextStyle _headerStyle = const TextStyle(
    color: Color(0xFF94A3B8), // dark:text-slate-400
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x801F2937), // dark:bg-slate-800/50
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFF1F2937)), // dark:border-slate-800
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: DataTable(
          columnSpacing: 0,
          horizontalMargin: 0,
          dataRowMinHeight: 52.0, // Equivalente a py-4
          dataRowMaxHeight: 52.0,
          headingRowHeight: 48.0, // Equivalente a py-3
          dividerThickness: 1.0,
          headingRowColor: MaterialStateProperty.resolveWith((states) => const Color(0xFF1F2937)), // dark:bg-slate-800
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('ALUNO', style: _headerStyle),
              ),
            ),
            DataColumn(
              label: Container(
                width: 64, // w-16 px-2
                alignment: Alignment.center,
                child: Text('1º BIM', style: _headerStyle),
              ),
            ),
            DataColumn(
              label: Container(
                width: 64, // w-16 px-2
                alignment: Alignment.center,
                child: Text('2º BIM', style: _headerStyle),
              ),
            ),
            DataColumn(
              label: Container(
                width: 64, // w-16 px-2
                alignment: Alignment.center,
                child: Text('3º BIM', style: _headerStyle),
              ),
            ),
            DataColumn(
              label: Container(
                width: 64, // w-16 px-2
                alignment: Alignment.center,
                child: Text('4º BIM', style: _headerStyle),
              ),
            ),
          ],
          rows: notas.map<DataRow>((data) {
            return DataRow(
              color: MaterialStateProperty.resolveWith((states) => Colors.transparent),
              cells: <DataCell>[
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      data['aluno'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white, // dark:text-white
                      ),
                    ),
                  ),
                ),
                DataCell(_buildGradeCell(data['b1'])),
                DataCell(_buildGradeCell(data['b2'])),
                DataCell(_buildGradeCell(data['b3'])),
                DataCell(_buildGradeCell(data['b4'])),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildGradeCell(dynamic grade) {
    String text = grade is double ? grade.toStringAsFixed(1) : grade.toString();
    Color color = _getNotaColor(grade);

    return Container(
      width: 64,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}