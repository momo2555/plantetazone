

import 'package:flutter/material.dart';


class SimpleDropDown extends StatefulWidget {
  const SimpleDropDown({
    Key? key,
    @required this.items,
    this.focusNode,
    this.nextNode,
    this.onChange,
    }) : super(key: key);
    final List<DropdownMenuItem<String>>? items;
    final FocusNode? focusNode;
    final FocusNode? nextNode;
    final Function(String value)? onChange;
  @override
  State<SimpleDropDown> createState() => _SimpleDropDownState();
}

class _SimpleDropDownState extends State<SimpleDropDown> {
  String value = '';
  get getValue {
    return value;
  }
  @override
  void initState() {
    value = widget.items?[0].value?? '';
    
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField (
                    items: widget.items, 
                    onChanged: (val) {
                      value = val.toString();
                      widget.onChange!(val.toString());
                      
                    }, 
                    value: ( widget.items?.isNotEmpty ?? false) ? widget.items![0].value : null,
                    isExpanded: true,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    dropdownColor: Theme.of(context).primaryColorLight,
                    decoration: InputDecoration(
                     
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                        
                      ),
                      fillColor: Theme.of(context).primaryColorLight,
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                      //labelText: widget.placeholder ?? '',
                      
                    ),
                      focusNode: widget.focusNode,
                      onSaved: (value) {
                        widget.nextNode?.requestFocus();
                      },
                  );
  }
}