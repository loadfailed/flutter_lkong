String getAvatarUrl(String type, String imgID, String size) {
  if (imgID.length > 6) {
    imgID = '00$imgID';
  } else {
    imgID = '000$imgID';
  }
  String id =
      '${imgID.substring(0, 3)}/${imgID.substring(3, 5)}/${imgID.substring(5, 7)}/${imgID.substring(7)}';
  return 'http://img.lkong.cn/$type/${id}_avatar_$size.jpg';
}
