class BlogModel{final String id =  DateTime.now().millisecondsSinceEpoch.toString();
final String uid;
final String title;
final String description;
String? image;
final  String date;

BlogModel({required this.uid,required this.title,required this.description,this.image,required this.date});

toJson(){
  return {
    "uid":uid,
    "id":id,
    "title":title,
    "description":description,
    "image":image ??  "https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bm90ZXxlbnwwfHwwfHx8MA%3D%3D",
    "date":date,
  };
}

factory  BlogModel.fromJson(Map<String,dynamic> json){
  return BlogModel(
    uid:json["uid"],
    title:json["title"],
    description:json["description"],
    image:json["image"],
    date:json["date"],
  );
}

}