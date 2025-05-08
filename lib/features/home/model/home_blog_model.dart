class HomeBlogModel{
  final String id;
  final String uid;
  final String title;
  final String description;
  String? image;
  final  String date;

  HomeBlogModel({required this.uid,required this.title,required this.description,this.image,required this.date,required this.id});


  factory  HomeBlogModel.fromJson(Map<String,dynamic> json){
    return HomeBlogModel(
      id:json["id"],
      uid:json["uid"],
      title:json["title"],
      description:json["description"],
      image:json["image"] ?? "https://images.unsplash.com/photo-1501504905252-473c47e087f8?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      date:json["date"],
    );
  }

}