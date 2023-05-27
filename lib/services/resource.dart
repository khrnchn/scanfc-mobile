import 'package:http/http.dart';

// To store data before send to the api and handle the reponse
class Resource {
  // Store API url
  String url;
  // Function to handle response from API
  Function(Response response) parse;
  // Data need to be send
  final dynamic data;
  // Params to be send
  final Map<String, dynamic>? params;

  // Constructor
  Resource({required this.url, required this.parse, this.data, this.params});
}