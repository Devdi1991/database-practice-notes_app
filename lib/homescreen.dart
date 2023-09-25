import 'package:flutter/material.dart';
import 'package:notes_database_practice_project_one/dbhelper.dart';
import 'package:notes_database_practice_project_one/notesmodel.dart';
import 'package:notes_database_practice_project_one/uihelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titlecontroller=TextEditingController();
  TextEditingController desccontroller=TextEditingController();
  late DbHelper mydb;
  List<NotesModel>arrNotes=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mydb=DbHelper.db;
    getNotes();
  }
  void getNotes()async{
    arrNotes=await mydb.fetchNotes();
    setState(() {

    });
  }
  void addNotes(String title,String desc)async{
    bool check=await mydb.addNotes(NotesModel(title: title,
        description: desc));
    if(check){
      arrNotes=await mydb.fetchNotes();
      setState(() {

      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        centerTitle: true,
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            titlecontroller.text=arrNotes[index].title;
            desccontroller.text=arrNotes[index].description;

            showModalBottomSheet(context: context,

                builder: (BuildContext context){
                  return Container(
                    height: 400,
                    width: 320,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Uihelper.CustomTextField(titlecontroller, "Update title", Icons.title),
                        Uihelper.CustomTextField(desccontroller, "Update description", Icons.description),
                        SizedBox(height: 20,),
                        SizedBox(height: 50,width: 330,
                          child: ElevatedButton(onPressed: (){
                            var Utitle =titlecontroller.text.toString();
                            var Udesc= desccontroller.text.toString();
                            mydb.UpdateNotes(NotesModel(
                                noteid: arrNotes[index].noteid,
                                title: Utitle,
                                description: Udesc));
                            getNotes();
                            Navigator.pop(context);



                          }, child: Text('Update Data'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                            ),

                          ),
                        )


                      ],
                    ),

                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27),
                        topRight: Radius.circular(27)
                    )

                )
            );
          },
          child: ListTile(

            leading:CircleAvatar(
              child: Text("${arrNotes[index].noteid.toString()}"),
            ) ,
            title: Text("${arrNotes[index].title.toString()}"),
            subtitle:Text("${arrNotes[index].description.toString()}") ,
            trailing: InkWell(
              onTap: ()async{
                await mydb.DeleteNotes(arrNotes[index].noteid!);
                getNotes();
                setState(() {

                });
              },
                child: Icon(Icons.delete)),
          ),
        );
      },itemCount: arrNotes.length,),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: (){
_bottomSheet();
          },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
    
  }



  _bottomSheet(){
    return showModalBottomSheet(context: context,
        builder: (BuildContext context){
      return Container(
        height: 400,
        width: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Uihelper.CustomTextField(titlecontroller, "Add title", Icons.title),
            Uihelper.CustomTextField(desccontroller, "Add description", Icons.description),
            SizedBox(height: 20,),
            SizedBox(height: 50,width: 330,
              child: ElevatedButton(onPressed: (){
                addNotes(titlecontroller.text.toString(),
                    desccontroller.text.toString());
                titlecontroller.clear();
                desccontroller.clear();

              }, child: Text('Add Data'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                ),

                ),
                )


          ],
        ),

      );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(27),
            topRight: Radius.circular(27)
          )

    )
        );
  }
  _UpdateSheet(){



  }

}
