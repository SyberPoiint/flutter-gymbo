class Round {

  Round({
    this.id,
    this.weight,
    this.round,
    this.rep,
    this.exerciseId,
    this.weekId,
    this.programId
  });

  int id;
  int weight;
  int round;
  int rep;
  int exerciseId;
  String weekId;
  String programId;

  static final columns = ['id', 'weight', 'round', 'rep', 'exerciseId', 'programId', 'programId'];

  Map<String, dynamic> toMap() => {
    'id': id,
    'weight': weight,
    'round': round,
    'rep': rep,
    'exerciseId': exerciseId,
    'weekId': weekId,
    'programId': programId
  };

  factory Round.fromMap(Map<String, dynamic> json) => new Round(
    id: json['id'],
    weight: json['weight'],
    round: json['round'],
    rep: json['rep'],
    exerciseId: json['exerciseId'],
    weekId: json['weekId'],
    programId: json['programId']
  );
}