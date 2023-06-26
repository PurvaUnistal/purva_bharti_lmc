import '../ExportFile/export_file.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText, labelText;
  final Function onChanged;
  const CustomTextField({Key key, this.controller, this.hintText, this.labelText, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,

          decoration: InputDecoration(
            contentPadding:EdgeInsets.symmetric(vertical: 12,horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: BorderSide(color: Colors.grey,),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: BorderSide(color: Colors.grey,),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: BorderSide(color: Colors.blue,),
            ),
            hintText: hintText,
            labelText:  labelText,
          ),
          enabled : false,
          onChanged: onChanged,
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}

customCard(String cardText){
  return Card(
      color: Colors.white70,
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(cardText),
      ));
}
