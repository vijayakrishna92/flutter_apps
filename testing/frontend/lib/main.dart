import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TokenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TokenPage extends StatefulWidget {
  @override
  _TokenPageState createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  bool loading = false;
  String token = '';
  String errorMessage = '';

  Future<void> fetchToken() async {
    setState(() {
      loading = true;
      token = '';
      errorMessage = '';
    });

    try {
      final response = await http.post(
        Uri.parse('http:// /api/token/'),///// add your ip
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': 'admin', 'password': 'admin123'}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          token = data['access'];
        });
      } else {
        setState(() {
          errorMessage = 'Failed to get token: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Token Login Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: loading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: fetchToken,
                      child: Text('Login and Get Token'),
                    ),
                    SizedBox(height: 20),
                    if (token.isNotEmpty)
                      Text(
                        'Access Token:\n$token',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    if (errorMessage.isNotEmpty)
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
