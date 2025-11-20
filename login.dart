import 'package:flutter/material.dart';
import 'todo.dart';
import 'calendarPage.dart';

String email = "";
String senha = "";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) { 
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80), // espaço no topo para centralizar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                      size: 48,
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Bem-vindo!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.deepOrange),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  onChanged: (text) {
                    senha = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.deepOrange),
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepOrange,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (email == 'henrique@gmail.com' && senha == 'acqa123') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CalendarPage()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Login incorreto'),
                              content: Text('Tente novamente com o login e senha corretos'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Fechar'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Entrar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 80), // espaço no final para centralizar
              ],
            ),
          ),
        ),
      ),
    );
  }
  }
