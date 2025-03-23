class Reporte {
  String title = "";
  String url = "";
  String fileName = "";
  Map<String, dynamic>? params;
  
  //Contructor
  Reporte({
    required this.title, 
    required this.url, 
    required this.fileName, 
    this.params, 
  });

  
  Reporte.fromJson(Map<String?, dynamic> json)
      : 
        title = json['title'].toString(),
        url = json['url'].toString(),
        fileName = json['fileName'].toString();

  Map<String, dynamic> toJson() => {
        'title': title,
        'url': url,
        'fileName': fileName,
      };
}
