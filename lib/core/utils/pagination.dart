// Pagination Class
import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  // Pagination mode (client, server, or off)
  Pagination({
    this.current = 1,
    this.pageSize = 10,
    this.mode = 'server',
  });
  int? current; // Initial page index
  int? pageSize; // Number of items per page
  String? mode;

  @override
  List<Object?> get props => [current, pageSize, mode];
}

// Enum for CRUD Operators
enum CrudOperators {
  eq,
  ne,
  lt,
  gt,
  lte,
  gte,
  in_, // 'in' is a keyword in Dart, so we use in_
  nin,
  contains,
  ncontains,
  containss,
  ncontainss,
  between,
  nbetween,
  null_, // 'null' is a keyword in Dart
  nnull,
  startswith,
  nstartswith,
  startswiths,
  nstartswiths,
  endswith,
  nendswith,
  endswiths,
  nendswiths,
  or_,
  and_,
}

extension CrudOperatorsExtension on CrudOperators {
  String get name {
    switch (this) {
      case CrudOperators.eq:
        return 'eq';
      case CrudOperators.ne:
        return 'ne';
      case CrudOperators.lt:
        return 'lt';
      case CrudOperators.gt:
        return 'gt';
      case CrudOperators.lte:
        return 'lte';
      case CrudOperators.gte:
        return 'gte';
      case CrudOperators.in_:
        return 'in';
      case CrudOperators.nin:
        return 'nin';
      case CrudOperators.contains:
        return 'contains';
      case CrudOperators.ncontains:
        return 'ncontains';
      case CrudOperators.containss:
        return 'containss';
      case CrudOperators.ncontainss:
        return 'ncontainss';
      case CrudOperators.between:
        return 'between';
      case CrudOperators.nbetween:
        return 'nbetween';
      case CrudOperators.null_:
        return 'null';
      case CrudOperators.nnull:
        return 'nnull';
      case CrudOperators.startswith:
        return 'startswith';
      case CrudOperators.nstartswith:
        return 'nstartswith';
      case CrudOperators.startswiths:
        return 'startswiths';
      case CrudOperators.nstartswiths:
        return 'nstartswiths';
      case CrudOperators.endswith:
        return 'endswith';
      case CrudOperators.nendswith:
        return 'nendswith';
      case CrudOperators.endswiths:
        return 'endswiths';
      case CrudOperators.nendswiths:
        return 'nendswiths';
      case CrudOperators.or_:
        return 'or';
      case CrudOperators.and_:
        return 'and';
    }
  }
}

// Enum for Sort Order
enum SortOrder {
  desc,
  asc,
  null_,
}

// Logical Filter Class
class LogicalFilter {
  LogicalFilter({
    required this.field,
    required this.operator,
    required this.value,
  });
  String field;
  CrudOperators operator;
  dynamic value;
}

// // Conditional Filter Class
// class ConditionalFilter extends Equatable {
//   // List of LogicalFilter or ConditionalFilter
//   ConditionalFilter({
//     required this.operator,
//     required this.value,
//     this.key,
//   });

//   String? key;
//   CrudOperators operator;
//   List<dynamic> value;

//   @override
//   List<Object?> get props => [operator, value];
// }

// Simplified type aliases
// Type CrudFilter is either LogicalFilter or ConditionalFilter
typedef CrudFilter = LogicalFilter;
typedef CrudSort = Map<String, SortOrder>; // {'field': 'asc' }
typedef CrudFilters = List<CrudFilter>;
typedef CrudSorting = List<CrudSort>;
