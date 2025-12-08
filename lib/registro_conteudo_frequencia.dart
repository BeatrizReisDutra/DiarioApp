import 'package:flutter/material.dart';

// --- Dados Mockados (Simulando informações) ---
enum AttendanceStatus { present, absent, notSelected }

class Student {
  final String name;
  AttendanceStatus status;

  Student({required this.name, required this.status});
}

final List<Student> mockStudents = [
  Student(name: 'Ana Júlia Oliveira', status: AttendanceStatus.notSelected),
  Student(name: 'Bruno Costa', status: AttendanceStatus.notSelected),
  Student(name: 'Carlos Eduardo Pereira', status: AttendanceStatus.notSelected),
  Student(name: 'Daniela Martins', status: AttendanceStatus.notSelected),
];

// --- Tema e Cores (Adaptando do HTML/CSS) ---
const Color primaryColor = Color(0xFF137fec);
const Color backgroundColorDark = Color(0xFF101922);
const Color slate800 = Color(0xFF1e293b); // Cor similar ao bg do card
const Color slate900_50 = Color(0xFF1a2430); // Cor similar ao bg do input
const Color textSlate50 = Color(0xFFf8fafc);
const Color textSlate300 = Color(0xFFcbd5e1);
const Color textSlate400 = Color(0xFF94a3b8);
const Color green900_50 = Color(0xFF103a1d); // Cor similar ao bg do 'P'
const Color green300 = Color(0xFF6ee7b7); // Cor similar ao texto do 'P'
const Color red900_50 = Color(0xFF5f1d1d); // Cor similar ao bg do 'F'
const Color red300 = Color(0xFFf87171); // Cor similar ao texto do 'F'

// --- Widget Principal ---
class ClassAttendanceScreen extends StatelessWidget {
  const ClassAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColorDark,
        brightness: Brightness.dark,
        fontFamily: 'Lexend', // Assumindo que a fonte 'Lexend' está configurada ou usando a padrão
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFF334155)), // slate-700
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFF334155)), // slate-700
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: primaryColor),
          ),
          fillColor: slate900_50,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          labelStyle: const TextStyle(color: textSlate400),
          hintStyle: const TextStyle(color: Color(0xFF64748b)), // placeholder slate-500
        ),
      ),
      home: const ClassDetailView(),
    );
  }
}

class ClassDetailView extends StatefulWidget {
  const ClassDetailView({super.key});

  @override
  State<ClassDetailView> createState() => _ClassDetailViewState();
}

class _ClassDetailViewState extends State<ClassDetailView> {
  late List<Student> _students;

  @override
  void initState() {
    super.initState();
    _students = List<Student>.from(mockStudents.map((s) => Student(name: s.name, status: s.status)));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorDark.withOpacity(0.8),
        elevation: 0,
        toolbarHeight: 64,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFcbd5e1)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          children: [
            Text(
              'Conteúdo da Aula',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textSlate50),
            ),
            Text(
              '25 de Julho de 2024',
              style: TextStyle(fontSize: 12, color: textSlate400),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFFcbd5e1)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120), // Espaço para a Bottom Nav Bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Seção de Filtros ---
            _buildSectionTitle('Filtros'),
            const SizedBox(height: 12),
            _buildFiltersCard(),
            const SizedBox(height: 24),

            // --- Seção de Conteúdo da Aula ---
            _buildSectionTitle('Conteúdo da Aula'),
            const SizedBox(height: 12),
            _buildContentCard(),
            const SizedBox(height: 24),

            // --- Seção de Frequência ---
            _buildAttendanceHeader(),
            const SizedBox(height: 12),
            ..._students.map((student) => _buildAttendanceRow(student)).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.save, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  void _updateAttendance(Student student, AttendanceStatus newStatus) {
    setState(() {
      // Se o botão clicado já representa o estado atual, desmarca (volta para notSelected)
      if (student.status == newStatus) {
        student.status = AttendanceStatus.notSelected;
      } else {
        student.status = newStatus;
      }
    });
  }

  void _markAllAsPresent() {
    setState(() {
      for (final student in _students) {
        student.status = AttendanceStatus.present;
      }
    });
  }


  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: textSlate50),
    );
  }

  Widget _buildFiltersCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: slate800,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, offset: Offset(0, 2), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          _buildDropdownFilter('Turma', ['9º Ano A', '9º Ano B', '1º Ano Médio'],
              '9º Ano A'),
          const SizedBox(height: 16),
          _buildDropdownFilter('Disciplina', ['Matemática', 'Física', 'Química'],
              'Matemática'),
          const SizedBox(height: 16),
          _buildDatePicker('Dia', '25/07/2024'),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter(
      String label, List<String> items, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textSlate400)),
        ),
        DropdownButtonFormField<String>(
          value: initialValue,
          icon: const Icon(Icons.keyboard_arrow_down, color: textSlate400),
          style: const TextStyle(color: textSlate300, fontSize: 16),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          dropdownColor: slate800,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Lógica para mudar o valor
          },
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textSlate400)),
        ),
        TextFormField(
          initialValue: value,
          readOnly: true,
          decoration: const InputDecoration(
            isDense: true,
            prefixIcon: Icon(Icons.calendar_month, color: textSlate400, size: 24),
            suffixIcon: Icon(Icons.keyboard_arrow_down, color: textSlate400),
          ),
          onTap: () async {
            // Lógica para abrir o seletor de data
          },
        ),
      ],
    );
  }

  Widget _buildContentCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: slate800,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, offset: Offset(0, 2), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Tópico da Aula',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textSlate400)),
          ),
          TextFormField(
            initialValue: 'Conceitos básicos de álgebra',
            decoration: const InputDecoration(
              hintText: 'Ex: Equações de 1º Grau',
              isDense: true,
            ),
            style: const TextStyle(color: textSlate300),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue:
                'Nesta aula, introduzimos os conceitos básicos de álgebra, incluindo variáveis, expressões e a importância de resolver para o desconhecido. Os alunos participaram de atividades práticas para solidificar o entendimento.',
            maxLines: 6,
            minLines: 6,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: 'Descreva o conteúdo da aula...',
              isDense: false,
              contentPadding: EdgeInsets.all(16),
            ),
            style: const TextStyle(color: textSlate300),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Frequência',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: textSlate50),
        ),
        Row(
          children: [
            const Text(
              'Marcar todos como:',
              style: TextStyle(fontSize: 14, color: textSlate400),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: _markAllAsPresent,
              borderRadius: BorderRadius.circular(9999),
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: green900_50,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text('P',
                    style: TextStyle(
                        color: green300,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAttendanceRow(Student student) {
    final status = student.status;
    const double buttonWidth = 44;
    const double buttonHeight = 36;
    const double borderRadius = 8;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: slate800,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 1), blurRadius: 2),
          ],
        ),
        child: Row(
          children: [
            // Avatar Placeholder (usando um CircleAvatar com cor aleatória para simular a foto)
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(
                  (student.name.hashCode * 0xFFFFFF).toInt() % 0xFFFFFFFF),
              child: Text(student.name.substring(0, 1),
                  style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(student.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: textSlate50)),
            ),
            Row(
              children: [
                // Botão de Presença (P)
                SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () => _updateAttendance(student, AttendanceStatus.present),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: status == AttendanceStatus.present ? green900_50 : const Color(0xFF334155), // slate-700
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius)),
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      elevation: 0,
                    ),
                    child: Text('P',
                        style: TextStyle(
                            color: status == AttendanceStatus.present ? green300 : textSlate300,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 8),
                // Botão de Falta (F)
                SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () => _updateAttendance(student, AttendanceStatus.absent),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: status == AttendanceStatus.absent ? red900_50 : const Color(0xFF334155), // slate-700 / red-900/50
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius)),
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      elevation: 0,
                    ),
                    child: Text('F',
                        style: TextStyle(
                            color: status == AttendanceStatus.absent ? red300 : textSlate300,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: backgroundColorDark, // bg-background-dark/95
        border: Border(top: BorderSide(color: Color(0xFF1e293b))), // border-slate-800
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(
            icon: Icons.home,
            label: 'Início',
            isSelected: false,
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
          ),
          const _NavBarItem(icon: Icons.school, label: 'Aulas', isSelected: true),
          const _NavBarItem(icon: Icons.checklist, label: 'Frequência', isSelected: false),
          const _NavBarItem(icon: Icons.assessment, label: 'Notas', isSelected: false),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? primaryColor : textSlate400,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? primaryColor : textSlate400,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// Para executar no DartPad ou no seu projeto Flutter:
// void main() {
//   runApp(const ClassAttendanceScreen());
// }