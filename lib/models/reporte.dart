class Reporte {
  String title = "";
  String url = "";
  String fileName = "";
  String rptName = "";
  Map<String, dynamic>? params;
  
  //Contructor
  Reporte({
    required this.title, 
    required this.url, 
    required this.fileName, 
    required this.rptName,  
    this.params, 
  });

  
  Reporte.fromJson(Map<String?, dynamic> json)
      : 
        title = json['title'].toString(),
        url = json['url'].toString(),
        rptName = json['rptName'].toString(),
        fileName = json['fileName'].toString();

  Map<String, dynamic> toJson() => {
        'title': title,
        'url': url,
        'rptName': rptName,
        'fileName': fileName,
      };
}
