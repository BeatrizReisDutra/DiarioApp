import 'package:flutter/material.dart';

// --- Dados de Exemplo ---
class Aula {
  final String titulo;
  final String horario;
  final Color corBorda;

  Aula(this.titulo, this.horario, this.corBorda);
}

class DiaAgenda {
  final String diaSemana;
  final int diaMes;
  final List<Aula> aulas;
  final bool isHoje;

  DiaAgenda(this.diaSemana, this.diaMes, this.aulas, {this.isHoje = false});
}

final List<DiaAgenda> agendaSemanal = [
  DiaAgenda('SEG', 14, [
    Aula('Matemática - 9º Ano A', '08:00 - 09:40', Colors.yellow.shade400),
    Aula('Física - 2º Ano B', '10:00 - 11:40', Colors.green.shade400),
  ], isHoje: true),
  DiaAgenda('TER', 15, [
    Aula('Lembrete: Reunião Pedagógica', '14:00', Colors.red.shade400),
  ]),
  DiaAgenda('QUA', 16, [
    Aula('Matemática - 9º Ano A', '08:00 - 09:40', Colors.yellow.shade400),
  ]),
  DiaAgenda('QUI', 17, [
    Aula('Matemática - 1º Ano C', '10:00 - 11:40', Colors.purple.shade400),
  ]),
  DiaAgenda('SEX', 18, [
    Aula('Física - 2º Ano B', '08:00 - 09:40', Colors.green.shade400),
  ]),
];

// --- Tema e Cores ---
const Color primaryColor = Color(0xFF4f80ff);
const Color backgroundDark = Color(0xFF121212);
const Color cardDark = Color(0xFF1e1e1e);
const Color textColor = Colors.white;

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: backgroundDark,
  colorScheme: const ColorScheme.dark(
    primary: primaryColor,
    background: backgroundDark,
    surface: cardDark,
    onBackground: textColor,
    onSurface: textColor,
  ),
  fontFamily: 'Lexend', // Assumindo que a fonte 'Lexend' está configurada no projeto
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundDark,
    foregroundColor: textColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
  ),
  textTheme: Typography.whiteMountainView.copyWith(
    bodyMedium: const TextStyle(color: textColor),
    titleMedium: const TextStyle(color: textColor),
  ),
  // ... outros ajustes de tema
);

class CalendarioApp extends StatelessWidget {
  const CalendarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendário de Aulas',
      theme: darkTheme,
      home: const CalendarioScreen(),
    );
  }
}

class CalendarioScreen extends StatelessWidget {
  const CalendarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildMonthSelector(context),
          Expanded(
            child: _buildAgendaList(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // --- Componentes da Tela ---

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Calendário de Aulas'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, size: 24),
          onPressed: () {},
        ),
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.zero,
            ),
            icon: const Icon(Icons.add, color: Colors.white, size: 24),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildMonthSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildMonthNavButton(Icons.chevron_left),
              const SizedBox(width: 8),
              const Text(
                'Outubro 2024',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // No original é gray-50, mas usei branco para contraste em dark mode puro
                ),
              ),
              const SizedBox(width: 8),
              _buildMonthNavButton(Icons.chevron_right),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: cardDark,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                _buildViewButton('Dia', false),
                _buildViewButton('Semana', true),
                _buildViewButton('Mês', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthNavButton(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: cardDark,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: Colors.grey.shade300),
    );
  }

  Widget _buildViewButton(String text, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? Colors.white : Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildAgendaList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: agendaSemanal.length,
      itemBuilder: (context, index) {
        final dia = agendaSemanal[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coluna do dia da semana e dia do mês
              SizedBox(
                width: 48, // w-12 flex-shrink-0
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      dia.diaSemana,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: dia.isHoje ? primaryColor : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${dia.diaMes}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dia.isHoje ? Colors.white : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Coluna de Aulas/Eventos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: dia.aulas.map((aula) => _buildAulaCard(aula)).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAulaCard(Aula aula) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: cardDark,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(
              color: aula.corBorda,
              width: 4.0, // border-l-4
            ),
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              aula.titulo,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              aula.horario,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundDark.withOpacity(0.9), // Simula o backdrop-blur
        border: Border(top: BorderSide(color: Colors.grey.shade800)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Início', false),
            _buildNavItem(Icons.group, 'Turmas', false),
            _buildNavItem(Icons.calendar_month, 'Calendário', true),
            _buildNavItem(Icons.assessment, 'Relatórios', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    final color = isSelected ? primaryColor : Colors.grey.shade400;
    return InkWell(
      onTap: () {
        // Ação de navegação
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
