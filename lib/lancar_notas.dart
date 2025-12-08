import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Constantes de Design ---
const Color primaryColor = Color(0xFF135BEC);
const Color backgroundDark = Color(0xFF0D1117);
const Color slate800 = Color(0xFF1E293B); // Para bordas e fundo de inputs
const Color slate900 = Color(0xFF0F172A); // Fundo dos cards
const Color slate400 = Color(0xFF94A3B8); // Textos secundários
const Color textColor = Colors.white;

// --- Modelo de Dados (Simulação) ---
class StudentGrade {
  final String name;
  final double finalAverage;
  final List<double> bimesterGrades;
  final String imageUrl;

  StudentGrade({
    required this.name,
    required this.finalAverage,
    required this.bimesterGrades,
    required this.imageUrl,
  });

  Color get averageColor {
    if (finalAverage >= 9.0) return Colors.green.shade500;
    if (finalAverage >= 7.0) return Colors.yellow.shade500;
    return Colors.red.shade500;
  }
}

final List<StudentGrade> mockGrades = [
  StudentGrade(
    name: 'Ana Silva',
    finalAverage: 8.5,
    bimesterGrades: [9.0, 8.0, 8.5, 8.5],
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAiV61IuWHDtLGX-V3E-yU3x_9u6JX3uzHwYMKnjXtxrIp3JTWzmC5hPYru9Buhdtm2NqJCRdgAOG7SNRwnMZqc92wg9G5-UDct-ykEpiyS5e6O_PZqRIYAUEOdIO0Ehu6uSaKOYTqJ6-n8-6ut1UG6LOQmIVqYBd9fSLeQa4aJeZoF_iU9aesDtdgJZ22OOzaBHD5uyXcidkRQVNHCKqpL0_SZS1jb9nMoJKMTrOTb6Y3YRzSZLSej-oKJU9zOO1fWT0oGJAkwDw4O',
  ),
  StudentGrade(
    name: 'Bruno Costa',
    finalAverage: 7.0,
    bimesterGrades: [6.5, 7.5, 7.0, 7.0],
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBAYn9g6Ka0padii0enElP_ZzXIKuFHfQOqmT0xlFJcGmDg-Jwr1s43k_a-LhwQ2x4G4_As83r3R3Lwbhz1B6ezGVeh3d4YTBc8Nc7cOO9tsN7GAINEiMEZOFUyt4b0rowP8JlG5tnCYFMYfk2HjHqov-n59UAbpmGH1misVKPZmYg_dCzfELsISwYR9s7ljQWBfB8NlA0f9x2IKA0JgN0Ga50KQ38FVu6SB1pUu6nzoCT5u07vB6AT_ic347n-mM2RBiGnFRr3-_sy',
  ),
  StudentGrade(
    name: 'Carla Dias',
    finalAverage: 9.5,
    bimesterGrades: [9.5, 9.0, 10.0, 9.5],
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCWjzzc2XG6IKROEoTq0ebvPautDbYm4LdTOnPG6s7PqtbYiw-Tq4tgfRRAl15sXMU89ABjxfwV_7XQCGm-cVp9rEW90oZwwuH2LZsBXiVh2Q-xRcHdHrL2w5hlrBERLfPf6QXXq5arw64H3ry-xvlZ1RdxUPLDqv0E58vCmatRFeA9US5Zqil6uk0lJQfi55oRPSRn9XCcTlc-BoLlQpwwmha8xEpY9RAHzcWbunbJZmNMbRtAjk1GkzBsrZifAXRm22blBLYpAB9j',
  ),
  StudentGrade(
    name: 'Daniel Martins',
    finalAverage: 5.5,
    bimesterGrades: [5.0, 6.0, 5.5, 5.5],
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCGOSYCWcBbs7aClDh0TJjZkEqZXZIXFumsctmkuaxD65J_kPoJ56TYi7EGEmIUDAVDJ1j_QfFaf_XNu-wadSrU96Qf7Ci03zmpRckVcwodb-mnKhEhbVYtM3xEDeSgOdRAXnfCXRH7BLwWCukCK31phkgjgXnbutJMIYqTsiefdbPMzDyvw38mnVt8W_vHFmax60rtaRLHFV2MXl1rZD9W9nmCoZdPgjg99rhvRFjz0a-Qnjg5ymdXCfB9LNYKYxwdEZdIbff-tXkr',
  ),
];

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

class GradeEntryScreen extends StatelessWidget {
  const GradeEntryScreen({super.key});

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
              onPressed: () {},
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: GradeHeaderSelectors(),
          ),
          // Lista de Alunos e Notas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: mockGrades.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: StudentGradeCard(student: mockGrades[index]),
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
  const GradeHeaderSelectors({super.key});

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
                onChanged: (value) {},
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
                onChanged: (value) {},
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
  const StudentGradeCard({super.key, required this.student});

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
                initialValue: student.bimesterGrades[index].toStringAsFixed(1),
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
  final String initialValue;
  const GradeInputField({
    super.key,
    required this.bimester,
    required this.initialValue,
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
          initialValue: initialValue,
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