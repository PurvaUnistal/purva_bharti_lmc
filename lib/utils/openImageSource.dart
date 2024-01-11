import '../ExportFile/export_file.dart';


//////////////  AlertDialog  /////////////////////////////////////////////////////
class OpenImageSource extends StatelessWidget {
  final Function onTapGallery, onTapCamera;
  const OpenImageSource({Key key, this.onTapGallery,this.onTapCamera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        TextButton(
          child: Text('Dismiss'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      title: Text('Choose One'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
                title: Text('Gallery',style: AppTextStyle.textTitle,),
                onTap: onTapGallery
            ),
            ListTile(
              title: Text('Camera',style: AppTextStyle.textTitle),
              onTap: onTapCamera,
            ),
          ],
        ),
      ),
    );
  }
}


/////////////////    ImageCircle   /////////////////////////////////////////////
class ImageCircle extends StatelessWidget {
  final File fileImage1;
  final String pathImage;
  const ImageCircle({Key key,this.fileImage1,this.pathImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      backgroundImage: FileImage(fileImage1),
      radius: 40,
      child: Align(
        alignment:Alignment.center,
        child:CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.7),
          child: IconButton(icon: Icon(Icons.zoom_out_map,color:Colors.white.withOpacity(0.7),),
              onPressed: () {
                Widget okButton = TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                );
                AlertDialog alert = AlertDialog(
                  title: Text("PBG DMA"),
                  content: Image.file(File(pathImage)),
                  actions: [
                    okButton,
                  ],
                );
                // show the dialog
                showDialog(context: context,builder: (BuildContext context) {
                  return alert;
                },
                );
              }),
        ),
      ),
    );
  }
}
