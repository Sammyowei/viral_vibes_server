class OrderStatus {
  OrderStatus({
    required this.charge,
    required this.startCount,
    required this.link,
    required this.status,
    required this.remains,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      charge: json['charge'] as String,
      startCount: json['start_count'] as String,
      link: json['link'] as String,
      status: json['status'] as String,
      remains: json['remains'] as String,
    );
  }
  final String charge;
  final String startCount;
  final String link;
  final String status;
  final String remains;

  Map<String, dynamic> toJson() {
    return {
      'link': link,
      'charge': charge,
      'status': status,
      'startCount': startCount,
      'remains': remains,
    };
  }
}
