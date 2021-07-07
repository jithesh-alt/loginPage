import 'package:flutter/material.dart';

class PasswordFormBuilder extends StatefulWidget {
  final String initialValue;
  final bool enabled;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final FocusNode focusNode, nextFocusNode;
  final VoidCallback submitAction;
  final bool obscureText;
  final FormFieldValidator<String> validateFunction;
  final void Function(String) onSaved, onChange;
  final Key key;
  final IconData prefix;
  final IconData suffix;

  PasswordFormBuilder(
      {this.prefix,
      this.suffix,
      this.initialValue,
      this.enabled,
      this.hintText,
      this.textInputType,
      this.controller,
      this.textInputAction,
      this.nextFocusNode,
      this.focusNode,
      this.submitAction,
      this.obscureText = false,
      this.validateFunction,
      this.onSaved,
      this.onChange,
      this.key});

  @override
  _PasswordFormBuilderState createState() => _PasswordFormBuilderState();
}

class _PasswordFormBuilderState extends State<PasswordFormBuilder> {
  String error;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              child: TextFormField(
                initialValue: widget.initialValue,
                enabled: widget.enabled,
                onChanged: (val) {
                  error = widget.validateFunction(val);
                  setState(() {});
                  widget.onSaved(val);
                },
                style: TextStyle(
                  fontSize: 15.0,
                ),
                key: widget.key,
                controller: widget.controller,
                // obscureText: widget.obscureText,
                obscureText: obscureText,
                keyboardType: widget.textInputType,
                validator: widget.validateFunction,
                onSaved: (val) {
                  error = widget.validateFunction(val);
                  setState(() {});
                  widget.onSaved(val);
                },
                textInputAction: widget.textInputAction,
                focusNode: widget.focusNode,
                onFieldSubmitted: (String term) {
                  if (widget.nextFocusNode != null) {
                    widget.focusNode.unfocus();
                    FocusScope.of(context).requestFocus(widget.nextFocusNode);
                  } else {
                    widget.submitAction();
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    widget.prefix,
                    size: 20,
                    color: Colors.indigoAccent[700],
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() => obscureText = !obscureText);
                    },
                    child: Icon(
                      obscureText ? widget.suffix : Icons.visibility_off,
                      size: 19.0,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: InputBorder.none,
                  enabledBorder: border(context),
                  focusedBorder: focusBorder(context),
                  errorStyle: TextStyle(height: 0.0, fontSize: 0.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Visibility(
            visible: error != null,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                '$error',
                style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  border(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
        width: 0.0,
      ),
    );
  }

  focusBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: Colors.blue[900],
        width: 2.0,
      ),
    );
  }
}
