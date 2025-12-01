import 'package:flutter/material.dart';

import 'main.dart'; // Importa as cores e temas globais

// As cores (primaryColor, backgroundDark, etc.) são definidas em main.dart

// Cores para as Barras Laterais dos Eventos
const Color borderYellow = Color(0xFFFBBC05); // Amarelo
const Color borderGreen = Color(0xFF34A853);  // Verde
const Color borderRed = Color(0xFFEA4335);    // Vermelho
const Color borderPurple = Color(0xFF9333ea);  // Roxo

// Estrutura de Dados para os Eventos
class CalendarEvent {
  final String dayName;
  final String dayNumber;
  final List<EventDetail> details;

  CalendarEvent(this.dayName, this.dayNumber, this.details);
}

class EventDetail {
  final String title;
  final String time;
  final Color borderColor;

  EventDetail(this.title, this.time, this.borderColor);
}

// Dados de Exemplo (Simulando a semana de 14 a 18 de Outubro)
final List<CalendarEvent> mockEvents = [
  CalendarEvent('SEG', '14', [
    EventDetail('Matemática - 9º Ano A', '08:00 - 09:40', borderYellow),
    EventDetail('Física - 2º Ano B', '10:00 - 11:40', borderGreen),
  ]),
  CalendarEvent('TER', '15', [
    EventDetail('Lembrete: Reunião Pedagógica', '14:00', borderRed),
  ]),
  CalendarEvent('QUA', '16', [
    EventDetail('Matemática - 9º Ano A', '08:00 - 09:40', borderYellow),
  ]),
  CalendarEvent('QUI', '17', [
    EventDetail('Matemática - 1º Ano C', '10:00 - 11:40', borderPurple),
  ]),
  CalendarEvent('SEX', '18', [
    EventDetail('Física - 2º Ano B', '08:00 - 09:40', borderGreen),
  ]),
];

enum CalendarView { day, week, month }

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Estado para controlar a visualização (Dia, Semana, Mês)
  CalendarView _currentView = CalendarView.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Controle de Navegação do Calendário (Mês, Dia/Semana/Mês)
          _buildCalendarControls(),
          // Lista de Eventos (a parte rolável)
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // --- 1. AppBar ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundDark,
      automaticallyImplyLeading: false, // Remove a seta de voltar padrão
      elevation: 0,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: textDarkSecondary),
            onPressed: () => Navigator.pop(context),
          ),
          const Text('Calendário de Aulas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDarkPrimary)),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: textDarkPrimary),
          onPressed: () {
            print('Pesquisar pressionado');
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                print('Adicionar Evento pressionado');
              },
            ),
          ),
        ),
      ],
    );
  }

  // --- 2. Controles do Calendário (Mês e View) ---

  Widget _buildCalendarControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Botões de Mês e Título
              Row(
                children: [
                  _buildChevronButton(Icons.chevron_left, () => print('Mês anterior')),
                  const SizedBox(width: 8),
                  const Text(
                    'Outubro 2024',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textDarkPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildChevronButton(Icons.chevron_right, () => print('Próximo mês')),
                ],
              ),
              // Toggle Dia/Semana/Mês
              Container(
                decoration: BoxDecoration(
                  color: cardDark,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    _buildToggleItem('Dia', _currentView == CalendarView.day, () {
                      setState(() => _currentView = CalendarView.day);
                    }),
                    _buildToggleItem('Semana', _currentView == CalendarView.week, () {
                      setState(() => _currentView = CalendarView.week);
                    }),
                    _buildToggleItem('Mês', _currentView == CalendarView.month, () {
                      setState(() => _currentView = CalendarView.month);
                    }),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Colors.transparent, height: 16),
        ],
      ),
    );
  }

  Widget _buildChevronButton(IconData icon, VoidCallback onTap) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: cardDark,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: IconButton(
        icon: Icon(icon, color: textDarkSecondary, size: 20),
        padding: EdgeInsets.zero,
        onPressed: onTap,
      ),
    );
  }

  Widget _buildToggleItem(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : textDarkSecondary,
          ),
        ),
      ),
    );
  }

  // --- 3. Lista de Eventos ---

  Widget _buildEventList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: mockEvents.length,
      itemBuilder: (context, index) {
        final eventGroup = mockEvents[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coluna do Dia
              Container(
                width: 48,
                margin: const EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    Text(
                      eventGroup.dayName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textDarkSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: eventGroup.dayNumber == '14' ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        eventGroup.dayNumber,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: eventGroup.dayNumber == '14' ? Colors.white : textDarkSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Lista de Aulas/Eventos do Dia
              Expanded(
                child: Column(
                  children: eventGroup.details.map((detail) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildEventCard(detail),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEventCard(EventDetail detail) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardDark,
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(
            color: detail.borderColor,
            width: 4.0, // Largura da barra lateral
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: textDarkPrimary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            detail.time,
            style: const TextStyle(
              color: textDarkSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // --- 4. BottomNavigationBar ---

  Widget _buildBottomNavigationBar(BuildContext context) {
    const int currentIndex = 2; // Calendário é o terceiro item (índice 2)

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade800)),
        color: backgroundDark.withOpacity(0.9),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/turmas');
              break;
            case 2:
              // Já está na tela Calendário
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/relatorio_notas'); // Ou a tela de relatórios principal
              break;
          }
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: textDarkSecondary,
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: 'Turmas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'Relatórios',
          ),
        ],
      ),
    );
  }
}
