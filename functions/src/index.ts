import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {words, wordsLength} from "./words";

admin.initializeApp();

exports.setWordForNextDay = functions.pubsub
    .schedule("every day 23:59")
    .timeZone("Europe/Paris")
    .onRun(async () => {
      const word = await getWord();
      const day = getNextDay();
      admin.firestore()
          .collection("words")
          .doc()
          .set({word, day});
      return null;
    });

exports.getWord = functions.https.onCall(async () => {
  const docs = await admin.firestore()
      .collection("words")
      .where("day", "==", getToday())
      .get();
  return docs.docs.map((d) => d.get("word"))[0];
});

exports.getAcceptableWords = functions.https.onCall(async () => {
  const docs = await admin.firestore()
      .collection("words")
      .where("day", "==", getToday())
      .get();
  const todayWord = docs.docs.map((d) => d.get("word"))[0];
  return words.filter(
      (w) => w.charAt(0) === todayWord.charAt(0) &&
      w.length === todayWord.length
  );
});

const getWord = async () => {
  const lastMonthWords: string[] = (
    await admin.firestore()
        .collection("words")
        .orderBy("day")
        .limitToLast(30)
        .get()
  ).docs.map((d) => d.get("word"));
  let word;
  do {
    word = words[Math.floor(Math.random() * wordsLength)];
  } while (lastMonthWords.includes(word));
  return word;
};

const getToday = (): string => {
  return new Date().toISOString().split("T")[0];
};

const getNextDay = (): string => {
  const today = new Date();
  const tomorrow = new Date(today.getTime() + 24 * 60 * 60 * 1000);
  return tomorrow.toISOString().split("T")[0];
};
