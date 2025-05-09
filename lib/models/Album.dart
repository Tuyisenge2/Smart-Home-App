
class Album {
  final int userId;
  final int id;
  final String title;
  Album({
    required this.userId,
    required this.id,
    required this.title,
  });
  factory Album.fromJson(Map<String,dynamic> json){
return switch(json){
{'userId':int userId,'id':int id,'title':String title}=>
Album(userId: userId,id:id,title:title),
_=>throw const FormatException('failed to load Album'),
};
  }
}