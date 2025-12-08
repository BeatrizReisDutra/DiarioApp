import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diarioapp/dados_notas.dart'; // Importar dados de notas

// --- Constantes de Design ---
const Color primaryColor = Color(0xFF135BEC);
const Color backgroundDark = Color(0xFF0D1117);
const Color slate800 = Color(0xFF1E293B); // Para bordas e fundo de inputs
const Color slate900 = Color(0xFF0F172A); // Fundo dos cards
const Color slate400 = Color(0xFF94A3B8); // Textos secundários
const Color textColor = Colors.white;

class GradeEntryApp extends StatelessWidget {
  const GradeEntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lançar Notas',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundDark,
        textTheme: GoogleFonts.lexendTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: textColor,
          displayColor: textColor,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: slate800),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: slate800),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: primaryColor),
          ),
          fillColor: slate800,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          isDense: true,
        ),
      ),
      home: const GradeEntryScreen(),
    );
  }
}

class GradeEntryScreen extends StatefulWidget {
  const GradeEntryScreen({super.key});

  @override
  State<GradeEntryScreen> createState() => _GradeEntryScreenState();
}

class _GradeEntryScreenState extends State<GradeEntryScreen> {
  // Mapa para guardar os controladores de cada aluno
  late Map<String, List<TextEditingController>> _gradeControllers;
  String _selectedClass = '9º Ano A';
  String _selectedSubject = 'Matemática';

  @override
  void initState() {
    super.initState();
    _gradeControllers = {};
    // Inicializa os controladores com os valores do "banco de dados"
    for (var student in allStudentGrades) {
      _gradeControllers[student.name] = student.bimesterGrades
          .map((grade) => TextEditingController(text: grade.toStringAsFixed(1)))
          .toList();
    }
  }

  @override
  void dispose() {
    // Limpa todos os controladores para evitar vazamento de memória
    _gradeControllers.forEach((_, controllers) {
      for (var controller in controllers) {
        controller.dispose();
      }
    });
    super.dispose();
  }

  void _saveGrades() {
    setState(() {
      // Itera sobre os alunos e atualiza suas notas no "banco de dados"
      for (var student in allStudentGrades) {
        final controllers = _gradeControllers[student.name];
        if (controllers != null) {
          // Atualiza a lista de notas do aluno
          student.bimesterGrades = controllers.map((controller) {
            // Converte o texto para double, usando 0.0 se for inválido
            return double.tryParse(controller.text.replaceAll(',', '.')) ?? 0.0;
          }).toList();

          // Recalcula a média final
          student.calculateFinalAverage();
        }
      }
    });

    // Exibe uma mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Notas salvas com sucesso!'),
      ),
    );

    // Opcional: Navegar para o relatório após salvar
    // Navigator.pushNamed(context, '/relatorio_notas');
  }

  // TODO: Implementar a lógica de filtro quando houver mais turmas/disciplinas
  List<StudentGrade> get _filteredStudents {
    return allStudentGrades.where((s) => s.className == _selectedClass && s.subjectName == _selectedSubject).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundDark.withAlpha(230), // Simula o backdrop-blur
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Lançar Notas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: slate400),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: _saveGrades,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: textColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: const Size(0, 36), // Ajuste para parecer menor
              ),
              child: const Text(
                'Salvar',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        // Simula a borda inferior
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: slate800,
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          // Seção de Turma e Disciplina
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GradeHeaderSelectors(
              onClassChanged: (value) => setState(() => _selectedClass = value!),
              onSubjectChanged: (value) => setState(() => _selectedSubject = value!),
            ),
          ),
          // Lista de Alunos e Notas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: allStudentGrades.length, // Usar a lista global
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: StudentGradeCard(
                    student: allStudentGrades[index],
                    controllers: _gradeControllers[allStudentGrades[index].name]!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

// --- Componente: Seletores de Turma e Disciplina ---

class GradeHeaderSelectors extends StatelessWidget {
  final ValueChanged<String?> onClassChanged;
  final ValueChanged<String?> onSubjectChanged;
  const GradeHeaderSelectors({
    super.key,
    required this.onClassChanged,
    required this.onSubjectChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Turma',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: slate400,
                ),
              ),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                dropdownColor: slate800,
                initialValue: '3º Ano B',
                items: ['3º Ano B', '2º Ano A', '1º Ano C']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: onClassChanged,
                style: const TextStyle(color: textColor),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Disciplina',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: slate400,
                ),
              ),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                dropdownColor: slate800,
                initialValue: 'Matemática',
                items: ['Matemática', 'Português', 'História']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: onSubjectChanged,
                style: const TextStyle(color: textColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- Componente: Card de Nota do Aluno ---

class StudentGradeCard extends StatelessWidget {
  final StudentGrade student;
  final List<TextEditingController> controllers;
  const StudentGradeCard({
    super.key,
    required this.student,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: slate900,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info do Aluno
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  student.imageUrl,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 48, color: slate400),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Média Final: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: slate400,
                        ),
                      ),
                      Text(
                        student.finalAverage.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: student.averageColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Campos de Notas Bimestrais
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 1.0, // Ajuste a proporção se necessário
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return GradeInputField(
                bimester: 'B${index + 1}',
                controller: controllers[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

// --- Componente: Campo de Input de Nota Bimestral ---

class GradeInputField extends StatelessWidget {
  final String bimester;
  final TextEditingController controller;
  const GradeInputField({
    super.key,
    required this.bimester,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bimester,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: slate400,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.center,
          style: const TextStyle(color: textColor, fontSize: 16),
          decoration: const InputDecoration(
            hintText: '0.0',
            hintStyle: TextStyle(color: slate400),
            contentPadding: EdgeInsets.all(8.0),
          ),
        ),
      ],
    );
  }
}

// --- Componente: Barra de Navegação Inferior ---

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: slate900,
        border: Border(
          top: BorderSide(color: slate800, width: 1.0),
        ),
      ),
      height: 64.0,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            icon: Icons.checklist,
            label: 'Frequência',
            isActive: false,
          ),
          NavBarItem(
            icon: Icons.book,
            label: 'Conteúdo',
            isActive: false,
          ),
          NavBarItem(
            icon: Icons.grade,
            label: 'Notas',
            isActive: true, // Item ativo
          ),
          NavBarItem(
            icon: Icons.analytics,
            label: 'Relatórios',
            isActive: false,
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? primaryColor : slate400;
    final fontWeight = isActive ? FontWeight.bold : FontWeight.w500;
    final fill = isActive ? 1.0 : 0.0;

    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
              // Ajusta a variação 'FILL' para simular o estilo Material Symbols Outlined
              shadows: fill == 1.0 ? [Shadow(color: color, blurRadius: 0)] : null,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}