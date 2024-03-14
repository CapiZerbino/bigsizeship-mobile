// // flatten function
// Map<String, dynamic> flatten(dynamic data) {
//   if (data['attributes'] == null) return data as Map<String, dynamic>;

//   return {
//     'id': data['id'],
//     ...data['attributes'] as Map<String, dynamic>, // Spread operator
//   };
// }

// // isObject function
// bool isObject(dynamic data) => data is Map;

// dynamic normalizeData(dynamic data) {
//   if (data is List) {
//     return data.map(normalizeData).toList();
//   }

//   if (isObject(data)) {
//     // Declare newData as nullable
//     Map<String, dynamic>? newData;

//     if (data['data'] is List) {
//       newData = data['data'] as List<dynamic>;
//     } else if (isObject(data['data'])) {
//       newData = flatten(data['data']) as Map<String, dynamic>;
//     } else if (data['data'] == null) {
//       newData = null;
//     } else {
//       newData = flatten(data);
//     }

//     // Get keys of newData
//     final keys = newData?.keys;
//     if (keys == null) return newData;

//     // for each key of newData, normalize the value
//     for (final key in keys) {
//       newData![key] = normalizeData(newData[key]);
//     }
//     return newData;
//   }

//   return data;
// }

import 'package:flutter/material.dart';

Map<String, dynamic> flattenJson(Map<String, dynamic> json) {
  Map<String, dynamic> result = {};

  json.forEach((key, value) {
    if (value is Map &&
        value.containsKey('data') &&
        value.containsKey('attributes')) {
      var data = value['data'];
      if (data is List) {
        for (var dataItem in data) {
          if (dataItem is Map && dataItem.containsKey('attributes')) {
            result.addAll(
                flattenJson(dataItem['attributes'] as Map<String, dynamic>));
          }
        }
      } else if (data is Map && data.containsKey('attributes')) {
        result.addAll(flattenJson(data['attributes'] as Map<String, dynamic>));
      }
    } else if (value is Map) {
      result.addAll(flattenJson(value as Map<String, dynamic>));
    } else {
      result[key] = value;
    }
  });

  return result;
}

List<Map<String, dynamic>> processJsonData(dynamic jsonData) {
  List<Map<String, dynamic>> flattenedData = [];

  if (jsonData != null) {
    if (jsonData is Map<String, dynamic> && jsonData.containsKey('data')) {
      var data = jsonData['data'];
      if (data != null) {
        if (data is List<dynamic>) {
          for (var dataItem in data) {
            if (dataItem is Map<String, dynamic>) {
              Map<String, dynamic> flattenedItem = flattenJson(dataItem);
              flattenedData.add(flattenedItem);
            }
          }
        } else if (data is Map<String, dynamic> &&
            data.containsKey('attributes')) {
          Map<String, dynamic> flattenedItem =
              flattenJson(data['attributes'] as Map<String, dynamic>);
          flattenedData.add(flattenedItem);
        }
      }
    } else if (jsonData is Map<String, dynamic> &&
        jsonData.containsKey('attributes')) {
      Map<String, dynamic> flattenedItem =
          flattenJson(jsonData['attributes'] as Map<String, dynamic>);
      flattenedData.add(flattenedItem);
    }
  }

  debugPrint('Flattened Data: $flattenedData');

  return flattenedData;
}

// Map<String, dynamic> flattenJson(Map<String, dynamic> json) {
//   Map<String, dynamic> result = {};

//   json.forEach((key, value) {
//     if (value is List) {
//       for (var listItem in value) {
//         if (listItem is Map && listItem.containsKey('attributes')) {
//           result.addAll(
//               flattenJson(listItem['attributes'] as Map<String, dynamic>));
//         } else {
//           result[key] = value;
//         }
//       }
//     } else if (value is Map && value.containsKey('attributes')) {
//       result.addAll(flattenJson(value['attributes'] as Map<String, dynamic>));
//     } else {
//       result[key] = value;
//     }
//   });

//   return result;
// }

// List<Map<String, dynamic>> processJsonData(dynamic jsonData) {
//   List<Map<String, dynamic>> flattenedData = [];

//   if (jsonData != null && jsonData is Map<String, dynamic>) {
//     var data = jsonData['data'];
//     if (data != null) {
//       if (data is List<dynamic>) {
//         for (var dataItem in data) {
//           if (dataItem is Map<String, dynamic>) {
//             Map<String, dynamic> flattenedItem = flattenJson(dataItem);
//             flattenedData.add(flattenedItem);
//           }
//         }
//       } else if (data is Map<String, dynamic> &&
//           data.containsKey('attributes')) {
//         Map<String, dynamic> flattenedItem =
//             flattenJson(data['attributes'] as Map<String, dynamic>);
//         flattenedData.add(flattenedItem);
//       }
//     }
//   }

//   return flattenedData;
// }

// Map<String, dynamic> flatten(Map<String, dynamic> data) {
//   if (data['attributes'] == null) return data;

//   return {'id': data['id'], ...data['attributes'] as Map<String, dynamic>};
// }

// Map<String, dynamic> normalizeData(dynamic data) {
//   bool isObject(dynamic data) => data is Map;

//   if (data is List) {
//     return data.map(normalizeData).toList() as Map<String, dynamic>;
//   }

//   if (isObject(data)) {
//     if (data['data'] != null) {
//       if (data['data'] is List) {
//         data['data'] = List<Map<String, dynamic>>.from(
//           data['data'] as List<Map<String, dynamic>>,
//         ).map(flatten).toList();
//       } else if (isObject(data['data'])) {
//         data['data'] = flatten({...data['data'] as Map<String, dynamic>});
//       } else if (data['data'] == null) {
//         data = null;
//       } else {
//         data = flatten(data as Map<String, dynamic>);
//       }
//     }

//     for (var key in data.keys.toList() as List<String>) {
//       if (isObject(data[key])) {
//         data[key] = normalizeData(data[key]);
//       }
//     }

//     return data as Map<String, dynamic>;
//   }

//   return data as Map<String, dynamic>;
// }

dynamic flatten(dynamic data) {
  print('Flatten data: $data\n');
  if (data['attributes'] == null) return data;
  final attribute = data['attributes'];
  print('Flatten attribute: $attribute\n');

  return {'id': data['id'], ...data['attributes'] as Map<String, dynamic>};
}

dynamic normalizeData(dynamic data) {
  bool isObject(dynamic data) => data is Map;

  if (data is List) {
    return data.map(normalizeData).toList() as Map<String, dynamic>;
  }

  if (isObject(data)) {
    if (data['data'] != null) {
      if (data['data'] is List) {
        // Convert 'data' to an array
        data = List<Map<String, dynamic>>.from(
          data['data'] as List<Map<String, dynamic>>,
        ).map(flatten).toList();
      } else if (isObject(data['data'])) {
        print('Data is Object, so we can flatten it');
        data = flatten({...data['data'] as Map<String, dynamic>});
      } else if (data['data'] == null) {
        print('Data is Null, Do not doing');
        data = null;
      } else {
        print('Last case');
        data = flatten(data as Map<String, dynamic>);
      }
    }

    // get keys of data
    final keys = data.keys as List<String>;

    for (var key in keys) {
      if (isObject(data[key])) {
        data[key] = normalizeData(data[key]);
      }
    }

    return data;
  }

  return data as Map<String, dynamic>;
}
