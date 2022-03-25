import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

exports.getWordForNextDay = functions.pubsub
    .schedule("every day 23:59")
    .timeZone("Europe/Paris")
    .onRun(() => {
      const word = "trololo";
      admin.firestore().collection("/word").doc(word).set({word});
      return null;
    });
