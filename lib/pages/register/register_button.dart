import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
     return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          shadowColor: Colors.redAccent.shade100,
          borderRadius: BorderRadius.circular(50.0),
          child: MaterialButton(
            elevation: 3.0,
            minWidth: 200.0,
            height: 42.0,
            color: Colors.redAccent,
            onPressed: _onPressed,
            child: Text('Cadastrar', style: TextStyle(color: Colors.white, fontSize: 15)),
          ),
        ),
      ),
    );
  }
}
