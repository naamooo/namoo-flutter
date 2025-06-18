import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/core/namoo_textstyle.dart';

enum NaMooTextFieldType{
  none,
  password
}

class NaMooTextFieldWidget extends StatefulWidget {

  final NaMooTextFieldType type;
  final TextInputType textInputType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String title;
  final Function? onChanged;
  final Widget? suffix;
  final String? widgetTitle;



  const NaMooTextFieldWidget({
    this.type = NaMooTextFieldType.none,
    this.textInputType = TextInputType.text,
    this.suffix,
    this.widgetTitle,
    this.onChanged,
    required this.controller,
    required this.focusNode,
    required this.title,
    super.key
  });

  @override
  State<NaMooTextFieldWidget> createState() => _NaMooTextFieldWidgetState();
}

class _NaMooTextFieldWidgetState extends State<NaMooTextFieldWidget> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: NaMooTextStyle.heading2(color: NaMooColor.main500),),
        const SizedBox(height: 3),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFD9D9D9),
              border: widget.focusNode.hasFocus ? Border.all(
                  color: NaMooColor.main500,
                  width: 2
              ) : null
          ),
          child: TextFormField(
            style: NaMooTextStyle.heading2(color: NaMooColor.black),
            controller: widget.controller,
            focusNode: widget.focusNode,
            cursorColor: NaMooColor.main500,
            onChanged: (value) => widget.onChanged,
            keyboardType: widget.textInputType,
            obscureText: !_isClicked && widget.type == NaMooTextFieldType.password,
            obscuringCharacter: "⦁",
            decoration: InputDecoration(
              hintText: widget.widgetTitle ?? widget.title,
              hintStyle: NaMooTextStyle.heading2(color: Color(0xFFA7A7A7)),
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
              counterText: "",
              suffix: widget.suffix,
                suffixIcon: widget.type == NaMooTextFieldType.password ? GestureDetector(
                  onTap: (){
                    setState(() {
                      _isClicked ? _isClicked = false : _isClicked = true;
                    });},
                  child: Padding(padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(_isClicked ?
                    "assets/images/icons/core/eyes_open_icons.svg" :
                    "assets/images/icons/core/eyes_close_icons.svg"
                    ),
                  ),
                ) : null
            ),
            onTap: (){
              FocusScope.of(context).hasFocus
                  ? FocusScope.of(context).unfocus()
                  : FocusScope.of(context).hasFocus;
            },
            onTapOutside: (event){
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ],
    );
  }
}
