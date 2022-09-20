const enToFaNumberMap = {
  '0': '۰',
  '1': '۱',
  '2': '۲',
  '3': '۳',
  '4': '۴',
  '5': '۵',
  '6': '۶',
  '7': '۷',
  '8': '۸',
  '9': '۹'
};

// ۱-۲-۳-۴-۵-۶-۷-۸-۹
extension ReplaceAll on String {
  String replaceMap(Map<String, dynamic> fromList) {
    var result = this;
    fromList.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    return result;
  }
}
