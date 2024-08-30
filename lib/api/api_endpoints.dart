class ApiEndpoints {
  static const String _baseUrl = "http://192.168.1.64:3000";

  static String get notes => "$_baseUrl/notes";

  static String notesById(String id) => "$_baseUrl/notes/$id";
}
