import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();


exports.deleteUser = functions
  .region("asia-northeast1")
  .firestore
  .document("deleted_users/{docId}")
  .onCreate(async (snap) => {
    const deleteDocument = snap.data();
    const uid = deleteDocument.deletedUserUid;

    await admin.auth().deleteUser(uid);
  });
