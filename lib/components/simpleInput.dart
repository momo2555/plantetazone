import 'package:flutter/material.dart';

class SimpleInput extends StatefulWidget {
  const SimpleInput({
    Key? key,
    this.placeholder,
    this.type,
    this.icon,
    this.textInputAction,
    this.focusNode,
    this.nextNode,
    this.previousNode,
    this.onChange,
    this.validator,
    this.value = "",
  }) : super(key: key);
  final String? placeholder;
  final String? type;
  final Icon? icon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final FocusNode? previousNode;
  final Function(dynamic value)? validator;
  final Function(String value)? onChange;
  final String value;
  @override
  State<SimpleInput> createState() => _SimpleInputState();
}

class _SimpleInputState extends State<SimpleInput> {
  String value = '';
   bool _obscureText = true;
  get getValue {
    return value;
  }

  InputDecoration _inputdecoration () {
   
    return InputDecoration(
        prefixIcon: widget.icon,
        hintText: widget.placeholder ?? '',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide.none,
          
        ),
        fillColor: Theme.of(context).primaryColorLight,
        filled: true,
        contentPadding: const EdgeInsets.all(15),
        suffixIcon: widget.type == 'password' ? InkWell(
          onTap: () {
            setState(() {
              _obscureText=!_obscureText;
            });
          },
          child: _obscureText ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        ) : null,
        focusColor: Theme.of(context).primaryColor,
        suffixIconColor: Theme.of(context).accentColor,
        
        //labelText: widget.placeholder ?? '',
        
      );
  }
  //TODO implement password type
  Widget _simpleInput() {
    return TextFormField(
      decoration: _inputdecoration(),
      onChanged: (val) {
        value = val;
        widget.onChange!=null?widget.onChange!(val):(){};
      },
      textInputAction:  widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value)=> (widget.validator!= null?widget.validator!(value):null),
       initialValue: widget.value,
      
    );
  }
  Widget _multilineInput() {
    return TextFormField(
      decoration: _inputdecoration(),
      maxLines: 5,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      onChanged: (val) {
        value = val;
       widget.onChange!=null?widget.onChange!(val):(){};
      },
      textInputAction:  widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
        
      },
      validator: (value)=> (widget.validator!= null?widget.validator!(value):null),
      initialValue: widget.value,
    ) ;
  }
   Widget _numericInput() {
    return TextFormField(
      decoration: _inputdecoration(),
      keyboardType: TextInputType.number,
      onChanged: (val) {
        value = val;
        widget.onChange!=null?widget.onChange!(val):(){};
      },
      textInputAction:  widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value)=> (widget.validator!= null?widget.validator!(value):null),
      initialValue: widget.value,
    ) ;
  }

  Widget _passwordInput() {
    return TextFormField(
      decoration: _inputdecoration(),
      
      onChanged: (val) {
        value = val;
        widget.onChange!=null?widget.onChange!(val):(){};
      },
      textInputAction:  widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value)=> (widget.validator!= null?widget.validator!(value):null),
      obscureText: _obscureText,
      initialValue: widget.value,
    ) ;
  }
  @override
  Widget build(BuildContext context) {
    if (widget.type == 'multiline') {
      return _multilineInput();
    } else if (widget.type == 'numeric') {
      return _numericInput();
    }else if (widget.type == "password"){
      return _passwordInput();
    }else {
      return _simpleInput();
    }
  }
}