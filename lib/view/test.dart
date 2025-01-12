import 'dart:convert'; // For JSON encoding and decoding
import 'dart:io'; // For HttpClient
import 'dart:isolate'; // For Isolates

void main() async {
  // Step 1: Fetch data from an API
  final apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  final response = await fetchData(apiUrl);

  // Step 2: Process the data in an Isolate
  final processedData = await processInIsolate(response);

  // Print the processed data
  print('Processed Data: $processedData');
}

// Function to fetch data from an API
Future<String> fetchData(String url) async {
  final client = HttpClient();
  try {
    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();
    if (response.statusCode == 200) {
      return await response.transform(utf8.decoder).join();
    } else {
      throw HttpException('Failed to fetch data: ${response.statusCode}');
    }
  } finally {
    client.close();
  }
}

// Function to process data in an Isolate
Future<List<Map<String, dynamic>>> processInIsolate(String rawData) async {
  // Create a ReceivePort for communication
  final receivePort = ReceivePort();

  // Spawn an Isolate
  await Isolate.spawn(_processData, [receivePort.sendPort, rawData]);

  // Wait for the processed data from the Isolate
  return await receivePort.first;
}

// The function that runs in the Isolate
void _processData(List<dynamic> args) {
  final sendPort = args[0] as SendPort;
  final rawData = args[1] as String;

  // Simulate a heavy computation: Parse JSON and filter data
  final jsonData = json.decode(rawData) as List<dynamic>;
  final filteredData = jsonData.map((e) {
    return {
      'id': e['id'],
      'title': e['title'],
    };
  }).toList();

  // Send the processed data back to the main isolate
  sendPort.send(filteredData);
}
