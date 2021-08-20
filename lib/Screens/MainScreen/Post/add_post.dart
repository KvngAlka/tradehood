import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Modules/user.dart';
import 'package:i2i_tradehood/Services/database_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _itemNameController;
  TextEditingController _itemDescriptionController;
 

  String itemName  = '';
  String itemdescription = '';
  File imageFile ;
  File imageFile2;

  bool loading = false;

  List<File> imageFiles = [];


   @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController();
    _itemDescriptionController = TextEditingController();
  }


  Future getImageFromCamera() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
       imageFile = image;
       
    });
    

  }

  Future getVideoFromCamera() async{
    var image = await ImagePicker.pickVideo(source: ImageSource.camera);
    setState(() {
       imageFile = image;
       
    });

  }

  Future getImageFromGallery() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
       imageFile = image;
       imageFile2 = image;
       
    });
    

  }



  @override
  Widget build(BuildContext context) {


    //wiget for upload type
    Widget uploadType(Icon icon, String tittle, String subtittle){
      return ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).primaryColor,
          ),
          child: icon,
        ),
        title: Text(tittle, style: TextStyle(color: Theme.of(context).primaryColor, 
        fontWeight: FontWeight.bold,fontSize: 20),),
        subtitle: Text(subtittle, style: TextStyle(color: Colors.blueGrey),),
      );
    }

    void _showCameraOption(){
      showModalBottomSheet(context: (context), builder: (context){
        return Container(
          padding: EdgeInsets.only(top: 10.0, left: 10,right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0)),
              color: Colors.white
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              //black line to drag the upload option  down
              Material(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: Colors.black38,
                child: Container(
                  height: 5.0,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Upload From", style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                    ),),

                    //get the image from camera function called
                    IconButton(onPressed: getImageFromCamera,
                    icon: Icon(Icons.camera_alt, size: 20,color: Theme.of(context).primaryColor,))
                  ],
                ),
              ),


              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[

                      GestureDetector(
                        onTap: getImageFromCamera,
                           child: uploadType(
                          Icon(Icons.camera_alt, color: Colors.white,), "Camera Upload","Upload picture from camera"),
                      ),
                      Divider(),


                      GestureDetector(
                        onTap: getVideoFromCamera,
                        child: uploadType(Icon(Icons.videocam, color: Colors.white,), "Video Upload", "Upload video from camera")),
                      Divider(),


                      GestureDetector(
                        onTap: getImageFromGallery,
                        child: uploadType(Icon(Icons.photo, color: Colors.white,), "Upload from gallery", "Upload picture or video from gallery"))
                    ],
                  ),
                ),
              )



            ],
          ),
        );
      });
    }

     final user = Provider.of<User>(context);
     DatabaseService databaseService = DatabaseService(uid: user.uid );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor,size: 20),
      onPressed: (){Navigator.of(context).pop();},),

      title: Text('Make a Post', style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 20, ),),
      elevation: 0.0,
      ),

      body: SingleChildScrollView(
              child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0, top: 20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7 ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.black12,
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: TextFormField(
                                controller: _itemNameController,
                                validator: (val) => val.isEmpty ? 'Please enter the name of the item' : null,
                                onChanged: (val) => setState((){ itemName = val;}),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Name of the item",
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            

                            Container(
                              color: Colors.black12,
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: TextFormField(
                                controller: _itemDescriptionController,
                                maxLines: 5,
                                minLines: 1,
                                validator: (val) => val.isEmpty ? 'Please enter the details  of the item' : null,
                                onChanged: (val) => setState((){itemdescription = val;}),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Item Details",
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 10,
                            ),

                            Row(children: <Widget>[
                              Text("Upload a photo"),
                              IconButton(
                                onPressed: (){
                                  _showCameraOption();
                                },
                                icon: Icon(Icons.photo),
                                ),
                            ],),


                            //this is the list of photos to be uploade

                            Expanded(
                              child: Container(
                                
                                child: Row(children: <Widget>[
                                 // Flexible(flex: 1,child: Image.file(imageFile,fit: BoxFit.cover,),),
                                 Expanded(child: Container(
                                   decoration: BoxDecoration(border: Border.all(color: Colors.black),),
                                   child: Center(child: 
                                   imageFile == null  ?
                                   IconButton(icon: Icon(Icons.add_a_photo), onPressed: (){
                                     _showCameraOption();
                                   },)
                                   : Image.file(imageFile,fit: BoxFit.fill,)
                                   ),
                                 ),),

                                  SizedBox(width: 10,),


                                  Expanded(child: Container(
                                     decoration: BoxDecoration(border: Border.all(color: Colors.black),),
                                    child: Center(child: 
                                    imageFile2 == null ?
                                    IconButton(icon: Icon(Icons.add_a_photo), onPressed: (){
                                      _showCameraOption();
                                    },)
                                    :  Image.file(imageFile2,fit: BoxFit.fill,)
                                    ),
                                  ),)

                                 // Flexible(flex: 1,child: Image.file(imageFile,fit: BoxFit.cover,),)
                                ],),
                              ),
                            ),

                            SizedBox(height: 10,),
                             
                            FlatButton(child: Text('Click'),onPressed: (){
                              print( user.uid +" "+ itemName + " " + itemdescription);
                              setState(() {
                                _itemNameController.text = '';
                                _itemDescriptionController.text = '';
                              });
                              
                           
                            },),
                            


                            Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              width: 200,
                              height: 50,
                              color: Theme.of(context).primaryColor,
                              child: FlatButton(
                                onPressed: ()async {
                                 
                                  if(_formKey.currentState.validate()){
                                    setState(() {
                                    loading = true;
                                  });
                                   dynamic postResult =  await databaseService.
                                      addTraderPost(user.uid, itemName, 
                                        [imageFile.toString(),], itemdescription, Timestamp.now());

                                      if(postResult == null){
                                        setState(() {
                                          loading = false;
                                        });
                                      } 
                                  }
                                  
                                },
                                child: Text("Post", style: TextStyle(color: Colors.white),),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}