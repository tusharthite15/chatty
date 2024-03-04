import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

//reference for the users collection

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("user");

////reference for the group collection

  final CollectionReference groupCollection =
  FirebaseFirestore.instance.collection("groups");

//Saving the user data
  Future savingteUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "email": email,
      "fullName": fullName,
      "groups": [],
      "profilePic": "",
      "uid": uid
    });
  }

//getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
    await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  //get user groups
  getuserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  //creating a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessageSender": "",
    });
    //updating the members who created a grp
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
      FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  //getting chats from db
  getChat(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  //getting group admin from db
  Future getAdminName(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  //get grp members
  getGroupMembers(String groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  //adding the group members
  Future<void> addGroupMember(String groupId, String memberId,
      String memberName) async {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('members')
        .doc(memberId)
        .set({'name': memberName});
  }

  //searching
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  //cheaking the group value is available in db

  Future<bool> isUserJoined(String groupName, String groupId,
      String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

//fetching data about group join or exitt
  Future toggeleGroupJoin(String groupId, String userName,
      String groupName) async {
    //doc ref
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = userCollection.doc(uid);


    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

//if user has that perticular group then remove them or also rejoin them
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }

    }

    //for sending and recieving the img files
  }
