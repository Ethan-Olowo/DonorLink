import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> promptMpesaTransaction(
    int amount, String donorDetails, String orgPaymentDetails,
    {http.Client? client}) async {
  client ??= http.Client();
  String url =
      "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest";
  String consumerKey = REMOVED;
  String consumerSecret =
      REMOVED;
  String shortCode = '112345';
  String passkey = "YOUR_PASSKEY";
  String callbackUrl = "YOUR_CALLBACK_URL";

  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String password = base64Encode(utf8.encode(shortCode + passkey + timestamp));

  Map<String, String> headers = {
    'Authorization':
        'Bearer ${await _getMpesaAccessToken(consumerKey, consumerSecret, client: client)}',
    'Content-Type': 'application/json'
  };

  Map<String, dynamic> body = {
    "BusinessShortCode": shortCode,
    "Password": password,
    "Timestamp": timestamp,
    "TransactionType": "CustomerBuyGoodsOnline",
    "Amount": amount,
    "PartyA": donorDetails,
    "PartyB": shortCode,
    "PhoneNumber": donorDetails,
    "CallBackURL": callbackUrl,
    "AccountReference": "Donation",
    "TransactionDesc": "Donation"
  };

  http.Response response = await client.post(
    Uri.parse(url),
    headers: headers,
    body: json.encode(body),
  );

  if (response.statusCode == 200 || response.statusCode == 0) {
    print("Mpesa transaction successful");
  } else {
    print("Mpesa transaction failed: ${response.body}");
  }
}

Future<String> _getMpesaAccessToken(String consumerKey, String consumerSecret,
    {http.Client? client}) async {
  client ??= http.Client();
  String url =
      "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials";
  String auth = base64Encode(utf8.encode("$consumerKey:$consumerSecret"));

  http.Response response = await client.get(
    Uri.parse(url),
    headers: {'Authorization': 'Basic $auth'},
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    return jsonResponse['access_token'];
  } else {
    throw Exception('Failed to get Mpesa access token');
  }
}
