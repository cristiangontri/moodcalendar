enum Emotion { happy, crying, calm, loved, angry, bad, unassigned }

extension EmotionExtension on Emotion {
  String getName() {
    switch (this) {
      case Emotion.angry:
        return "ANGRY";
      case Emotion.bad:
        return "BAD";
      case Emotion.calm:
        return "CALM";
      case Emotion.crying:
        return "CRYING";
      case Emotion.happy:
        return "HAPPY";
      case Emotion.loved:
        return "LOVED";
      case Emotion.unassigned:
        return "UNASSIGNED";
      default:
        return "UNASSIGNED";
    }
  }
}
