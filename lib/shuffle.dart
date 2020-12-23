import "dart:math";
var alreadyPlayedListIdsOG = [];

shuffled(alreadyPlayedListIds) async {
  
  var songsCount;
  
  // songsCount = await db.getCount();
 
  var randomId;
  if (alreadyPlayedListIds.length != songsCount) {
    var numberList = [];
    for (var k = 0; k < songsCount; k++) {
      numberList.add(k);
    }
    for (var k = 0; k < alreadyPlayedListIds.length; k++) {
    
      numberList.removeWhere((item) => item == (alreadyPlayedListIds[k]) - 1);
    }
   
    var random = new Random();
    randomId = numberList[random.nextInt(numberList.length)];
  } else {
    var numberList = [];
    for (var k = 0; k < songsCount; k++) {
      numberList.add(k);
    }
    var random = new Random();
    randomId = numberList[random.nextInt(numberList.length)];
    alreadyPlayedListIdsOG.clear();
  }

 
  return randomId;
}

