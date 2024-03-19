import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/login_request.dart';
import 'package:flutter_englearn/page/welcome.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      home: const Welcome(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              TextButton(
                onPressed: () async {
                  if (_usernameController.text == null ||
                      _passwordController.text == null) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Nhập đây đủ thông tin tài khoản và mật khẩu!"),
                      ),
                    );
                  } else {
                    LoginRequest loginRequest = LoginRequest(
                      username: _usernameController.text,
                      password: _passwordController.text,
                    );

                    Map<String, String> headers = {
                      "Content-type": "application/json"
                    };

                    Map<String, String> data = {
                      "username": _usernameController.text,
                      "password": _passwordController.text
                    };

                    String authority = "192.168.202.233:8080";
                    String unencodedPath = "auth/signin";

                    var response = await http.post(
                        Uri.http(authority, unencodedPath),
                        headers: headers,
                        body: jsonEncode(data));

                    if (response.statusCode == 200) {
                      // print token in data
                      print(jsonDecode(response.body)['data']['token']);
                    } else {
                      print(response.statusCode);
                    }
                  }
                },
                child: const Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
