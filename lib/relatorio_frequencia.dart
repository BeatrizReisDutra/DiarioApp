import 'package:flutter/material.dart';

// --- Dados de Exemplo ---
class AttendanceRecord {
  final String date;
  final String status; // 'P' for Presente, 'F' for Falta

  AttendanceRecord(this.date, this.status);
}

class Student {
  final String name;
  final List<AttendanceRecord> records;

  Student(this.name, this.records);
}

final List<String> dates = ['01/08', '03/08', '08/08', '10/08', '15/08', '17/08'];

final List<Student> students = [
  Student('Ana Silva', [
    AttendanceRecord('01/08', 'P'),
    AttendanceRecord('03/08', 'P'),
    AttendanceRecord('08/08', 'F'),
    AttendanceRecord('10/08', 'P'),
    AttendanceRecord('15/08', 'P'),
    AttendanceRecord('17/08', 'P')
  ]),
  Student('Bruno Costa', [
    AttendanceRecord('01/08', 'P'),
    AttendanceRecord('03/08', 'P'),
    AttendanceRecord('08/08', 'P'),
    AttendanceRecord('10/08', 'P'),
    AttendanceRecord('15/08', 'F'),
    AttendanceRecord('17/08', 'P')
  ]),
  Student('Carla Dias', [
    AttendanceRecord('01/08', 'F'),
    AttendanceRecord('03/08', 'F'),
    AttendanceRecord('08/08', 'P'),
    AttendanceRecord('10/08', 'P'),
    AttendanceRecord('15/08', 'P'),
    AttendanceRecord('17/08', 'P')
  ]),
  Student('Daniel Faria', [
    AttendanceRecord('01/08', 'P'),
    AttendanceRecord('03/08', 'P'),
    AttendanceRecord('08/08', 'P'),
    AttendanceRecord('10/08', 'P'),
    AttendanceRecord('15/08', 'P'),
    AttendanceRecord('17/08', 'P')
  ]),
  Student('Eduarda Lima', [
    AttendanceRecord('01/08', 'P'),
    AttendanceRecord('03/08', 'F'),
    AttendanceRecord('08/08', 'P'),
    AttendanceRecord('10/08', 'F'),
    AttendanceRecord('15/08', 'P'),
    AttendanceRecord('17/08', 'P')
  ]),
];

// --- Configurações de Cores ---
class AppColors {
  static const Color primary = Color(0xFF1173d4);
  static const Color backgroundDark = Color(0xFF101922);
  static const Color gray800 = Color(0xFF1f2937);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray300 = Color(0xFFd1d5db);
  static const Color gray200 = Color(0xFFe5e7eb);
  static const Color gray400 = Color(0xFF9ca3af);
  static const Color green500 = Color(0xFF10b981);
  static const Color red500 = Color(0xFFef4444);
}

// --- Componentes Reutilizáveis ---

class CustomDropdown extends StatelessWidget {
  final String label;
  final String hintText;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  
  const CustomDropdown({
    required this.label,
    required this.hintText,
    required this.items,
    this.selectedValue,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.gray300,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            color: AppColors.gray800,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.gray700),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedValue,
              hint: Text(
                hintText,
                style: const TextStyle(color: AppColors.gray400),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.gray300,
              ),
              dropdownColor: AppColors.gray800,
              style: const TextStyle(
                color: AppColors.gray200,
                fontSize: 16,
              ),
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// --- Tabela de Frequência ---

class AttendanceTable extends StatelessWidget {
  final List<Student> students;
  final List<String> dates;

  const AttendanceTable({
    required this.students,
    required this.dates,
    super.key,
  });

  Widget _buildStatusCell(String status) {
    Color color = status == 'P' ? AppColors.green500 : AppColors.red500;
    return Center(
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // A cor de fundo da coluna fixa (Aluno) deve ser a mesma do corpo da tabela (gray800)
    const Color stickyBackgroundColor = AppColors.gray800;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray800,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Cabeçalho da Tabela
          Container(
            decoration: const BoxDecoration(
              color: AppColors.gray700,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Row(
              children: [
                // Célula Aluno (Sticky Header)
                Container(
                  width: 150, // Largura fixa para a coluna do aluno
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'ALUNO',
                    style: TextStyle(
                      color: AppColors.gray300,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Cabeçalhos de Data (ScrollView)
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: dates.map((date) {
                        return Container(
                          width: 80, // Largura para cada coluna de data
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Text(
                            date,
                            style: const TextStyle(
                              color: AppColors.gray300,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Corpo da Tabela
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.gray700),
                  ),
                ),
                child: Row(
                  children: [
                    // Coluna Aluno (Sticky Column)
                    Container(
                      width: 150, // Deve ser a mesma largura do cabeçalho
                      padding: const EdgeInsets.all(16.0),
                      color: stickyBackgroundColor,
                      child: Text(
                        student.name,
                        style: const TextStyle(
                          color: AppColors.gray200,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // Dados de Frequência (ScrollView)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: student.records.map((record) {
                            return Container(
                              width: 80, // Deve ser a mesma largura do cabeçalho de data
                              padding: const EdgeInsets.all(16.0),
                              child: _buildStatusCell(record.status),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


// --- Tela Principal (Scaffold) ---

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  String? selectedClass;
  String? selectedSubject;
  String? selectedBimester;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      // 1. AppBar
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        title: const Text(
          'Relatório de Frequência',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: AppColors.gray700, height: 1.0),
        ),
      ),
      
      // 2. Botão Flutuante (Download)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação de Download
        },
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        elevation: 4.0,
        child: const Icon(Icons.download, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
      // 3. Corpo (Seletores e Tabela)
      body: Column(
        children: [
          // Formulário de Seleção
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomDropdown(
                  label: 'Turma',
                  hintText: 'Selecione a turma',
                  items: const ['Turma 101', 'Turma 102', 'Turma 103'],
                  selectedValue: selectedClass,
                  onChanged: (newValue) {
                    setState(() {
                      selectedClass = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        label: 'Disciplina',
                        hintText: 'Selecione a disciplina',
                        items: const ['Matemática', 'Português', 'História'],
                        selectedValue: selectedSubject,
                        onChanged: (newValue) {
                          setState(() {
                            selectedSubject = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomDropdown(
                        label: 'Bimestre',
                        hintText: 'Selecione o bimestre',
                        items: const [
                          '1º Bimestre',
                          '2º Bimestre',
                          '3º Bimestre',
                          '4º Bimestre'
                        ],
                        selectedValue: selectedBimester,
                        onChanged: (newValue) {
                          setState(() {
                            selectedBimester = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Tabela de Frequência
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: AttendanceTable(
                  students: students,
                  dates: dates,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 80), // Espaço para a Bottom Navigation Bar
        ],
      ),
      
      // 4. Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: AppColors.gray800,
          border: Border(
            top: BorderSide(color: AppColors.gray700),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.menu_book,
              label: 'Conteúdo e\nFrequência',
              isSelected: true, // Item Ativo
            ),
            _buildNavItem(
              icon: Icons.grade,
              label: 'Notas',
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    final color = isSelected ? AppColors.primary : AppColors.gray400;
    
    return InkWell(
      onTap: () {
        // Ação de navegação
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: color,
                height: 1.2, // Ajuste para quebra de linha
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Relatório de Frequência',
      theme: ThemeData(
        fontFamily: 'Inter', // Se você quiser usar a fonte Inter, precisa importá-la
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const AttendanceReportScreen(),
    );
  }
}