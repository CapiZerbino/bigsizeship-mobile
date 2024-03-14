import 'package:bigsizeship_mobile/core/utils/pagination.dart';

String mapOperator(CrudOperators operator) {
  switch (operator) {
    case CrudOperators.startswith:
      return 'startsWith';
    case CrudOperators.endswith:
      return 'endsWith';
    case CrudOperators.nin:
      return 'notIn';
    case CrudOperators.ncontains:
      return 'notContains';
    case CrudOperators.ncontainss:
      return 'notContainsi';
    case CrudOperators.containss:
      return 'containsi';
    case CrudOperators.contains:
      return 'contains';
    case CrudOperators.nnull:
      return 'notNull';
    default:
      return operator.name;
  }
}
