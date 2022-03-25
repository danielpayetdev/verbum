import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { words, wordsLength } from './words';

admin.initializeApp();

exports.getWordForNextDay = functions.pubsub
    .schedule("every day 23:59")
    .timeZone("Europe/Paris")
    .onRun(() => {
      const word = words[Math.floor(Math.random()*wordsLength)];
      admin.firestore()
          .collection("words")
          .doc(getNextDay())
          .set({word});
      console.log(`Word "${word}" added`);
      return null;
    });

const getNextDay = (): string => {
  const today = new Date();
  const tomorrow = new Date(today.getTime() + 24 * 60 * 60 * 1000);
  return tomorrow.toISOString().split("T")[0];
};
