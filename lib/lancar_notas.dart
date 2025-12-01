import 'package:flutter/material.dart';

// Cores  para o Dark Mode
const Color primaryColor = Color(0xFF135bec);
const Color backgroundDark = Color(0xFF0D1117);
const Color cardDark = Color(0xFF1e293b); // slate-900
const Color inputBgDark = Color(0xFF334155); // slate-800
const Color inputBorderDark = Color(0xFF475569); // slate-700
const Color textDarkPrimary = Colors.white; // text-white
const Color textDarkSecondary = Color(0xFF94a3b8); // slate-400
const Color scorePass = Color(0xFF22c55e); // green-500
const Color scoreWarning = Color(0xFFf59e0b); // yellow-500
const Color scoreFail = Color(0xFFef4444); // red-500

// Modelo de dados para o aluno
class Student {
  final String name;
  final String imageUrl;
  final List<double> scores; // B1, B2, B3, B4

  Student({required this.name, required this.imageUrl, required this.scores});

  double get finalAverage {
    if (scores.isEmpty) return 0.0;
    return scores.reduce((a, b) => a + b) / scores.length;
  }
}

class GradeEntryScreen extends StatefulWidget {
  const GradeEntryScreen({super.key});

  @override
  State<GradeEntryScreen> createState() => _GradeEntryScreenState();
}

class _GradeEntryScreenState extends State<GradeEntryScreen> {
  // Lista de alunos de exemplo (simulando dados mutáveis)
  final List<Student> students = [
    Student(
      name: 'Ana Silva',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAiV61IuWHDtLGX-V3E-yU3x_9u6JX3uzHwYMKnjXtxrIp3JTWzmC5hPYru9Buhdtm2NqJCRdgAOG7SNRwnMZqc92wg9G5-UDct-ykEpiyS5e6O_PZqRIYAUEOdIO0Ehu6uSaKOYTqJ6-n8-6ut1UG6LOQmIVqYBd9fSLeQa4aJeZoF_iU9aesDtdgJZ22OOzaBHD5uyXcidkRQVNHCKqpL0_SZS1jb9nMoJKMTrOTb6Y3YRzSZLSej-oKJU9zOO1fWT0oGJAkwDw4O',
      scores: [9.0, 8.0, 8.5, 8.5],
    ),
    Student(
      name: 'Bruno Costa',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBAYn9g6Ka0padii0enElP_ZzXIKuFHfQOqmT0xlFJcGmDg-Jwr1s43k_a-LhwQ2x4G4_As83r3R3Lwbhz1B6ezGVeh3d4YTBc8Nc7cOO9tsN7GAINEiMEZOFUyt4b0rowP8JlG5tnCYFMYfk2HjHqov-n59UAbpmGH1misVKPZmYg_dCzfELsISwYR9s7ljQWBfB8NlA0f9x2IKA0JgN0Ga50KQ38FVu6SB1pUu6nzoCT5u07vB6AT_ic347n-mM2RBiGnFRr3-_sy',
      scores: [6.5, 7.5, 7.0, 7.0],
    ),
    Student(
      name: 'Carla Dias',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCWjzzc2XG6IKROEoTq0ebvPautDbYm4LdTOnPG6s7PqtbYiw-Tq4tgfRRAl15sXMU89ABjxfwV_7XQCGm-cVp9rEW90oZwwuH2LZsBXiVh2Q-xRcHdHrL2w5hlrBERLfPf6QXXq5arw64H3ry-xvlZ1RdxUPLDqv0E58vCmatRFeA9US5Zqil6uk0lJQfi55oRPSRn9XCcTlc-BoLlQpwwmha8xEpY9RAHzcWbunbJZmNMbRtAjk1GkzBsrZifAXRm22blBLYpAB9j',
      scores: [9.5, 9.0, 10.0, 9.5],
    ),
    Student(
      name: 'Daniel Martins',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCGOSYCWcBbs7aClDh0TJjZkEqZXZIXFumsctmkuaxD65J_kPoJ56TYi7EGEmIUDAVDJ1j_QfFaf_XNu-wadSrU96Qf7Ci03zmpRckVcwodb-mnKhEhbVYtM3xEDeSgOdRAXnfCXRH7BLwWCukCK31phkgjgXnbutJMIYqTsiefdbPMzDyvw38mnVt8W_vHFmax60rtaRLHFV2MXl1rZD9W9nmCoZdPgjg99rhvRFjz0a-Qnjg5ymdXCfB9LNYKYxwdEZdIbff-tXkr',
      scores: [5.0, 6.0, 5.5, 5.5],
    ),
  ];

  // Função para determinar a cor da média final
  Color _getAverageColor(double average) {
    if (average >= 9.0) return scorePass;
    if (average >= 7.0) return scoreWarning;
    if (average >= 6.0) return primaryColor; // Destaque azul para notas medianas
    return scoreFail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        // Padding para a Bottom NavBar
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100), 
        child: Column(
          children: students.map((student) => _buildStudentGradeCard(student)).toList(),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- Widgets de Estrutura ---

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundDark.withValues(alpha: 0.9), // Fundo semi-transparente
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 64,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: textDarkSecondary),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Notas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textDarkPrimary,
                      ),
                    ),
                    Text(
                      '3º Ano B - Matemática',
                      style: TextStyle(
                        fontSize: 14,
                        color: textDarkSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Botão Salvar
            ElevatedButton(
              onPressed: () {
                // Ação: Salvar notas
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 0,
              ),
              child: const Text(
                'Salvar',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.shade800, // border-slate-800
          height: 1.0,
        ),
      ),
    );
  }

  // --- Student Card ---

  Widget _buildStudentGradeCard(Student student) {
    final averageColor = _getAverageColor(student.finalAverage);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardDark, // bg-slate-900
          borderRadius: BorderRadius.circular(12),
          boxShadow: null, // Sem sombra no dark mode
        ),
        child: Column(
          children: [
            // Cabeçalho do Aluno (Foto e Média)
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    student.imageUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: textDarkPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Média Final: ',
                            style: TextStyle(
                              fontSize: 14,
                              color: textDarkSecondary,
                            ),
                          ),
                          Text(
                            student.finalAverage.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: averageColor, // Cor dinâmica
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Campos de Nota (Grid)
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4, // B1, B2, B3, B4
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 0, 
              ),
              itemBuilder: (context, index) {
                return _buildScoreInput(
                  bimestre: index + 1,
                  score: student.scores[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreInput({required int bimestre, required double score}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            'B$bimestre',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textDarkSecondary, // text-slate-400
            ),
          ),
        ),
        TextFormField(
          initialValue: score.toStringAsFixed(1),
          textAlign: TextAlign.center,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(color: textDarkPrimary),
          decoration: InputDecoration(
            hintText: '0.0',
            hintStyle: TextStyle(color: Colors.grey.shade600),
            filled: true,
            fillColor: inputBgDark, // bg-slate-800
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: inputBorderDark), // border-slate-700
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: inputBorderDark),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: primaryColor, width: 2), // focus:border-primary
            ),
          ),
          onChanged: (value) {
            // Lógica para atualizar a nota e recalcular a média (necessita de setState)
          },
        ),
      ],
    );
  }

  // --- Bottom Navigation ---

  Widget _buildBottomNavBar() {
    return Container(
      height: 64, // h-16
      decoration: BoxDecoration(
        color: cardDark, // bg-slate-900
        border: Border(top: BorderSide(color: Colors.grey.shade800)), // border-slate-800
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.checklist, label: 'Frequência', isSelected: false),
          _buildNavItem(icon: Icons.book_outlined, label: 'Conteúdo', isSelected: false),
          // Item de Notas (Selecionado)
          _buildNavItem(icon: Icons.grade, label: 'Notas', isSelected: true, isFilled: true),
          _buildNavItem(icon: Icons.analytics_outlined, label: 'Relatórios', isSelected: false),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required bool isSelected, bool isFilled = false}) {
    // Para simular o 'FILL 1' no ícone Notas selecionado
    IconData displayIcon = isFilled && isSelected ? Icons.grade_sharp : icon;
    
    return InkWell(
      onTap: () {
        // Lógica de navegação
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            displayIcon,
            color: isSelected ? primaryColor : textDarkSecondary, // primary ou slate-400
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? primaryColor : textDarkSecondary,
            ),
          ),
        ],
      ),
    );
  }
}