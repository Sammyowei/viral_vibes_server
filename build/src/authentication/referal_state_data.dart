class ReferalStateData {
  ReferalStateData({
    this.referalCode,
  });

  factory ReferalStateData.fromJson(Map<String, dynamic> json) {
    return ReferalStateData(referalCode: json['referalCode'] as String?);
  }
  final String? referalCode;

  bool isReferalCodeNull() {
    if (referalCode == null) {
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'referalCode': referalCode,
    };
  }
}
