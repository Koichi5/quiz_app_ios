import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

// 削除するユーザーを登録するコレクションが作成されたら、FirebaseAuthenticatonのユーザーデータを削除する.
// リージョンは、asia-northeast1を設定。自分の設定したリージョンに合わせる。
exports.deleteUser = functions
  .region("asia-northeast1")
  .firestore
  .document("deleted_users/{docId}")
  .onCreate(async (snap) => {
    const deleteDocument = snap.data();
    const uid = deleteDocument.deletedUserUid;

    await admin.auth().deleteUser(uid);
  });
