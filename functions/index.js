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
// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
const iso6391 = require("iso-639-1");

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
        const beforeData = event.data.before;
        const afterData = event.data.after.data();
        const tournamentId = event.params.tournamentId;
        const gameId = event.params.docId;

        if (!afterData) {
            console.log("No data associated with the event");
            return;
        }

        try {
            const getAllAffectedBets = await admin.firestore().collection("Tournaments").doc(tournamentId).collection("Bets").where("gameUid", "==", gameId).get();

            const updatePromises = [];
        getAllAffectedBets.forEach(async (doc) => {
            const awayTeamCount = doc.data().awayTeamCount;
            const homeTeamCount = doc.data().homeTeamCount;
            const userUid = doc.data().userUid;

            console.log(userUid);
            const userDoc = await admin.firestore().collection("User").doc(userUid).get();
            console.log(userDoc.data());
            const communitiesOfUser = userDoc.data()["Communities:"+tournamentId];
            for (const community of communitiesOfUser) {
                const ref = admin.firestore().collection("Tournaments").doc(tournamentId).collection("Communities").doc(community).collection("Leaderboard").where("userId", "==", userUid);
                const leaderboardEntry = (await ref.get());


                console.log(afterData.AwayTeamScore);
                console.log(afterData.HomeTeamScore);
                let points = 0;
                // Betting Algo
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

                console.log("Adding Score Points: "+ points);

                // Assuming leaderboardEntry contains one document per user
                if (!leaderboardEntry.empty) {
                    leaderboardEntry.forEach((entryDoc) => {
                        const leaderboardRef = entryDoc.ref;
                        updatePromises.push(leaderboardRef.update({scoreTemp: points}));
                    });
                }
            }
        });
         // Wait for all updates to complete before proceeding
         await Promise.all(updatePromises);
        // Update the Ranks
        await updateRanks(tournamentId);
        } catch (error) {
            console.error("Error in updateScoreRanking function:", error);
            throw new Error("Failed to update score ranking");
        }
    });

async function updateRanks(tournamentId) {
    try {
        const communitiesSnapshot = await admin.firestore().collection("Tournaments").doc(tournamentId).collection("Communities").get();
        const updatePromises = [];

        communitiesSnapshot.forEach(async (communityDoc) => {
            const communityId = communityDoc.id;
            const leaderboardRef = admin.firestore().collection("Tournaments").doc(tournamentId).collection("Communities").doc(communityId).collection("Leaderboard");
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
        });
        await Promise.all(updatePromises);
    } catch (error) {
        console.error("Error while updating rank");
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
