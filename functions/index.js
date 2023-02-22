const functions = require("firebase-functions");
const admin = require("firebase-admin");

const serviceAccount = require("./flutter-chat-3456c-service-key.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});


exports.myFunction = functions.firestore
    .document("chat/{message}")
    .onCreate((snapshot, context) => {
      admin.messaging().sendToTopic("Chat", {
        notification: {
          title: snapshot.data().username,
          body: snapshot.data().text,
        },
      });
    });
