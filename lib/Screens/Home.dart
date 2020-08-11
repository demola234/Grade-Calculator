import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _dark;
  int credit = 1;
  double courseL = 5;
  String courseName = "english";
  double average = 0;
  static int count = 0;

  var formKey = GlobalKey<FormState>();

  List<classes> allCourses;
  
    @override
    void initState() { 
      super.initState();
      _dark = false;
      allCourses = [];
    }
  
    Brightness _brightness(){
      return _dark ? Brightness.dark : Brightness.light;
    }
    @override
    Widget build(BuildContext context) {
      return Theme(
            isMaterialAppTheme: true,
            data: ThemeData(
              brightness: _brightness(),
            ),
            child: Scaffold(
          backgroundColor: _dark ?null : Colors.grey.shade200,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            brightness: _brightness(),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
            leading: Text(""),
            title: Shimmer.fromColors(
                baseColor: Colors.purple,
                highlightColor: Colors.green,
                child: Text(
                  "GRADE CALCULATOR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
            ),
            actions: <Widget>[
              IconButton(
                icon: _dark ?  Icon(Icons.wb_sunny) : FaIcon(FontAwesomeIcons.moon), 
                onPressed: (){setState(() {
                  _dark = !_dark;
                });
                }
                )
            ],
          ),
  
          body: mainapp(),
        ),
      );
    }
  
  
  Widget mainapp(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SingleChildScrollView(
                      child: Container(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(12),
                          ),
                          labelText: "Course Name",
                          labelStyle: TextStyle(fontSize: 16),
                          hintText: "Enter Course Name",
                          hintStyle: TextStyle(
                            color: _dark ? Colors.white60 : Colors.grey
                          ),
                        ),
                        validator: (value){
                          if(value.length > 0){
                            return null;
                          }
                          else{
                            return "Enter Course Name";
                          }
                        },
                        onSaved: (savedValue){
                          courseName = savedValue;
                          setState(() {
                            allCourses.add(
                              classes(courseName,courseL,credit));
                            average = 0;
                            avergeScore();
                          }); 
                        },
                      ),
                      
                    Container(
                      margin: EdgeInsets.fromLTRB(14, 10, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text("Course Credit",
                      style: TextStyle(
                       color:Colors.grey[400]
                      ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              items: creditlerItems(),
                              value: credit,
                              onChanged: (creditValue){
                                credit = creditValue;
                                FocusScope.of(context)
                                .requestFocus(new FocusNode());
                              },
                            )),
                            margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                            padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                            decoration: BoxDecoration(
                              color: _dark ? Colors.grey[900] : Colors.grey[200],
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black12,
                                  offset: new Offset(0, 2),
                                  blurRadius: 1
                                )
                              ],
                              border: Border.all(
                                color: Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                        ),
                    Container(
                      margin: EdgeInsets.fromLTRB(14, 10, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text("Grades",
                      style: TextStyle(
                        color:Colors.grey

                      ),
                      )
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<double>(
                          items: GradeNo(),
                          value: courseL,
                          onChanged: (setvalue){
                            setState(() {
                              courseL = setvalue;
                              FocusScope.of(context)
                              .requestFocus(new FocusNode());
                            });
                          },
                        )),
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                            decoration: BoxDecoration(
                              color: _dark ? Colors.grey[900] : Colors.grey[200],
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black12,
                                  offset: new Offset(0, 2),
                                  blurRadius: 1
                                )
                              ],
                              border: Border.all(
                               color: Colors.transparent,
                                width: 2
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                    ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      height: 60,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: (){
                          if(formKey.currentState.validate())
                        {
                          formKey.currentState.save();
                        }
                        FocusScope.of(context).requestFocus(new  FocusNode());
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8),
                        ),
                         color: _dark ? Colors.purple : Colors.green,
                        child: Text(
                        "Calculate",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      alignment: Alignment.center,
                      height: 80,
                      decoration: BoxDecoration(
                         color: _dark ? Colors.grey[900] : Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(1, 3),
                            blurRadius: 2
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[200])
                      ),
                      child: RichText(
                        text: TextSpan(
                          // ignore: deprecated_member_use
                          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 22),
                          children: [
                            TextSpan(
                              text: 'CGPA: ',
                            style: TextStyle(
                                fontSize: 20,
                                color: _dark ? Colors.white : Colors.black
                            )
                            ),
                            TextSpan(
                              text: allCourses.length == 0 ? '0'
                              : '  ${average.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 20,
                                color:  _dark ? Colors.green : Colors.purple
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemBuilder: _listOfGrade,
              itemCount: allCourses.length,
              )
            ))
        ],
      ),
    );
  }

 List<DropdownMenuItem<int>>creditlerItems() {
 List<DropdownMenuItem<int>> creditNo = [];

for(int i = 1; i<= 7; i++){
  creditNo.add(DropdownMenuItem<int>(
    child: Text("$i credits",style: TextStyle(color: Colors.grey),),
    value: i,
    ));
}
return creditNo;
}
 

  // ignore: non_constant_identifier_names
  List<DropdownMenuItem> GradeNo() {
     List<DropdownMenuItem<double>> grade = [];

     grade.add(DropdownMenuItem(
       child: Text("A",style: TextStyle(color: Colors.grey),),
       value: 5.0,
     ));
     grade.add(DropdownMenuItem(
       child: Text("B",style: TextStyle(color: Colors.grey),),
       value: 4,
     ));
     grade.add(DropdownMenuItem(
       child: Text("C",style: TextStyle(color: Colors.grey),),
       value: 3,
     ));
     grade.add(DropdownMenuItem(
       child: Text("D",style: TextStyle(color: Colors.grey),),
       value: 2,
     ));
     grade.add(DropdownMenuItem(
       child: Text("E",style: TextStyle(color: Colors.grey),),
       value: 1,
     ));
     grade.add(DropdownMenuItem(
       child: Text("F(Carry Over)",style: TextStyle(color: Colors.grey),),
       value: 0,
     ));
     return grade;
   }

   Widget _listOfGrade(BuildContext context, int index){
     count++;
     return Dismissible(
       key: Key(count.toString()), 
      direction: DismissDirection.endToStart,
     onDismissed: (direction){
       setState(() {
          allCourses.removeAt(index);
         avergeScore();
         SystemChannels.textInput.invokeListMethod('TextInput.hide');
       });
   },
     child: Card(
       child: ListTile(
         onTap: (){
           setState(() {
             allCourses.removeAt(index);
             avergeScore();
           });
         },
         trailing: Icon(Icons.delete,
         color: _dark ? Colors.purple : Colors.green,),
         title: Text(allCourses[index].name),
         subtitle: Text("Credit Unit: " + allCourses[index].credits.toString(),
         style: TextStyle(
         color: _dark ? Colors.purple : Colors.green
         )
         ),
       )
     ));
}
   
   void avergeScore(){
   double totalClasses = 0;
   double totalCredits = 0;

   for(var NoClasses in allCourses){
     var credits = NoClasses.credits;
     var grades= NoClasses.gradesValue;

     totalClasses = totalClasses + (grades * credits);
     totalCredits += credits;
   }
   average = totalClasses / totalCredits;
   }
 }
 
  // ignore: camel_case_types
  class classes {
    String name;
    double gradesValue;
    int credits;
  classes(this.name, this.gradesValue, this.credits);
}