import 'package:equatable/equatable.dart';

class SortTemplate extends Equatable {
  final String label;
  final String filter;

  const SortTemplate(this.label, this.filter);

  @override
  List<Object?> get props => [label, filter];

  static List<SortTemplate> prices = [
    SortTemplate('≤ 100 jt', '<100'),
    SortTemplate('100 jt - 300 jt', '100-300'),
    SortTemplate('300 jt - 500 jt', '300-500'),
    SortTemplate('≥ 500 jt', '>500'),
  ];

  static List<SortTemplate> kilometers = [
    SortTemplate('≤ 1000 km', '<1000'),
    SortTemplate('1000 km - 10000 km', '1000-10000'),
    SortTemplate('≥ 10000 km jt - 500 jt', '>10000'),
  ];

  static List<SortTemplate> byYears = [
    SortTemplate('≤ 3 tahun', '<3'),
    SortTemplate('≤ 5 tahun', '<5'),
    SortTemplate('≤ 10 tahun', '<10'),
    SortTemplate('≤ 15 tahun', '<15'),
    SortTemplate('≤ 20 tahun', '<20'),
    SortTemplate('≤ 25 tahun', '<25'),
    SortTemplate('≤ 30 tahun', '<30'),
  ];
}
