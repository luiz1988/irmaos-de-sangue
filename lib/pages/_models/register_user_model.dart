class RegisterUser {
  final String name;
  final String email;
  final String companyId;
  final String numeroCelular;
  final String sexoId;
  final String peso;
  final String estadoCivilId;
  final String dataNascimento;
  final String dataDoacao;
  final String tipoSanguineoId;
  final String estadoId;
  final String cidadeId;
  final String pictureUrl;
  final String ultimoAgendamento;
  final String idUltimaDoacao;
  final int status;
  final String urlImage;

  RegisterUser(
      this.name,
      this.email,
      this.companyId,
      this.numeroCelular,
      this.sexoId,
      this.peso,
      this.estadoCivilId,
      this.dataNascimento,
      this.dataDoacao,
      this.tipoSanguineoId,
      this.estadoId,
      this.cidadeId,
      this.pictureUrl,
      this.ultimoAgendamento,
      this.idUltimaDoacao,
      this.status,
      this.urlImage);

  Map<String, dynamic> toJson() => {
        'nome': name,
        'email': email,
        'companyId': companyId,
        'numeroCelular': numeroCelular,
        'sexoId': sexoId,
        'peso': peso,
        'estadoCivilId': estadoCivilId,
        'dataNascimento': dataNascimento,
        'dataDoacao': dataDoacao,
        'tipoSanguineoId': tipoSanguineoId,
        'estadoId': estadoId,
        'cidadeId': cidadeId,
        'pictureUrl': pictureUrl,
        'ultimo_agendamento' : ultimoAgendamento,
        'id_ultima_doacao':idUltimaDoacao,
        'status' : status,
        'urlImage' :urlImage
      };
}
