class LocalGeocoder {
  static Map<String, Map<String, String>> dummyGeocodeData = {
    "ZIM": {
      "17.8,31.0": "Mt Hampden, Harare District",
      "17.9,30.9": "Chinhoyi, Mashonaland West",
    },
    "ZMB": {
      "-15.4,28.3": "Lusaka, Lusaka Province",
      "-13.0,28.6": "Ndola, Copperbelt",
    },
    "KEN": {
      "-1.3,36.8": "Nairobi, Nairobi County",
      "0.5,37.5": "Meru, Meru County",
    },
  };

  static Map<String, String> reverseGeocode(double lat, double lng, String countryCode) {
    String key = "${lat.toStringAsFixed(1)},${lng.toStringAsFixed(1)}";
    if (dummyGeocodeData[countryCode] != null &&
        dummyGeocodeData[countryCode]!.containsKey(key)) {
      String result = dummyGeocodeData[countryCode]![key]!;
      List<String> parts = result.split(", ");
      return {'locality': parts[0], 'district': parts[1]};
    }
    return {'locality': 'Unknown', 'district': 'Unknown'};
  }
}
