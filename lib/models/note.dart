class NoteModel {
  late String? id;
  late String? title;
  late String? content;

  NoteModel({this.id, required this.title, this.content});

  // Método para converter o modelo em um Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  // Método para criar o modelo a partir de um Map
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  // Método toString para exibir as propriedades do modelo de forma legível
  @override
  String toString() {
    return 'NoteModel{id: $id, title: $title, content: $content}';
  }
}
