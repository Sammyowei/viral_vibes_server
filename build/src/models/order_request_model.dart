class RequestOrderModel {
  RequestOrderModel({
    required this.accountId,
    required this.order,
  });

  factory RequestOrderModel.fromJson(Map<String, dynamic> json) {
    return RequestOrderModel(
      accountId: json['accountID'] as String?,
      order: ServiceOrder.fromJson(
        json['order'] as Map<String, dynamic>?,
      ),
    );
  }
  final String? accountId;
  final ServiceOrder? order;

  Map<String, dynamic> toJson() {
    return {
      'accountID': accountId,
      'order': order?.toJson(),
    };
  }

  Map<String, dynamic>? validate() {
    final response = {
      'error': 'require the following credentials',
      'data': {
        'accountID': 'required this field',
        'order': {
          'message': 'Require this fields',
          'data': {
            'link': 'required as string',
            'quantity': 'required as int',
            'serviceID': 'required as String',
          },
        },
      },
    };

    if (accountId == null || order == null) {
      if (accountId != null) {
        (response['data']! as Map<String, dynamic>).remove('accountId');
      }

      if (order != null) {
        (response['data']! as Map<String, dynamic>).remove('oder');
      }

      return response;
    }
    return null;
  }
}

class ServiceOrder {
  ServiceOrder({
    required this.link,
    required this.quantity,
    required this.serviceID,
  });

  factory ServiceOrder.fromJson(Map<String, dynamic>? json) {
    return ServiceOrder(
      link: json?['link'] as String?,
      quantity: json?['quantity'] as int?,
      serviceID: json?['serviceID'] as String?,
    );
  }
  final String? link;

  final String? serviceID;

  final int? quantity;

  Map<String, dynamic> toJson() {
    return {
      'link': link,
      'serviceID': serviceID,
      'quantity': quantity,
    };
  }
}
