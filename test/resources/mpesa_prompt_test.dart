import 'dart:async';
import 'dart:convert';
import 'package:donorlink/resources/mpesa_prompt.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('Mpesa API tests', () {
    test('promptMpesaTransaction should complete successfully', () async {
      // Mock HTTP client for the access token request
      final mockHttpClient = MockClient((request) async {
        if (request.url.toString().contains('generate')) {
          return http.Response(
              json.encode({'access_token': 'mock_access_token'}), 200);
        }
        if (request.url.toString().contains('processrequest')) {
          return http.Response(
              json.encode(
                  {'ResponseCode': '0', 'ResponseDescription': 'Success'}),
              200);
        }
        return http.Response('Not Found', 404);
      });

      const int amount = 1;
      const String donorDetails = '254758317236';
      const String orgPaymentDetails = '123456';

      // Inject the mock client into your function
      await promptMpesaTransaction(amount, donorDetails, orgPaymentDetails,
          client: mockHttpClient);
    });

    test(
        'promptMpesaTransaction should throw exception on failed access token request',
        () async {
      // Mock HTTP client for the access token request
      final mockHttpClient = MockClient((request) async {
        if (request.url.toString().contains('generate')) {
          return http.Response(json.encode({'error': 'invalid_client'}), 400);
        }
        return http.Response('Not Found', 404);
      });

      const int amount = 1;
      const String donorDetails = '254758317236';
      const String orgPaymentDetails = '123456';

      // Inject the mock client into your function
      expect(
        () async => await promptMpesaTransaction(
            amount, donorDetails, orgPaymentDetails,
            client: mockHttpClient),
        throwsException,
      );
    });

    test(
        'promptMpesaTransaction should print failure message on failed transaction',
        () async {
      // Mock HTTP client for the transaction request
      final mockHttpClient = MockClient((request) async {
        if (request.url.toString().contains('generate')) {
          return http.Response(
              json.encode({'access_token': 'mock_access_token'}), 200);
        }
        if (request.url.toString().contains('processrequest')) {
          return http.Response(
              json.encode({'errorMessage': 'Bad Request'}), 400);
        }
        return http.Response('Not Found', 404);
      });

      const int amount = 100;
      const String donorDetails = '254758317236';
      const String orgPaymentDetails = '123456';

      // Capture print output
      final printOutput = <String>[];
      final spec = ZoneSpecification(print: (_, __, ___, String msg) {
        printOutput.add(msg);
      });

      await Zone.current.fork(specification: spec).run(() async {
        await promptMpesaTransaction(amount, donorDetails, orgPaymentDetails,
            client: mockHttpClient);
      });

      expect(printOutput,
          contains('Mpesa transaction failed: {"errorMessage":"Bad Request"}'));
    });
  });

}
