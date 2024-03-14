import 'package:bigsizeship_mobile/core/utils/pagination.dart';

List<String> generateSort(CrudSorting? sorters) {
  List<String> sort = [];

  if (sorters != null) {
    sorters.forEach((item) {
      if (item['order'] != null) {
        sort.add('${item['field']}:${item['order']}');
      }
    });
  }

  return sort;
}
