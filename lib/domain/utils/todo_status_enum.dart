enum TodoStatusEnum{
  pending ,
  complete,
  none
}

extension TodoStatusEnumExtension on TodoStatusEnum {
  String get description {
    switch (this) {
      case TodoStatusEnum.pending :
        return "pendientes";
      case TodoStatusEnum.complete:
        return "completados";
      case TodoStatusEnum.none:
        return "NONE";
    }
  }
  static TodoStatusEnum getEnumByDescription(String description){
    switch(description) {
      case "pending": return TodoStatusEnum.pending;
      case "complete": return TodoStatusEnum.complete;
      default: return TodoStatusEnum.none;
    }
}
}

