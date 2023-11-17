import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/cupertino.dart';

enum VerbalTense {
  past("past"),
  future("future");
  final String tense;
  const VerbalTense(this.tense);
}
// generate HairColor enum from this list of colors. Color are stored in the enum as a string
// brown A65E26, blonde FDD700, red ED4120, black 020100, gray EFEFEF, darkGray AAABAB, darkBrown 6A2703
enum HairColor {
  brown("A65E26"),
  blonde("FDD700"),
  red("ED4120"),
  black("020100"),
  gray("EFEFEF"),
  darkGray("AAABAB"),
  darkBrown("6A2703");
  final String color;
  const HairColor(this.color);
}

// generate SkinColor enum from this list of colors. Color are stored in the enum as a string
// white F5E5DE, black A65C17, assian F4ECAD, mulatto E3AB72, aztec CF9D7C
enum SkinColor {
  white("F5E5DE"),
  black("A65C17"),
  assian("F4ECAD"),
  mulatto("E3AB72"),
  aztec("CF9D7C");
  final String color;
  const SkinColor(this.color);
}

class Pictogram extends StatelessWidget {

  final num id;
  final VerbalTense? action;
  final bool plural;
  final bool noColor;
  final HairColor? hairColor;
  final SkinColor? skinColor;



  const Pictogram({
    super.key,
    required this.id,
    this.action,
    this.plural = false,
    this.noColor = false,
    this.hairColor,
    this.skinColor,
  });

  String _buildUri(){

    String uri = "https://static.arasaac.org/pictograms/$id/$id";

    if (action != null) {
      uri = "${uri}_action-${action!.tense}";
    }

    if (plural) {
      uri = "${uri}_plural";
    }

    if (noColor) {
      uri = "${uri}_nocolor";
    }

    if (hairColor != null) {
      uri = "${uri}_hair-${hairColor!.color}";
    }

    if (skinColor != null) {
      uri = "${uri}_skin-${skinColor!.color}";
    }

    uri = "${uri}_300.png";
    return uri;

  }

  @override
  Widget build(BuildContext context) {
    return FastCachedImage(url: _buildUri(), fit: BoxFit.contain);
  }


}