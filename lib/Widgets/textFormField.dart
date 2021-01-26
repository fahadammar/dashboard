import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  //* VARIABLES
  final textInput;
  final textOfLabel;
  final validator;
  final fieldIcon;
  final passTrue;
  final onSubmit;
  // CONSTRUCTORS
  TextInput(
      {this.textInput,
      this.textOfLabel,
      this.fieldIcon,
      this.passTrue,
      this.onSubmit,
      this.validator});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: Center(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "${this.textOfLabel}",

                fillColor: Colors.white,
                icon: this.fieldIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              obscureText: this.passTrue,
              validator: this.validator,
              keyboardType: textInput,
              onSaved: this.onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
