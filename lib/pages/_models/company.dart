class Empresa {
  final String empresaUrl;
  final String imageUrl;
  final String nome;
  final String quatidadeLitro;

  Empresa(this.empresaUrl, this.imageUrl, this.nome, this.quatidadeLitro);

    Map<String, dynamic> toJson() =>
    {
      'empresaUrl': empresaUrl,
      'imageUrl': imageUrl,
      'nome': nome,
      'quatidadeLitro': quatidadeLitro
    };

}