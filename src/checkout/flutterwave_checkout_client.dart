import 'package:mongo_dart/mongo_dart.dart';

import '../models/flutterwave_checkout_model.dart';
import '../models/flutterwave_model.dart';

class FlutterwaveCheckoutClient {
  FlutterwaveCheckoutClient();

  Future<FlutterwaveCheckout?> initializeCheckout(FlutterwaveCustomer customer,
      {required String amount}) async {
    final uuid = Uuid();
    final flutterWaveModel = FlutterWaveModel(
        customer: customer,
        amount: amount,
        currency: 'NGN',
        txRef: uuid.v1(),
        meta: Meta());

    return null;
  }
}
