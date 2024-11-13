
// Old code for version 1
// Initializing firebase functions inside index.js
// const functions = require("firebase-functions");

// // Request methods
// const getUserData = require('./getRequests/getUserData');
// const postUserData = require('./postRequests/postUserData');
// const updateUserData = require('./putRequests/updateUserData');
// const deleteUserData = require('./deleteRequests/deleteUserData');

// // Defining cloud functions for each http method
// exports.getUserData = functions.https.onRequest(getUserData);
// exports.postUserData = functions.https.onRequest(postUserData);
// exports.updateUserData = functions.https.onRequest(updateUserData);
// exports.deleteUserData = functions.https.onRequest(deleteUserData);


// New code for version 2
// Initializing firebase functions inside index.js
const { onRequest } = require("firebase-functions/v2/https");

// Request methods
const getUserData = require('./getRequests/getUserData');
const postUserData = require('./postRequests/postUserData');
const updateUserData = require('./putRequests/updateUserData');
const deleteUserData = require('./deleteRequests/deleteUserData');

// Defining cloud functions for each http method
exports.getUserData = onRequest(getUserData);
exports.postUserData = onRequest(postUserData);
exports.updateUserData = onRequest(updateUserData);
exports.deleteUserData = onRequest(deleteUserData);




/////////////////////////////////////////////////////////


/**
 * Boiler plate code
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");  // uncomment it
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");  // uncomment it
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });