import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SignupScreen extends StatefulWidget { @override State<SignupScreen> createState() => _SignupScreenState(); }
class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String name='', email='', password='', phone='', countryCode = '+88';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen:false);
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key:_formKey,
          child: ListView(
            children: [
              TextFormField(decoration: InputDecoration(labelText:'Full name'), onSaved:(v)=>name=v ?? '', validator:(v)=> v==null||v.isEmpty? 'Required':null),
              TextFormField(decoration: InputDecoration(labelText:'Email'), onSaved:(v)=>email=v ?? '', validator:(v)=> v==null||v.isEmpty? 'Required':null),
              TextFormField(obscureText:true, decoration: InputDecoration(labelText:'Password'), onSaved:(v)=>password=v ?? '', validator:(v)=> v==null||v.length<6? 'Min 6 chars':null),
              Row(children:[
                CountryCodePicker(onChanged: (c){ countryCode = c.dialCode ?? '+88'; }, initialSelection: 'BD', favorite:['+88','+91']),
                Expanded(child: TextFormField(decoration: InputDecoration(labelText:'Phone (without code)'), onSaved:(v)=>phone=v ?? '', validator:(v)=> v==null||v.isEmpty? 'Required':null)),
              ]),
              SizedBox(height:16),
              ElevatedButton(
                onPressed: loading?null: () async {
                  if(!_formKey.currentState!.validate()) return;
                  _formKey.currentState!.save();
                  setState(()=>loading=true);
                  try {
                    final fullPhone = '$countryCode$phone';
                    await auth.signUpWithEmail(name: name, email: email, password: password, phone: fullPhone);
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup failed: $e')));
                  } finally { setState(()=>loading=false); }
                },
                child: loading ? CircularProgressIndicator(color: Colors.white) : Text('Create Account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
