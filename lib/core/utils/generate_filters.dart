// generateNestedFilterField function
import 'dart:convert';

import 'package:bigsizeship_mobile/core/utils/map_operator.dart';
import 'package:bigsizeship_mobile/core/utils/pagination.dart';

String generateNestedFilterField(String field) {
  final fields = field.split('.');

  if (fields.length > 1) {
    return fields.map((v) => '[$v]').join();
  } else {
    return '[${fields[0]}]';
  }
}

String generateFilter(
  CrudFilters? filters,
) {
  var rawQuery = '';
  if (filters != null) {
    for (final filter in filters) {
      final field = filter.field;
      final operator = filter.operator;
      final value = filter.value;

      final mapedOperator = mapOperator(operator);

      if (value is List) {
        final listValue = value as List<dynamic>;
        for (int index = 0; index < listValue.length; index++) {
          rawQuery +=
              '&filters${generateNestedFilterField(field)}[\$$mapedOperator][$index]=${listValue[index].toString()}';
        }
      } else {
        rawQuery +=
            '&filters${generateNestedFilterField(field)}[\$$mapedOperator]=${value.toString()}';
      }
    }
  }

  return rawQuery;
}
