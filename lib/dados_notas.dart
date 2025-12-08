import 'package:flutter/material.dart';

// --- Modelo de Dados Unificado ---
class StudentGrade {
  final String name;
  double finalAverage;
  List<double> bimesterGrades;
  final String imageUrl;
  final String className;
  final String subjectName;

  StudentGrade({
    required this.name,
    required this.finalAverage,
    required this.bimesterGrades,
    required this.imageUrl,
    required this.className,
    required this.subjectName,
  });

  // Calcula a média final com base nas notas bimestrais
  void calculateFinalAverage() {
    if (bimesterGrades.isEmpty) {
      finalAverage = 0.0;
      return;
    }
    finalAverage = bimesterGrades.reduce((a, b) => a + b) / bimesterGrades.length;
  }

  Color get averageColor {
    if (finalAverage >= 7.0) return Colors.green.shade400;
    if (finalAverage >= 5.0) return Colors.yellow.shade600;
    return Colors.red.shade500;
  }
}

// --- "Banco de Dados" Mockado e Global ---
final List<StudentGrade> allStudentGrades = [
  StudentGrade(
    name: 'Ana Júlia Oliveira',
    finalAverage: 8.5,
    bimesterGrades: [9.0, 8.0, 8.5, 8.5],
    imageUrl: 'https://i.pravatar.cc/150?img=1',
    className: '9º Ano A',
    subjectName: 'Matemática',
  ),
  StudentGrade(
    name: 'Bruno Costa',
    finalAverage: 7.0,
    bimesterGrades: [6.5, 7.5, 7.0, 7.0],
    imageUrl: 'https://i.pravatar.cc/150?img=2',
    className: '9º Ano A',
    subjectName: 'Matemática',
  ),
  StudentGrade(
    name: 'Carlos Eduardo Pereira',
    finalAverage: 9.5,
    bimesterGrades: [9.5, 9.0, 10.0, 9.5],
    imageUrl: 'https://i.pravatar.cc/150?img=3',
    className: '9º Ano A',
    subjectName: 'Matemática',
  ),
  StudentGrade(
    name: 'Daniela Martins',
    finalAverage: 4.5,
    bimesterGrades: [5.0, 4.0, 5.5, 3.5],
    imageUrl: 'https://i.pravatar.cc/150?img=4',
    className: '9º Ano A',
    subjectName: 'Matemática',
  ),
];