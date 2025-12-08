import 'package:flutter/material.dart';
import 'package:diarioapp/relatorio_conteudos.dart'; // Importar para acessar a lista e o modelo
import 'package:diarioapp/dados_frequencia.dart'; // Importar dados de frequência

// --- Dados Mockados (Simulando informações) ---
enum AttendanceStatus { present, absent, notSelected }

class Student {
  final String name;
  AttendanceStatus status;

  Student({required this.name, required this.status});
}

// Mapeamento de alunos por turma para simular um banco de dados
final Map<String, List<String>> studentsByClass = {
  '9º Ano A': [
    'Ana Júlia Oliveira',
    'Bruno Costa',
    'Carlos Eduardo Pereira',
    'Daniela Martins',
  ],
  '9º Ano B': [
    'Eduardo Lima',
    'Fernanda Alves',
    'Gustavo Ribeiro',
    'Helena Souza',
  ],
  '1º Ano C': [
    'Igor Santos',
    'Joana Ferreira',
    'Lucas Almeida',
    'Mariana Barbosa',
  ],
};



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
    // O MaterialApp foi removido. Agora esta tela herda o tema e a navegação
    // do MaterialApp principal definido em 'main.dart'.
    // Isso permite que o Navigator.pop(context) funcione corretamente.
    return const ClassDetailView();
  }
}

class ClassDetailView extends StatefulWidget {
  const ClassDetailView({super.key});

  @override
  State<ClassDetailView> createState() => _ClassDetailViewState();
}

class _ClassDetailViewState extends State<ClassDetailView> {
  late List<Student> _students;
  
  // Controladores para os campos de texto
  final _topicController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Variáveis para guardar o estado dos filtros
  String? _selectedClass;
  String? _selectedSubject;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _students = []; // Começa com a lista de alunos vazia
  }
  
  @override
  void dispose() {
    // Limpar os controladores quando o widget for descartado
    _topicController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveContent() {
    // 1. Validar se todos os campos foram preenchidos
    if (_selectedClass == null || _selectedSubject == null || _selectedDate == null) {
      _showErrorSnackBar('Por favor, selecione turma, disciplina e dia.');
      return;
    }
    if (_topicController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Por favor, preencha o tópico e a descrição da aula.'),
        ),
      );
      return;
    }

    // --- Lógica para salvar a Frequência ---
    final String currentDate = '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}';

    // Adiciona a nova data à lista de datas registradas, se ainda não existir.
    if (!registeredDates.contains(currentDate)) {
      registeredDates.add(currentDate);
      registeredDates.sort(); // Mantém as datas ordenadas
    }

    // Atualiza o registro de cada aluno
    for (var studentState in _students) {
      // Encontra o aluno correspondente no "banco de dados"
      final studentDb = allStudentsAttendance.firstWhere((s) => s.name == studentState.name);

      // Remove qualquer registro antigo para esta data para evitar duplicatas
      studentDb.records.removeWhere((rec) => rec.date == currentDate);

      // Adiciona o novo registro se o status não for "não selecionado"
      if (studentState.status != AttendanceStatus.notSelected) {
        final newStatus = studentState.status == AttendanceStatus.present ? 'P' : 'F';
        studentDb.records.add(AttendanceRecord(currentDate, newStatus));
        // Ordena os registros do aluno por data
        studentDb.records.sort((a, b) => a.date.compareTo(b.date));
      }
    }
    // --- Fim da lógica de Frequência ---

    // 2. Criar o novo registro de conteúdo
    final newEntry = ContentEntry(
      dateDay: _selectedDate!.day.toString(),
      dateMonth: _getMonthAbbreviation(_selectedDate!.month),
      title: _topicController.text,
      description: _descriptionController.text,
      discipline: _selectedSubject!,
      className: _selectedClass!,
    );

    // 3. Adicionar conteúdo à lista global
    setState(() {
      contentData.insert(0, newEntry);
    });

    // 4. Exibir mensagem de sucesso e permanecer na tela
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Conteúdo e Frequência salvos com sucesso!'),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
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
        title: Column(
          children: [
            Text(
              'Conteúdo da Aula',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textSlate50),
            ),
            Text(
              _selectedDate != null
                  ? '${_selectedDate!.day} de ${_getMonthName(_selectedDate!.month)} de ${_selectedDate!.year}'
                  : 'Selecione uma data',
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
            
            // Mostra o conteúdo e a frequência apenas se uma turma for selecionada
            if (_selectedClass != null) ...[
              // --- Seção de Conteúdo da Aula ---
              _buildSectionTitle('Conteúdo da Aula'),
              const SizedBox(height: 12),
              _buildContentCard(),
              const SizedBox(height: 24),
              // --- Seção de Frequência ---
              _buildAttendanceHeader(context),
              const SizedBox(height: 12),
              ..._students.map((student) => _buildAttendanceRow(student)).toList(),
            ]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveContent,
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.save, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // Atualiza a lista de alunos com base na turma selecionada
  void _updateStudentList(String className) {
    final studentNames = studentsByClass[className] ?? [];
    setState(() {
      _students = studentNames
          .map((name) => Student(name: name, status: AttendanceStatus.notSelected))
          .toList();
    });
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

  String _getMonthAbbreviation(int month) {
    const months = ['JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN', 'JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ'];
    return months[month - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
    ];
    return months[month - 1];
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
          _buildDropdownFilter('Turma', 'Selecione a turma', studentsByClass.keys.toList(), _selectedClass, (newValue) {
            _selectedClass = newValue;
            _updateStudentList(newValue!);
          }),
          const SizedBox(height: 16),
          _buildDropdownFilter('Disciplina', 'Selecione a disciplina', ['Matemática', 'Física', 'Química'], _selectedSubject, (newValue) {
            setState(() => _selectedSubject = newValue!);
          }),
          const SizedBox(height: 16),
          _buildDatePicker('Dia', _selectedDate != null ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}' : null),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter(
      String label, String hint, List<String> items, String? value, ValueChanged<String?> onChanged) {
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
          value: value,
          hint: Text(hint, style: const TextStyle(color: Color(0xFF64748b))),
          icon: const Icon(Icons.keyboard_arrow_down, color: textSlate400),
          style: const TextStyle(color: textSlate300, fontSize: 16, fontFamily: 'Lexend'),
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
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label, String? value) {
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
          key: ValueKey(value), // Garante que o widget reconstrua com o novo valor
          initialValue: value,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Selecione o dia',
            hintStyle: const TextStyle(color: Color(0xFF64748b)),
            isDense: true,
            prefixIcon: Icon(Icons.calendar_month, color: textSlate400, size: 24),
            suffixIcon: Icon(Icons.keyboard_arrow_down, color: textSlate400),
          ),
          onTap: () async { // Lógica para abrir o seletor de data
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (picked != null && picked != _selectedDate) {
              setState(() => _selectedDate = picked);
            }
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
            controller: _topicController,
            decoration: const InputDecoration(
              hintText: 'Ex: Equações de 1º Grau',
              isDense: true,
            ),
            style: const TextStyle(color: textSlate300),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
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

  Widget _buildAttendanceHeader(BuildContext context) {
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
          ), // TODO: Adicionar navegação para as outras telas
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