import 'package:flutter/material.dart';

// Cores baseadas no seu HTML/Tailwind para o Dark Mode
const Color primaryColor = Color(0xFF137fec);
const Color backgroundDark = Color(0xFF101922);
const Color cardBg = Color(0xFF1e293b); // slate-800
final Color inputBg = Color(0xFF0f172a).withValues(alpha: 0.5); // slate-900/50
const Color inputBorder = Color(0xFF475569); // slate-700
const Color textDarkPrimary = Color(0xFFf8fafc); // slate-50
const Color textDarkSecondary = Color(0xFF94a3b8); // slate-400
const Color greenPresent = Color(0xFF6ee7b7); // green-300
const Color redAbsent = Color(0xFFf87171); // red-300
const Color inactiveButtonBg = Color(0xFF475569); // slate-700
const Color inactiveButtonText = Color(0xFFcfdbe7); // slate-300

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Lista de alunos mantida no estado para permitir alterações interativas
  late List<Map<String, dynamic>> students;

  @override
  void initState() {
    super.initState();
    students = [
      {'name': 'Ana Júlia Oliveira', 'status': '', 'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCFr_p73lOPQ386V5tvSSEc_vp-YNRWy-gt8WwLZXA82o45dvMVy-z4xGonR8q6SX_QpRZnZ6BDSt9NP9SCeQptLcafMBjzHvR9OzO1KUWYDpgagxj_NKBTkTC43mFSodrn-PTY_dGpaMQOVw_dRQqhc5shI39X2DgLS0fLe3EMd117YimonXoD3mtUeqK9o_rt-Z5-0MQFuVG7bJ2r2UwD71htlPOqrL4cMgzicpDD_0_jludPtYXitPqh9PXyynM5mNwtJ_wbubYP'},
      {'name': 'Bruno Costa', 'status': '', 'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCsZCLWVUs_gTJbxQFfiYNnqhRl5BHrJqqc70VY3mdhmbzWwhax5mhL-2SChW-L0ZMCKDR4uLnrlv9u6BXBF0w-MQeAL7AUBf7XUYYjvii8C2b8tRN85aXo42J-uFb84bsvmPwL8RQVpOkM63JV9xa73hH9I_aUQmV7Tol9aWgF_MkCp3v3iWPxj7fLimBtxecOVLd32D13pCxw5CzcQb_wIMI1V_6uuoI9-U_tmdgMCsh87nYW63IpcroEdpVaO_5ja7bSpdkRYRjk'},
      {'name': 'Carlos Eduardo Pereira', 'status': '', 'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAcndqFVlgckvrLiP7yWSLlGtQYdUtLTNBjJsIQEsE8_foNGmS66BHpoYuf5z--wzI70C4u5AUa-oB2pcGJjdNUCkelQ_jbkujNsvB_8XBDk6B9qbq-Af4TPU98b8aRrz8UVZw-_-w1AYYuWpg3t7zJ2YuQ39vq1JbPCucD8qIesO9yRuugIFzqaFxM95HzOsFOrJqpnvDq6vjHweK_5RPz2LvKOShXe0JV2LKYXWJ3ZHg19Jmc4XeeC2J8HXNxKBDjhr1OT12M8Bh8'},
      {'name': 'Daniela Martins', 'status': '', 'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB84u7LDLl9VC0Ur5Y6FLfnq9wm9zCOKkogxM56D1JbSIZveibD3LM3nFW9aON9kUu2X2g_lrEtL3OHBgQturIH8xmrrTsNnPGhZHtgFgSO4kTMcDeZqdj_ki-inJx6shpam0Iv-aLrCT0YSGliXfjYNDEFNRWVToGp_RxbqsKdOSzPnrAz6FkeVwKF0gfSx-esac6XfFr2JPMk5pUzDe2StPXCthD-glLpnLBd6i60WkV_K54ky-gKurgFl9xBvZL7Z1d-b76AkkTs'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Cores dinâmicas para o contexto atual
    final Color textColor = textDarkPrimary;
    final Color secondaryTextColor = textDarkSecondary;
    
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: _buildAppBar(context, textColor, secondaryTextColor),
      body: SingleChildScrollView(
        // Padding para acomodar o Floating Button e a Bottom NavBar
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Seção 1: Conteúdo da Aula
            _buildContentSection(textColor, secondaryTextColor),
            const SizedBox(height: 24),
            // Seção 2: Frequência
            _buildFrequencySection(textColor, secondaryTextColor),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingSaveButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- Widgets de Estrutura ---

  PreferredSizeWidget _buildAppBar(BuildContext context, Color textColor, Color secondaryTextColor) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundDark.withValues(alpha: 0.95),
      elevation: 0,
      toolbarHeight: 64,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade800)), 
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: secondaryTextColor, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Introdução à Álgebra',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      '25 de Julho - 1º Bimestre',
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: secondaryTextColor, size: 28),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Seção 1: Conteúdo da Aula ---

  Widget _buildContentSection(Color textColor, Color secondaryTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            'Conteúdo da Aula',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBg, 
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input Tópico da Aula
              _buildInputField(
                label: 'Tópico da Aula',
                placeholder: 'Ex: Equações de 1º Grau',
                initialValue: 'Conceitos básicos de álgebra',
                secondaryTextColor: secondaryTextColor,
              ),
              const SizedBox(height: 16),
              // Textarea Conteúdo Detalhado
              _buildTextareaField(
                placeholder: 'Descreva o conteúdo da aula...',
                initialValue: 'Nesta aula, introduzimos os conceitos básicos de álgebra, incluindo variáveis, expressões e a importância de resolver para o desconhecido. Os alunos participaram de atividades práticas para solidificar o entendimento.',
                secondaryTextColor: secondaryTextColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label, 
    required String placeholder, 
    required String initialValue,
    required Color secondaryTextColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: secondaryTextColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          style: const TextStyle(color: inactiveButtonText), // slate-300
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            filled: true,
            fillColor: inputBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            contentPadding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxHeight: 50), // Ajuste para altura h-12/14
          ),
        ),
      ],
    );
  }

  Widget _buildTextareaField({
    required String placeholder, 
    required String initialValue,
    required Color secondaryTextColor,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: 6,
      style: const TextStyle(color: inactiveButtonText), // slate-300
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        filled: true,
        fillColor: inputBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }


  // --- Seção 2: Frequência ---

  Widget _buildFrequencySection(Color textColor, Color secondaryTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFrequencyHeader(textColor, secondaryTextColor),
        const SizedBox(height: 12),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: students.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildStudentTile(index, textColor),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFrequencyHeader(Color textColor, Color secondaryTextColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Frequência',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        Row(
          children: [
            Text(
              'Marcar todos como:',
              style: TextStyle(
                fontSize: 14,
                color: secondaryTextColor,
              ),
            ),
            const SizedBox(width: 8),
            // Botão "Marcar todos como Presente" (P)
            InkWell(
              onTap: () {
                setState(() {
                  for (var i = 0; i < students.length; i++) {
                    students[i]['status'] = 'P';
                  }
                });
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.green.shade900.withValues(alpha: 0.5), // bg-green-900/50
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'P',
                    style: TextStyle(
                      color: greenPresent, // text-green-300
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStudentTile(int index, Color textColor) {
    final student = students[index];
    String currentStatus = student['status'];

    // Função helper para estilizar os botões P e F
    Widget statusButton(String status, Color activeTextColor, Color activeBgColor) {
      bool isActive = status == currentStatus;

      Color bg = isActive ? activeBgColor : inactiveButtonBg;
      Color text = isActive ? activeTextColor : inactiveButtonText;

      return InkWell(
        onTap: () {
          setState(() {
            students[index]['status'] = status;
          });
        },
        child: Container(
          width: 44, // w-11
          height: 36, // h-9
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: text,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardBg, // slate-800
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              student['imageUrl'],
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              student['name'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          Row(
            children: [
              // Botão P
              statusButton('P', greenPresent, Colors.green.shade900.withValues(alpha: 0.5)),
              const SizedBox(width: 8),
              // Botão F
              statusButton('F', redAbsent, Colors.red.shade900.withValues(alpha: 0.5)),
            ],
          ),
        ],
      ),
    );
  }

  // --- Botão Flutuante ---

  Widget _buildFloatingSaveButton() {
    return FloatingActionButton(
      onPressed: () {
        // Ação: Salvar Conteúdo e Frequência
      },
      backgroundColor: primaryColor,
      shape: const CircleBorder(),
      elevation: 6,
      child: const Icon(Icons.save, color: Colors.white, size: 30),
    );
  }

  // --- Barra de Navegação Inferior (Nova Estrutura) ---

  Widget _buildBottomNavBar() {
    return Container(
      height: 80, // h-20
      decoration: BoxDecoration(
          color: backgroundDark.withValues(alpha: 0.95), // bg-background-dark/95 backdrop-blur-sm
        border: Border(top: BorderSide(color: Colors.grey.shade800)), 
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.home, label: 'Início', route: '/home', isSelected: false),
          _buildNavItem(icon: Icons.article, label: 'Relatório Conteúdos', route: '/relatorio_conteudos', isSelected: false),
          _buildNavItem(icon: Icons.checklist, label: 'Relatório Frequência', route: '/relatorio_frequencia', isSelected: false),
          _buildNavItem(icon: Icons.assessment, label: 'Notas', route: '/relatorio_notas', isSelected: false),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required String route, required bool isSelected}) {
    Color itemColor = isSelected ? primaryColor : textDarkSecondary; 
    
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: itemColor,
            size: 24,
          ),
          SizedBox(
            width: 70, // Largura para centralizar o texto de duas linhas
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                color: itemColor,
                height: 1.1, // line-height: tight
              ),
            ),
          ),
        ],
      ),
    );
  }
}