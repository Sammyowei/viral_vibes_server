// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers, lines_longer_than_80_chars, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:viral_vibes_server/lib.dart';

import '../db/db_controller.dart';
import '../models/order_model.dart';
import '../models/service_model.dart';
import '../models/user_model.dart';
import '../network/network.dart';
import 'service_client.dart';

class ServiceProvider extends ServiceClient {
  ServiceProvider({
    this.accountIdentifier,
    this.orderId,
  });

  List<Service> _serviceList = [];
  final String? accountIdentifier;
  final int? orderId;

  List<Service> get services => _serviceList;
  static final networkClient = NetworkHttpClient(baseUrl: Env.serviceApiUrl);
  static DbController _dbController = DbController(
    store: Env.dbStore,
  );
  static double nairaToDollar = 1250;
  static const endPoint = 'api/v2';

  Service? getServiceDetails(int serviceId) {
    services.sort((a, b) => a.serviceId.compareTo(b.serviceId));
    var low = 0;
    var high = services.length - 1;
    while (low <= high) {
      final mid = (low + (high - low) / 2).floor();

      if (services[mid].serviceId == serviceId) {
        return services[mid];
      } else if (services[mid].serviceId.compareTo(serviceId.toString()) < 0) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
  }

  @override
  Future<Map<String, dynamic>> addOrder(
    int orderId,
    String link,
    int quantity,
  ) async {
    final service = getServiceDetails(orderId);
    final companybalance = await getCompanyBalance();

    if (service == null) {
      throw ArgumentError();
    }

    await _dbController.openConnection();

    final userData = await _dbController.read(accountIdentifier!);
    await _dbController.closeConnection();
    if (userData == null) {
      throw const SocketException.closed();
    }

    final user = User.fromJson(userData);

    final walletBalance = user.walletBalance;
    final ratePer1k = double.parse(service.rate);
    final servicePrice = (ratePer1k / 1000) * quantity;

    if (servicePrice > companybalance) {
      // TODO: fix this response.

      // TODO: implement amazon SNS for push notification trigger.
      return {
        'error':
            "We're currently experiencing a service downtime, please try again later",
      };
    }

    if (servicePrice > walletBalance) {
      return {'error': 'Insufficient funds.'};
    }

    final data = {'key': Env.serviceApiKey, 'action': 'order'};
    final order = await networkClient.postRequest(endPoint, data);
    if (order.statusCode != HttpStatus.ok) {
      return {'error': 'We apologize, an error occurred on our end.'};
    }

    user.withraw(servicePrice);

    final jsonBody = jsonDecode(order.body);

    final orderIdentifier = jsonBody['order'];

    final orderData = OrderModel(id: orderIdentifier as int, link: link);

    user.addOrder(orderData);

    await _dbController.openConnection();
    await _dbController.update(accountIdentifier!, user.toJson());
    await _dbController.closeConnection();
    return {
      'message': 'The order has been successfully placed.',
      'details': {
        'id': service.serviceId,
        'charge': servicePrice,
        'link': link,
      }
    };
  }

  @override
  Future<Map<String, dynamic>> createMultipleOrderRefil(
    List<int> orderIds,
  ) async {
    // TODO: implement createMultipleOrderRefil
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> createOrderRefil(int orderId) async {
    // TODO: implement createOrderRefil
    throw UnimplementedError();
  }

  @override
  Future<double> getCompanyBalance() async {
    final body = {
      'key': Env.serviceApiKey,
      'action': 'balance',
    };

    final payload = await networkClient.postRequest(endPoint, body);
    final data = jsonDecode(payload.body);

    final usdAmount = data['balance'] as double;
    final companyWalletBalance = usdAmount * 1100;
    return companyWalletBalance;
  }

  @override
  Future<void> initialize() async {
    final body = {
      'key': Env.serviceApiKey,
      'action': 'services',
    };

    final payload = await networkClient.postRequest(endPoint, body);

    final serviceList = json.decode(payload.body);
    if (serviceList is! List) {
      throw ServiceException(
        "We're encountering issues retrieving resources from the server, impacting our operations",
      );
    }
    for (final _service in serviceList) {
      final service = Service.fromJson(_service as Map<String, dynamic>)
        ..convertRate(nairaToDollar);
      _serviceList.add(service);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> orderStatus() async {
    StringBuffer idsBuffer = StringBuffer();
    var orderIds = '';
    await _dbController.openConnection();
    final userData = await _dbController.read(accountIdentifier!);
    await _dbController.closeConnection();

    if (userData == null) {
      throw Exception('You are not allowed to perform this action');
    }

    final user = User.fromJson(userData);

    final orderList = user.orderHistory;

    if (orderList.isEmpty) {
      return [];
    }
    for (var i = 0; i < orderList.length; i++) {
      if (i != 0) {
        idsBuffer.write(',');
      }
      idsBuffer.write(orderList[i].id);
    }

    orderIds = idsBuffer.toString();

    final data = {
      'key': Env.serviceApiKey,
      'action': 'status',
      'orders': orderIds,
    };
    final status = await networkClient.postRequest(endPoint, data);

    if (status.statusCode != 200) {
      throw Exception('We are experiencing a service downtime.');
    }

    final jsonPayload = jsonDecode(status.body) as Map<String, dynamic>;

    final orderStatusList = <Map<String, dynamic>>[];
    if (jsonPayload.isEmpty) {
      return [];
    }

    for (final element in jsonPayload.values) {
      orderStatusList.add(element as Map<String, dynamic>);
    }

    return orderStatusList;
  }
}
