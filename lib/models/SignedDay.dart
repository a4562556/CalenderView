class SignedDay{

   int year;
   int month;
   int day;

   SignedDay({this.year,this.month,this.day});

   factory SignedDay.fromJson(Map<String,dynamic> json)  =>_fromJson(json);

   static List<SignedDay> getList(Map<String,dynamic> json){
     return _getListJson(json);
   }

}

SignedDay _fromJson(Map<String,dynamic> json){
  return SignedDay(
     year: json["year"] as int,
     month: json["month"] as int,
     day: json["day"] as int
  );
}

List<SignedDay> _getListJson(Map<String,dynamic> json){
   var list = json["data"] as List;  
  return list.map((i)=>_fromJson(i)).toList();
}
