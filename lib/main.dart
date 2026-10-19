import 'package:flutter/material.dart';
import 'dart:async';
void main()=>runApp(App());
class App extends StatelessWidget{
@override Widget build(BuildContext c)=>MaterialApp(debugShowCheckedModeBanner:false,home:Master());
}
class Master extends StatefulWidget{
@override _MasterState createState()=>_MasterState();
}
class _MasterState extends State<Master>{
String v="1.0.0+66"; String slogan="تكفس - شوف أكثر واصرف أقل!"; String comp="20MB"; bool auto=true; Timer? t; String last="الآن"; List<String> log=[];
Map server={"slogan":"تكفس - شوف أكثر، واصرف أقل! 🔋👑 تلقائي","compression":"10MB","version":"1.0.0+67"};
@override void initState(){super.initState();check();t=Timer.periodic(Duration(minutes:10),(x){if(auto)check(silent:true);});}
void check({bool silent=false}) async {
await Future.delayed(Duration(seconds:1));
if(server["compression"]!=comp){
setState((){
slogan=server["slogan"]; comp=server["compression"]; last=DateTime.now().toString().substring(11,19);
log.insert(0,"✅ $last: $comp");
});
if(!silent) ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.green,content:Text("🔄 تحدث تلقائي! $comp")));
}
}
@override Widget build(BuildContext c){
return Scaffold(
appBar: AppBar(backgroundColor:Colors.deepOrange,title:Text("تكفس $v 🤖"),actions:[Switch(value:auto,onChanged:(a)=>setState(()=>auto=a))]),
body:ListView(padding:EdgeInsets.all(12),children:[
Container(padding:EdgeInsets.all(12),decoration:BoxDecoration(color:Colors.green.shade50,borderRadius:BorderRadius.circular(12)),child:Column(children:[Row(children:[Icon(Icons.auto_mode,color:Colors.green),SizedBox(width:8),Text("تلقائي شغال 🤖",style:TextStyle(color:Colors.green,fontWeight:FontWeight.bold))]),Text("آخر: $last - كل 10د")])) ,
Card(child:ListTile(title:Text(slogan))),
Card(child:ListTile(title:Text("ضغط: $comp"),subtitle:Text("يحدث تلقائي من السيرفر"))),
Card(child:ListTile(title:Text("سجل"),subtitle:Column(children:log.isEmpty?[Text("سيحدث تلقائي")]:log.map((l)=>Text(l)).toList()))),
ElevatedButton(onPressed:()=>setState(()=>server["compression"]="5MB"),child:Text("جرب 5MB")),
]),
floatingActionButton:FloatingActionButton.extended(onPressed:()=>check(),label:Text("فحص تلقائي"),icon:Icon(Icons.autorenew)),
);
}
}
