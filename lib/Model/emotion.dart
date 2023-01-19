enum Emotion { happy, crying, calm, loved, angry, bad, sick, unassigned }

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
      case Emotion.sick:
        return "SICK";

      default:
        return "UNASSIGNED";
    }
  }

  static Emotion parse(String s) {
    switch (s) {
      case "ANGRY":
        return Emotion.angry;
      case "BAD":
        return Emotion.bad;
      case "CALM":
        return Emotion.calm;
      case "CRYING":
        return Emotion.crying;
      case "HAPPY":
        return Emotion.happy;
      case "LOVED":
        return Emotion.loved;
      case "UNASSIGNED":
        return Emotion.unassigned;
      case "SICK":
        return Emotion.sick;

      default:
        return Emotion.unassigned;
    }
  }
}
