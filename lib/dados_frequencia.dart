// --- Modelos de Dados Unificados ---

// Registro de frequência para um dia específico
class AttendanceRecord {
  final String date; // Formato 'dd/MM'
  final String status; // 'P' para Presente, 'F' para Falta

  AttendanceRecord(this.date, this.status);
}

// Aluno com seu histórico de frequência
class StudentAttendance {
  final String name;
  final List<AttendanceRecord> records;

  StudentAttendance(this.name, this.records);
}

// --- "Banco de Dados" Mockado e Global ---

// Lista de todas as datas com aulas registradas.
final List<String> registeredDates = ['01/08', '03/08', '08/08', '10/08', '15/08', '17/08'];

// Lista global de alunos e seus registros de frequência.
final List<StudentAttendance> allStudentsAttendance = [
  StudentAttendance('Ana Júlia Oliveira', [
    AttendanceRecord('01/08', 'P'),
    AttendanceRecord('03/08', 'P'),
    AttendanceRecord('08/08', 'F'),
    AttendanceRecord('10/08', 'P'),
    AttendanceRecord('15/08', 'P'),
    AttendanceRecord('17/08', 'P')
  ]),
  StudentAttendance('Bruno Costa', [
    AttendanceRecord('01/08', 'P'),
    AttendanceRecord('03/08', 'P'),
    AttendanceRecord('08/08', 'P'),
    AttendanceRecord('10/08', 'P'),
    AttendanceRecord('15/08', 'F'),
    AttendanceRecord('17/08', 'P')
  ]),
  StudentAttendance('Carlos Eduardo Pereira', [
    AttendanceRecord('01/08', 'F'),
    AttendanceRecord('03/08', 'F'),
    AttendanceRecord('08/08', 'P'),
    AttendanceRecord('10/08', 'P'),
    AttendanceRecord('15/08', 'P'),
    AttendanceRecord('17/08', 'P')
  ]),
  StudentAttendance('Daniela Martins', [
    AttendanceRecord('01/08', 'P'),
    AttendanceRecord('03/08', 'P'),
    AttendanceRecord('08/08', 'P'),
    AttendanceRecord('10/08', 'P'),
    AttendanceRecord('15/08', 'P'),
    AttendanceRecord('17/08', 'P')
  ]),
];