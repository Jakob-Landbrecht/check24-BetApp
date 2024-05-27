/* eslint-disable max-len */
/* eslint-disable no-unused-vars */
/* eslint-disable comma-dangle */
/* eslint-disable require-jsdoc */
/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const {functions} = require("firebase-functions/v2");
const {onSchedule} = require("firebase-functions/v2/scheduler");
const {faker} = require("@faker-js/faker");
// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
const iso6391 = require("iso-639-1");
const cors = require("cors")({origin: true});


const {onDocumentCreated,
       onDocumentUpdated,
       onDocumentDeleted,
       Change,
       FirestoreEvent} = require("firebase-functions/v2/firestore");


// The Firebase Admin SDK to access Firestore.
admin.initializeApp();


exports.importGames = onRequest(async (request, response) => {
    try {
        const matches = [
            {
                "MatchNumber": 1,
                "RoundNumber": 1,
                "DateUtc": "2024-06-14 19:00:00Z",
                "Location": "Fußball Arena München",
                "HomeTeam": "Germany",
                "AwayTeam": "Scotland",
                "Group": "Group A",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 2,
                "RoundNumber": 1,
                "DateUtc": "2024-06-15 13:00:00Z",
                "Location": "Stadion Köln",
                "HomeTeam": "Hungary",
                "AwayTeam": "Switzerland",
                "Group": "Group A",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 3,
                "RoundNumber": 1,
                "DateUtc": "2024-06-15 16:00:00Z",
                "Location": "Olympiastadion",
                "HomeTeam": "Spain",
                "AwayTeam": "Croatia",
                "Group": "Group B",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 4,
                "RoundNumber": 1,
                "DateUtc": "2024-06-15 19:00:00Z",
                "Location": "BVB Stadion Dortmund",
                "HomeTeam": "Italy",
                "AwayTeam": "Albania",
                "Group": "Group B",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 5,
                "RoundNumber": 1,
                "DateUtc": "2024-06-16 13:00:00Z",
                "Location": "Volksparkstadion",
                "HomeTeam": "Poland",
                "AwayTeam": "Netherlands",
                "Group": "Group D",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 6,
                "RoundNumber": 1,
                "DateUtc": "2024-06-16 16:00:00Z",
                "Location": "Arena Stuttgart",
                "HomeTeam": "Slovenia",
                "AwayTeam": "Denmark",
                "Group": "Group C",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 7,
                "RoundNumber": 1,
                "DateUtc": "2024-06-16 19:00:00Z",
                "Location": "Arena AufSchalke",
                "HomeTeam": "Serbia",
                "AwayTeam": "England",
                "Group": "Group C",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 8,
                "RoundNumber": 1,
                "DateUtc": "2024-06-17 13:00:00Z",
                "Location": "Fußball Arena München",
                "HomeTeam": "Romania",
                "AwayTeam": "Ukraine",
                "Group": "Group E",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 9,
                "RoundNumber": 1,
                "DateUtc": "2024-06-17 16:00:00Z",
                "Location": "Frankfurt Stadion",
                "HomeTeam": "Belgium",
                "AwayTeam": "Slovakia",
                "Group": "Group E",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 10,
                "RoundNumber": 1,
                "DateUtc": "2024-06-17 19:00:00Z",
                "Location": "Düsseldorf Arena",
                "HomeTeam": "Austria",
                "AwayTeam": "France",
                "Group": "Group D",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 11,
                "RoundNumber": 1,
                "DateUtc": "2024-06-18 16:00:00Z",
                "Location": "BVB Stadion Dortmund",
                "HomeTeam": "Türkiye",
                "AwayTeam": "Georgia",
                "Group": "Group F",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 12,
                "RoundNumber": 1,
                "DateUtc": "2024-06-18 19:00:00Z",
                "Location": "RB Arena",
                "HomeTeam": "Portugal",
                "AwayTeam": "Czechia",
                "Group": "Group F",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 13,
                "RoundNumber": 2,
                "DateUtc": "2024-06-19 13:00:00Z",
                "Location": "Volksparkstadion",
                "HomeTeam": "Croatia",
                "AwayTeam": "Albania",
                "Group": "Group B",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 14,
                "RoundNumber": 2,
                "DateUtc": "2024-06-19 16:00:00Z",
                "Location": "Arena Stuttgart",
                "HomeTeam": "Germany",
                "AwayTeam": "Hungary",
                "Group": "Group A",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 15,
                "RoundNumber": 2,
                "DateUtc": "2024-06-19 19:00:00Z",
                "Location": "Stadion Köln",
                "HomeTeam": "Scotland",
                "AwayTeam": "Switzerland",
                "Group": "Group A",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 16,
                "RoundNumber": 2,
                "DateUtc": "2024-06-20 13:00:00Z",
                "Location": "Fußball Arena München",
                "HomeTeam": "Slovenia",
                "AwayTeam": "Serbia",
                "Group": "Group C",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 17,
                "RoundNumber": 2,
                "DateUtc": "2024-06-20 16:00:00Z",
                "Location": "Frankfurt Stadion",
                "HomeTeam": "Denmark",
                "AwayTeam": "England",
                "Group": "Group C",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 18,
                "RoundNumber": 2,
                "DateUtc": "2024-06-20 19:00:00Z",
                "Location": "Arena AufSchalke",
                "HomeTeam": "Spain",
                "AwayTeam": "Italy",
                "Group": "Group B",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 19,
                "RoundNumber": 2,
                "DateUtc": "2024-06-21 13:00:00Z",
                "Location": "Düsseldorf Arena",
                "HomeTeam": "Slovakia",
                "AwayTeam": "Ukraine",
                "Group": "Group E",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 20,
                "RoundNumber": 2,
                "DateUtc": "2024-06-21 16:00:00Z",
                "Location": "Olympiastadion",
                "HomeTeam": "Poland",
                "AwayTeam": "Austria",
                "Group": "Group D",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 21,
                "RoundNumber": 2,
                "DateUtc": "2024-06-21 19:00:00Z",
                "Location": "RB Arena",
                "HomeTeam": "Netherlands",
                "AwayTeam": "France",
                "Group": "Group D",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 22,
                "RoundNumber": 2,
                "DateUtc": "2024-06-22 13:00:00Z",
                "Location": "Volksparkstadion",
                "HomeTeam": "Georgia",
                "AwayTeam": "Czechia",
                "Group": "Group F",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 23,
                "RoundNumber": 2,
                "DateUtc": "2024-06-22 16:00:00Z",
                "Location": "BVB Stadion Dortmund",
                "HomeTeam": "Türkiye",
                "AwayTeam": "Portugal",
                "Group": "Group F",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 24,
                "RoundNumber": 2,
                "DateUtc": "2024-06-22 19:00:00Z",
                "Location": "Stadion Köln",
                "HomeTeam": "Belgium",
                "AwayTeam": "Romania",
                "Group": "Group E",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 25,
                "RoundNumber": 3,
                "DateUtc": "2024-06-23 19:00:00Z",
                "Location": "Frankfurt Stadion",
                "HomeTeam": "Switzerland",
                "AwayTeam": "Germany",
                "Group": "Group A",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 26,
                "RoundNumber": 3,
                "DateUtc": "2024-06-23 19:00:00Z",
                "Location": "Arena Stuttgart",
                "HomeTeam": "Scotland",
                "AwayTeam": "Hungary",
                "Group": "Group A",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 27,
                "RoundNumber": 3,
                "DateUtc": "2024-06-24 19:00:00Z",
                "Location": "Düsseldorf Arena",
                "HomeTeam": "Albania",
                "AwayTeam": "Spain",
                "Group": "Group B",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 28,
                "RoundNumber": 3,
                "DateUtc": "2024-06-24 19:00:00Z",
                "Location": "RB Arena",
                "HomeTeam": "Croatia",
                "AwayTeam": "Italy",
                "Group": "Group B",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 29,
                "RoundNumber": 3,
                "DateUtc": "2024-06-25 16:00:00Z",
                "Location": "Olympiastadion",
                "HomeTeam": "Netherlands",
                "AwayTeam": "Austria",
                "Group": "Group D",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 30,
                "RoundNumber": 3,
                "DateUtc": "2024-06-25 16:00:00Z",
                "Location": "BVB Stadion Dortmund",
                "HomeTeam": "France",
                "AwayTeam": "Poland",
                "Group": "Group D",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 31,
                "RoundNumber": 3,
                "DateUtc": "2024-06-25 19:00:00Z",
                "Location": "Stadion Köln",
                "HomeTeam": "England",
                "AwayTeam": "Slovenia",
                "Group": "Group C",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 32,
                "RoundNumber": 3,
                "DateUtc": "2024-06-25 19:00:00Z",
                "Location": "Fußball Arena München",
                "HomeTeam": "Denmark",
                "AwayTeam": "Serbia",
                "Group": "Group C",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 33,
                "RoundNumber": 3,
                "DateUtc": "2024-06-26 16:00:00Z",
                "Location": "Frankfurt Stadion",
                "HomeTeam": "Slovakia",
                "AwayTeam": "Romania",
                "Group": "Group E",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 34,
                "RoundNumber": 3,
                "DateUtc": "2024-06-26 16:00:00Z",
                "Location": "Arena Stuttgart",
                "HomeTeam": "Ukraine",
                "AwayTeam": "Belgium",
                "Group": "Group E",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 35,
                "RoundNumber": 3,
                "DateUtc": "2024-06-26 19:00:00Z",
                "Location": "Arena AufSchalke",
                "HomeTeam": "Georgia",
                "AwayTeam": "Portugal",
                "Group": "Group F",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
            {
                "MatchNumber": 36,
                "RoundNumber": 3,
                "DateUtc": "2024-06-26 19:00:00Z",
                "Location": "Volksparkstadion",
                "HomeTeam": "Czechia",
                "AwayTeam": "Türkiye",
                "Group": "Group F",
                "HomeTeamScore": null,
                "AwayTeamScore": null
            },
        ];

        // Loop through matches and create documents in Firestore
        for (const match of matches) {
            const HomeTeamCode = iso6391.getCode(
                match.HomeTeam);
            const AwayTeamCode = iso6391.getCode(
                match.AwayTeam);

            match.DateUtc = getFirestoreTimestamp(match.DateUtc);

            functions.logger.log("HomeTeamCode:", HomeTeamCode);
            functions.logger.log("AwayTeamCode:", AwayTeamCode);

            match.HomeTeamCode = HomeTeamCode;
            match.AwayTeamCode = AwayTeamCode;

            await admin.firestore().collection("Tournaments")
            .doc("zXbeHbpMG4a5DPb8jgwT")
            .collection("Games").add(match);
        }

        response.status(200).send("Matches imported successfully.");
    } catch (error) {
        console.error("Error importing matches:", error);
        response.status(500).send("Error importing matches: " + error.message);
    }
});

exports.updateScoreRanking = onDocumentUpdated(
    {document: "Tournaments/{tournamentId}/Games/{docId}", region: "europe-west3"},
    async (event) => {
      console.log("Function was called");
      const beforeData = event.data.before.data();
      const afterData = event.data.after.data();
      const tournamentId = event.params.tournamentId;
      const gameId = event.params.docId;

      if (!afterData) {
        console.log("No data associated with the event");
        return;
      }

      try {
        const betsSnapshot = await admin.firestore()
          .collection("Tournaments").doc(tournamentId)
          .collection("Bets").where("gameUid", "==", gameId).get();

        const updatePromises = [];
        for (const doc of betsSnapshot.docs) {
          const betData = doc.data();
          const awayTeamCount = betData.awayTeamCount;
          const homeTeamCount = betData.homeTeamCount;
          const userUid = betData.userUid;

          console.log(userUid);
          const userDoc = await admin.firestore().collection("User").doc(userUid).get();
          const userData = userDoc.data();
          if (!userData) continue;
          const communitiesOfUser = userData[`Communities:${tournamentId}`];
          for (const community of communitiesOfUser) {
            const ref = admin.firestore()
              .collection("Tournaments").doc(tournamentId)
              .collection("Communities").doc(community)
              .collection("Leaderboard").where("userId", "==", userUid);
            const leaderboardEntry = await ref.get();

            let points = 0;
            if (awayTeamCount == afterData.AwayTeamScore && homeTeamCount == afterData.HomeTeamScore) {
              points = 8;
            } else if (((afterData.HomeTeamScore - afterData.AwayTeamScore) == (homeTeamCount - awayTeamCount)) && homeTeamCount != awayTeamCount) {
              points = 6;
            } else if ((homeTeamCount >= awayTeamCount) && (afterData.HomeTeamScore >= afterData.AwayTeamScore)) {
              points = 4;
            } else if ((awayTeamCount >= homeTeamCount) && (afterData.AwayTeamScore >= afterData.HomeTeamScore)) {
              points = 4;
            } else {
              points = 0;
            }

            console.log("Adding Score Points: " + points);

            if (!leaderboardEntry.empty) {
              leaderboardEntry.forEach((entryDoc) => {
                const leaderboardRef = entryDoc.ref;
                updatePromises.push(leaderboardRef.update({scoreTemp: points}));
              });
            }
          }
        }

        await Promise.all(updatePromises);

        await updateRanks(tournamentId);
      } catch (error) {
        console.error("Error in updateScoreRanking function:", error);
        throw new Error("Failed to update score ranking");
      }
    }
  );

  async function updateRanks(tournamentId) {
    try {
      const communitiesSnapshot = await admin.firestore()
        .collection("Tournaments").doc(tournamentId)
        .collection("Communities").get();

      const updatePromises = [];

      for (const communityDoc of communitiesSnapshot.docs) {
        const communityId = communityDoc.id;
        const leaderboardRef = admin.firestore()
          .collection("Tournaments").doc(tournamentId)
          .collection("Communities").doc(communityId)
          .collection("Leaderboard");
        const leaderboardSnapshot = await leaderboardRef.get();

        const leaderboardEntries = [];
        leaderboardSnapshot.forEach((doc) => {
          const data = doc.data();
          const combinedScore = data.score + data.scoreTemp;
          leaderboardEntries.push({id: doc.id, combinedScore});
        });

        leaderboardEntries.sort((a, b) => b.combinedScore - a.combinedScore);

        for (let i = 0; i < leaderboardEntries.length; i++) {
          const entry = leaderboardEntries[i];
          updatePromises.push(leaderboardRef.doc(entry.id).update({rang: i + 1}));
        }
      }

      await Promise.all(updatePromises);
    } catch (error) {
      console.error("Error while updating ranks:", error);
    }
  }


function getFirestoreTimestamp(dateString) {
    const date = new Date(dateString);
    return admin.firestore.Timestamp.fromDate(date);
}

exports.cleanScores = onSchedule("every 6 hours", async (event) => {
        try {
            const tournamentsSnapshot = await admin.firestore().collection("Tournaments").get();

            const updatePromises = [];

            tournamentsSnapshot.forEach(async (tournamentDoc) => {
                const tournamentId = tournamentDoc.id;
                const communitiesSnapshot = await admin.firestore().collection("Tournaments").doc(tournamentId).collection("Communities").get();

                communitiesSnapshot.forEach(async (communityDoc) => {
                    const communityId = communityDoc.id;
                    const leaderboardRef = admin.firestore().collection("Tournaments").doc(tournamentId).collection("Communities").doc(communityId).collection("Leaderboard");
                    const leaderboardSnapshot = await leaderboardRef.get();

                    leaderboardSnapshot.forEach((doc) => {
                        const data = doc.data();
                        const updatedScore = data.score + data.scoreTemp;

                        updatePromises.push(doc.ref.update({
                            score: updatedScore,
                            scoreTemp: 0,
                        }));
                    });
                });
            });

            // Wait for all updates to complete before finishing
            await Promise.all(updatePromises);

            console.log("Leaderboard scores updated successfully");
            return null;
        } catch (error) {
            console.error("Error in updateLeaderboardScores function:", error);
            throw new Error("Failed to update leaderboard scores");
        }
    });

exports.updateValue = onRequest(async (req, res) => {
  try {
    // Extract the 'score' and 'isHomeTeam' parameters from the URL
    const scoreParam = req.query.score;
    const isHomeTeamParam = req.query.isHomeTeam;
    const tournamentId = req.query.tournamentId;

    if (!scoreParam || isHomeTeamParam === undefined || !tournamentId) {
        res.status(400).send("Missing 'score', 'isHomeTeam', or 'tournamentId' parameter");
        return;
      }

    const numberValue = parseInt(scoreParam, 10);
    const isHomeTeamValue = isHomeTeamParam === "true";

    if (isNaN(numberValue)) {
      res.status(400).send("'number' parameter should be a valid number");
      return;
    }

    // get upcoming Game
    const upcomingRef = admin.firestore().collection("Tournaments").doc(tournamentId).collection("Games").orderBy("DateUtc").limit(1);
    const gameSnapshot = await upcomingRef.get();

    gameSnapshot.forEach(async (doc) => {
            // Update Firestore document (example: updating a document in 'collectionName' with ID 'documentId')
    const docRef = admin.firestore().collection("Tournaments").doc(tournamentId).collection("Games").doc(doc.id);
    if (isHomeTeamValue) {
        await docRef.update({
            HomeTeamScore: numberValue,
          });
    } else {
        await docRef.update({
            AwayTeamScore: numberValue,
          });
    }
    });

    res.status(200).send(`Value updated to ${numberValue} and isHomeTeam set to ${isHomeTeamValue}`);
  } catch (error) {
    console.error("Error updating Firestore document:", error);
    res.status(500).send("Internal Server Error");
  }
});


exports.getLeaderboardPreview = onRequest({region: "europe-west3"}, async (req, res) => {
  cors(req, res, async () => {
    // Ensure the request is a POST request
    if (req.method !== "POST") {
      res.status(405).send("Method Not Allowed");
      return;
  }


  // Parse the JSON body
  let communityId;
  let loggedInUserId;
  let tournamentId;
  try {
      const body = JSON.parse(req.body);
      communityId = body.communityId;
      loggedInUserId = body.loggedInUserId;
      tournamentId = body.tournamentId;
  } catch (error) {
      res.status(400).send("Invalid JSON body");
      return;
  }

  if (!communityId || !loggedInUserId || !tournamentId) {
      res.status(400).send("Missing parameters");
      return;
  }

  try {
    const leaderboardRef = admin.firestore()
      .collection("Tournaments").doc(tournamentId)
      .collection("Communities").doc(communityId)
      .collection("Leaderboard");

    // Check the number of documents in the collection
  const countSnapshot = await leaderboardRef.count().get();
  const totalCount = countSnapshot.data().count;
    if (totalCount < 7) {
      const allSnapshot = await leaderboardRef.orderBy("rang").orderBy("registrationDate").get();
      const allEntries = allSnapshot.docs.map((doc) => ({id: doc.id, ...doc.data()}));
      res.status(200).send(allEntries);
      return;
    }

    // Fetch top 3 users
    const top3Snapshot = await leaderboardRef.orderBy("rang").orderBy("registrationDate").limit(3).get();
    const top3Users = top3Snapshot.docs.map((doc) => ({id: doc.id, ...doc.data()}));

    const previewEntries = [...top3Users];

    // Fetch logged-in user
    const currentUserSnapshot = await leaderboardRef.where("userId", "==", loggedInUserId).limit(1).get();
    if (currentUserSnapshot.empty) {
      res.status(404).send("Logged-in user not found in leaderboard");
      return;
    }
    const currentUser = currentUserSnapshot.docs.map((doc) => ({id: doc.id, ...doc.data()}))[0];

    // Fetch user below the logged-in user
    const belowUserSnapshot = await leaderboardRef
      .orderBy("rang")
      .startAfter(currentUser.rang)
      .limit(1)
      .get();
    const belowUser = belowUserSnapshot.empty ? null : belowUserSnapshot.docs.map((doc) => ({id: doc.id, ...doc.data()}))[0];

    // Fetch user above the logged-in user
    const aboveUserSnapshot = await leaderboardRef
      .orderBy("rang")
      .endBefore(currentUser.rang)
      .limitToLast(1)
      .get();
    const aboveUser = aboveUserSnapshot.empty ? null : aboveUserSnapshot.docs.map((doc) => ({id: doc.id, ...doc.data()}))[0];

    if (aboveUser) previewEntries.push(aboveUser);
    previewEntries.push(currentUser);
    if (belowUser) previewEntries.push(belowUser);

    // Add last user
    const lastUserSnapshot = await leaderboardRef.orderBy("rang", "desc").limit(1).get();
    const lastUser = lastUserSnapshot.docs.map((doc) => ({id: doc.id, ...doc.data()}))[0];
    if (!previewEntries.some((entry) => entry.userId === lastUser.userId)) {
      previewEntries.push(lastUser);
    }

    // Remove duplicates and ensure exactly 7 entries
    const uniquePreviewEntries = Array.from(new Set(previewEntries.map((entry) => entry.userId)))
      .map((userId) => previewEntries.find((entry) => entry.userId === userId));

     // If there are less than 7 unique users, add more from the leaderboard
  const additionalUsersSnapshot = await leaderboardRef.orderBy("rang").orderBy("registrationDate").get();
  let i = 0;
  while (uniquePreviewEntries.length < 7 && i < additionalUsersSnapshot.size) {
    const entry = additionalUsersSnapshot.docs[i].data();
    if (!uniquePreviewEntries.some((e) => e.userId === entry.userId)) {
      uniquePreviewEntries.push({id: additionalUsersSnapshot.docs[i].id, ...entry});
    }
    i++;
  }

    res.status(200).send(uniquePreviewEntries.slice(0, 7));
  } catch (error) {
    console.error("Error fetching leaderboard preview:", error);
    res.status(500).send("Internal server error");
  }
  });
  });

exports.isOnlineSynchronizer = onDocumentUpdated(
    {document: "User/{userId}", region: "europe-west3"},
    async (event) => {
        console.log("isOnlineSynchronizer was called");
        const afterData = event.data.after.data();
        const userId = event.params.userId;

        if (!afterData) {
            console.log("No data associated with the event");
            return;
        }
        const isOnline = afterData.isOnline;
        const tournaments = await admin.firestore().collection("Tournaments").get();

        tournaments.forEach(async (doc) => {
           const userCommunities = afterData["Communities:"+doc.id];
           userCommunities.forEach(async (communityId) => {
            const docRef = await admin.firestore().collection("Tournaments").doc(doc.id).collection("Communities").doc(communityId).collection("Leaderboard");
              // Perform the query to get the documents you want to update
            const querySnapshot = await docRef.where("userId", "==", userId).get();

            // Iterate through each document and update it
            const updatePromises = querySnapshot.docs.map((doc) => doc.ref.update({"isOnline": isOnline}));
            await Promise.all(updatePromises);
            console.log("Documents updated successfully.");
           });
        });
    });

exports.createFakeUsers = onRequest({region: "europe-west3"}, async (req, res) => {
    try {
        const amount = req.query.amount;
        if (!amount || amount == 0) {
            res.status(400).send("Missing 'amount' parameter");
            return;
        }
        if (amount > 100) {
            res.status(400).send("You can only create a maximum of 100 players at a time");
            return;
        }
        const db = admin.firestore();
        const batch = db.batch();

        for (let i = 1; i <= amount; i++) {
            const userId = faker.string.alphanumeric(28);
            const isOnline = faker.datatype.boolean();
            const registrationDate = faker.date.recent();
            const username = faker.internet.userName();

            const docRef = db.collection("User").doc(userId);
            batch.set(docRef, {
                "username": username,
                "score": 0,
                "midnightScore": 0,
                "isOnline": isOnline,
                "registrationDate": registrationDate,
                "Communities:zXbeHbpMG4a5DPb8jgwT": ["global"],
            });
            const leaderBoardRef = db
            .collection("Tournaments")
            .doc("zXbeHbpMG4a5DPb8jgwT")
            .collection("Communities")
            .doc("global")
            .collection("Leaderboard");

            const snapshot = await leaderBoardRef.count().get();
            const number = snapshot.data().count;


            batch.set(leaderBoardRef.doc(), {
                "username": username,
                "score": 0,
                "scoreTemp": 0,
                "isOnline": isOnline,
                "registrationDate": registrationDate,
                "userId": userId,
                "rang": number+i,
            });

            const gameRef = db.collection("Tournaments").doc("zXbeHbpMG4a5DPb8jgwT").collection("Games");
            const games = await gameRef.get();
            games.forEach(async (doc) => {
                const gameId = doc.id;
                const betRef = db.collection("Tournaments").doc("zXbeHbpMG4a5DPb8jgwT").collection("Bets").doc();
                batch.set(betRef, {
                    "awayTeamCount": faker.number.int(10),
                    "homeTeamCount": faker.number.int(10),
                    "gameUid": gameId,
                    "userUid": userId,
                });
            });
        }
        await batch.commit();


        return res.status(200).send("Fakse users safed to database");
    } catch (error) {
        console.error("Error updating Firestore document:", error);
        res.status(500).send("Internal Server Error");
    }
});
