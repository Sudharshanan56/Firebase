import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/home.dart';
import 'package:firebase_authentication/signin.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {

  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name = "",password = "",email = "";

  final namecontroller = TextEditingController();

  final mailcontroller = TextEditingController();

  final passwordController = TextEditingController();

  final _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    registration() async {
if (password != null &&
   namecontroller.text.isNotEmpty &&
   mailcontroller.text.isNotEmpty) {
 try {
   UserCredential userCredential = await FirebaseAuth.instance
       .createUserWithEmailAndPassword(
           email: mailcontroller.text.trim(),
           password: password!.trim());

   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
       content: Text("Registered Successfully",
           style: TextStyle(fontSize: 20.0)),
     ),
   );

   Navigator.push(
       context, MaterialPageRoute(builder: (context) => Home()));
 } on FirebaseAuthException catch (e) {
   if (e.code == 'weak-password') {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         backgroundColor: Colors.orangeAccent,
         content: Text("Password Provided is too Weak",
             style: TextStyle(fontSize: 18.0)),
       ),
     );
   } else if (e.code == 'email-already-in-use') {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         backgroundColor: Colors.orangeAccent,
         content: Text("Email Already Exists",
             style: TextStyle(fontSize: 18.0)),
       ),
     );
   }
 }
}
}
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(height: 60),
            
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: namecontroller,
                  decoration: InputDecoration(
                    hintText: "Name",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
            
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: mailcontroller,
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
            
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
            
                ElevatedButton(
                  onPressed: () {
                    // Sign up logic
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        name = namecontroller.text;
                        email = mailcontroller.text;
                        password = passwordController.text;
                      });
                     
                    } registration();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          // color: Colors.red[200],
                        ),
                        child: Image.asset(
                          "assets/google.png",
                          fit: BoxFit.cover,
                        ),
            
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(width: 20),
            
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          // color: Colors.red[200],
                        ),
                        child: Image.asset("assets/apple.png", fit: BoxFit.cover),
            
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                ),
            
                const Spacer(),
            
                InkWell(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          // Navigate to login
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
