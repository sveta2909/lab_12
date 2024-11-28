import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContainerModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class ContainerModel with ChangeNotifier {
  double _width = 100;
  double _height = 100;
  double _borderRadius = 0;

  double get width => _width;
  double get height => _height;
  double get borderRadius => _borderRadius;

  void updateWidth(double newWidth) {
    _width = newWidth;
    notifyListeners();
  }

  void updateHeight(double newHeight) {
    _height = newHeight;
    notifyListeners();
  }

  void updateBorderRadius(double newRadius) {
    _borderRadius = newRadius;
    notifyListeners();
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  } else if (value.length < 7) {
                    return "Password must be at least 7 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await login(_emailController.text, _passwordController.text);
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                child: const Text("Register"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                  );
                },
                child: const Text("Forgot Password?"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await Dio().post('https://lab12.requestcatcher.com/test', data: {
        'email': email,
        'password': password,
      });
      print('Response data from login : ${response.data}');
    } catch (e) {
      print('Error occurred while logging in : $e');
    }
  }
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    TextFormField(
    controller: _nameController,
    decoration:
    const InputDecoration(labelText: "Full Name"),
    validator:
    (value) {
    if (value == null || value.isEmpty) {
    return "Full Name is required";
    }
    return null;
    },
    ),
    const SizedBox(height:
    16),
    TextFormField(controller:_emailController,
    decoration:
    const InputDecoration(labelText:"Email"),
    validator:
    (value) {
    if (value == null || value.isEmpty) {
    return "Email is required";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return "Enter a valid email";
    }
    return null;
    },
    ),
    const SizedBox(height:
    16),
    TextFormField(controller:_passwordController,obscureText:true,decoration:
    const InputDecoration(labelText:"Password"),validator:
    (value){if(value==null||value.isEmpty){return"Password is required";}else if(value.length<7){return"Password must be at least 7 characters";}return null;},),const SizedBox(height:
    16),ElevatedButton(onPressed:
    () async {if (_formKey.currentState!.validate()) {await signup(_nameController.text, _emailController.text, _passwordController.text);}},child:
    const Text("Register"),),OutlinedButton(onPressed:
    () {Navigator.pop(context);},child:
    const Text("Back to Login"),),],),),),);}

  Future<void> signup(String name, String email, String password) async {try {final response =
  await Dio().post('https://lab12.requestcatcher.com/test', data:{'name': name,'email': email,'password': password,});print('Response data from signup : ${response.data}');} catch (e) {print('Error occurred while signing up : $e');}}
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();

    return Scaffold(
      appBar:
      AppBar(title:
      const Text('Reset Password')),
      body:
      Padding(padding:
      const EdgeInsets.all(16.0), child:
      Form(key:_formKey, child:
      Column(mainAxisAlignment:
      MainAxisAlignment.center, children:[
        TextFormField(controller:_emailController,decoration:
        const InputDecoration(labelText:"Email or Username"),validator:
            (value){if(value==null||value.isEmpty){return"This field is required";}else if(!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)){return"Enter a valid email";}return null;},),const SizedBox(height:
        16),ElevatedButton(onPressed:
            ()async{if(_formKey.currentState!.validate()){await resetPassword(_emailController.text);}},child:
        const Text("Reset Password"),),OutlinedButton(onPressed:
            (){Navigator.pop(context);},child:
        const Text("Back to Login"),),],),),),);
  }

  Future<void> resetPassword(String emailOrUsername) async {try {final response =
  await Dio().post('https://lab12.requestcatcher.com/test', data:{'email_or_username': emailOrUsername,});print('Response data from reset password : ${response.data}');} catch (e) {print('Error occurred while resetting password : $e');}}
}