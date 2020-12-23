import 'package:cloud_firestore/cloud_firestore.dart';
import 'users.dart';
import 'user.dart';

class FireDatabaseService {
  final String uid;
  FireDatabaseService({this.uid});
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
    String username,
    String email,
    List languages,
    Map words,
    Map collection,
    int totalWords,
    List totalScore,
    List streaks,
    List dontShow,
    bool paid,
    Map coursePercents,
  ) async {
    return await usersCollection.doc(uid).set({
      'username': username,
      'email': email,
      'languages': languages,
      'words': words,
      'collection': collection,
      'totalWords': totalWords,
      'totalScore': totalScore,
      'streaks': streaks,
      'dontShow': dontShow,
      'paid': paid,
      'coursePercents': coursePercents,
    });
  }

  List<Users> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Users(
        username: doc.data()['username'] ?? '',
        email: doc.data()['email'] ?? '',
        languages: doc.data()['languages'] ?? [],
        words: doc.data()['words'] ?? {},
        collection: doc.data()['collection'] ?? {},
        totalWords: doc.data()['totalWords'] ?? 0,
        totalScore: doc.data()['totalScore'] ?? [0, 0],
        streaks: doc.data()['streaks'] ?? [],
        dontShow: doc.data()['dontShow'] ?? [],
        paid: doc.data()['paid'] ?? false,
        coursePercents: doc.data()['coursePercents'] ?? {}
      );
    }).toList();
  }

  Stream<List<Users>> get users {
    return usersCollection.snapshots().map(_usersListFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data()['username'],
      email: snapshot.data()['email'],
      languages: snapshot.data()['languages'],
      words: snapshot.data()['words'],
      collection: snapshot.data()['collection'],
      totalWords: snapshot.data()['totalWords'],
      totalScore: snapshot.data()['totalScore'],
      streaks: snapshot.data()['streaks'],
      dontShow: snapshot.data()['dontShow'],
      paid: snapshot.data()['paid'],
      coursePercents: snapshot.data()['coursePercents']
    );
  }

  Stream<UserData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}

var daLanguage;

class FireDatabaseServiceLanguages {
  final String luid;

  FireDatabaseServiceLanguages({this.luid});

  final CollectionReference languagesCollection =
      FirebaseFirestore.instance.collection(daLanguage);

  Future updateLanguageData(
    Map fullCourse,
    Map funCourse,
    Map popular,
    Map trending,
    Map songInfo,
  ) async {
    return await languagesCollection.doc(luid).set({
      'Full Course': fullCourse,
      'Fun Course': funCourse,
      'popular': popular,
      'trending': trending,
      'Song Info': songInfo,
    });
  }

  List<Languages> _languagesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Languages(
        fullCourse: doc.data()['Full Course'] ?? {},
        funCourse: doc.data()['Fun Course'] ?? {},
        popular: doc.data()['popular'] ?? {},
        trending: doc.data()['trending'] ?? {},
        songInfo: doc.data()['Song Info'] ?? {},
      );
    }).toList();
  }

  Stream<List<Languages>> get users {
    return languagesCollection.snapshots().map(_languagesListFromSnapshot);
  }

  LanguageData _languageDataFromSnapshot(DocumentSnapshot snapshot) {
    return LanguageData(
      luid: luid,
      fullCourse: snapshot.data()['Full Course'],
      funCourse: snapshot.data()['Fun Course'],
      popular: snapshot.data()['popular'],
      trending: snapshot.data()['trending'],
      songInfo: snapshot.data()['Song Info'],
    );
  }

  Stream<LanguageData> get languageData {
    print('luid');
    print(luid);
    return languagesCollection
        .doc(luid)
        .snapshots()
        .map(_languageDataFromSnapshot);
  }
}
