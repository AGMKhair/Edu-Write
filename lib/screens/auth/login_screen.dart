import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget { @override State<LoginScreen> createState() => _LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '', password = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen:false);
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key:_formKey,
          child: Column(
            children: [
              TextFormField(decoration: InputDecoration(labelText:'Email'), onSaved: (v)=>email=v ?? '', validator: (v)=> v==null||v.isEmpty ? 'Required' : null),
              TextFormField(obscureText:true, decoration: InputDecoration(labelText:'Password'), onSaved:(v)=>password=v ?? '', validator:(v)=> v==null||v.isEmpty ? 'Required' : null),
              SizedBox(height:16),
              ElevatedButton(
                  onPressed: loading ? null : () async {
                    if(!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();
                    setState(()=>loading=true);
                    try {
                      await auth.signInWithEmail(email, password);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
                    } finally {
                      setState(()=>loading=false);
                    }
                  },
                  child: loading ? CircularProgressIndicator(color: Colors.white) : Text('Login')
              ),
              TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen())), child: Text('Create account'))
            ],
          ),
        ),
      ),
    );
  }
}
