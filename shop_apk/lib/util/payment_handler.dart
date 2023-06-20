import 'package:shop_apk/util/extentions/string_extentions.dart';
import 'package:shop_apk/util/url_payment.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest();
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest();
}

class ZarinpalPaymentHandler extends PaymentHandler {
  ZarinpalPaymentHandler(this.urlHandler, this._paymentRequest);
  final PaymentRequest _paymentRequest;
  String? _status;
  String? _authority;
  final UrlHandler urlHandler;
  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(
      _paymentRequest,
      (status, paymentGatewayUri) {
        if (status == 100) {
          urlHandler.openUrl(paymentGatewayUri!);
        }
      },
    );
  }

  @override
  Future<void> initPaymentRequest() async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(1000);
    _paymentRequest.setDescription('this is for test application apple shop');
    _paymentRequest.setMerchantID('f9965e0c-2ea9-4318-97ba-2f751f4e6b2f');
    _paymentRequest.setCallbackURL('expertflutter://shop');
    linkStream.listen(
      (deeplink) {
        if (deeplink!.contains('Authority')) {
          _authority = deeplink.extractValueFromQuery('Authority');
          _status = deeplink.extractValueFromQuery('Status');
          verifyPaymentRequest();
        }
      },
    );
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(
      _status!,
      _authority!,
      _paymentRequest,
      (isPaymentSuccess, refID, paymentRequest) {
        if (isPaymentSuccess) {
          print(refID);
        } else {
          print('error');
        }
      },
    );
  }
}

class PaypalPaymentHandler extends PaymentHandler {
  @override
  Future<void> sendPaymentRequest() async {}

  @override
  Future<void> initPaymentRequest() async {}

  @override
  Future<void> verifyPaymentRequest() async {}
}
