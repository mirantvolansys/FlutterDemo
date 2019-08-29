import 'package:flutter/material.dart';

class FormValidation extends StatefulWidget {
  @override
  _FormValidationState createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _mobile = "";
  bool _autoValidate = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Form Validations"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
              autovalidate: _autoValidate,
              key: _formKey,
              child: formUI(),
          ),
        ),
      ),
    );
  }

  //Form UI
  Widget formUI() {
    final theme = Theme.of(context);
    //final style = theme.textTheme.caption.copyWith(color: Colors.blueAccent);

    return Column(
      children: <Widget>[
        TextFormField(
          cursorColor: Colors.blueAccent,
          decoration: InputDecoration(
            labelText: "Full Name",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.text,
          autocorrect: false,
          textCapitalization: TextCapitalization.words,
          maxLength: 32,
          validator: validateName,
          onSaved: (String val) {
            _name = val;
          },
        ),
        SizedBox(
          height: 4.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.phone),
            labelText: "Mobile Number",
          ),
          keyboardType: TextInputType.phone,
          autocorrect: false,
          maxLength: 10,
          validator: validateMobile,
          onSaved: (String val) {
            _mobile = val;
          },
        ),
        SizedBox(
          height: 4.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: "Email ID",
          ),
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          maxLength: 32,
          validator: validateEmail,
          onSaved: (String val) {
            _email = val;
          },
        ),
        SizedBox(
          height: 4.0,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Password"),
          keyboardType: TextInputType.text,
          autocorrect: false,
          obscureText: true,
          maxLength: 32,
          //: validateEmail,
          onSaved: (String val) {
            //_email = val;
          },
        ),
        SizedBox(
          height: 4.0,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Bio"),
          keyboardType: TextInputType.text,
          autocorrect: true,
          maxLines: 3,
          maxLength: 250,
          //validator: validateEmail,
          onSaved: (String val) {
            //_email = val;
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        RaisedButton(
          child: Text("Submit"),
          onPressed: _validateInputs,
        )
      ],
    );
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if(value.length != 10){
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }

  void _validateInputs() {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("Name $_name");
      print("Mobile $_mobile");
      print("Email $_email");
    } else {
      //Validator Error
      setState(() {
        _autoValidate = true;
      });
    }
  }


}





