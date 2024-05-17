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

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
const iso6391 = require("iso-639-1");

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
            const HomeTeamScore = 0;
            const AwayTeamScore = 0;
            const HomeTeamCode = iso6391.getCode(
                match.HomeTeam.trim());
            const AwayTeamCode = iso6391.getCode(
                match.AwayTeam.trim());

            match.DateUtc = getFirestoreTimestamp(match.DateUtc);


            // Add initial scores to match data
            match.HomeTeamScore = HomeTeamScore;
            match.AwayTeamScore = AwayTeamScore;
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


function getFirestoreTimestamp(dateString) {
    const date = new Date(dateString);
    return admin.firestore.Timestamp.fromDate(date);
}
