class ApiData<T> {
  // Ce champ permettra de savoir si l'appel de l'API a réussi ou non
  bool status = false;

  // Ce champ permettra de saisir un message d'erreur en cas d'échec de l'appel
  // Nous lui assignons une valeur par défaut
  String? message = "Désolé, une erreur est survenue";

  // Ce champ permettra de sauvegarder les données reçues de l'API
  T? data;

  // Ce constructeur sera appelé dans le cas où l'appel de l'API a réussi
  ApiData.success({required this.data})
      : status = true,
        message = null;

  // Ce constructeur sera appelé dans le cas où l'appel de l'API a échoué
  ApiData.error({this.message})
      : status = false,
        data = null;
}


