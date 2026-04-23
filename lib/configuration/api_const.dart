abstract class ApiConst {
  // Création d'une nouvelle URL à partir d'un module et d'un path
  static Uri baseUrl({required String module, String path = ""}) {
    return Uri.parse("http://localhost:8000/api/$module/$path");
  }

  // Création d'un header
  static Map<String, String> header = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
}