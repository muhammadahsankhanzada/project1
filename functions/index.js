
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

// Example url
// http://localhost:5001/project1-4ee2b/us-central1/getUserData


// Manager methods
const getManagerInfo = require('./Manager/getManagerInfo');
exports.getManagerInfo = onRequest(getManagerInfo);

const getManagerPendingRequestsList = require('./Manager/getManagerPendingRequestsList');
exports.getManagerPendingRequestsList = onRequest(getManagerPendingRequestsList);

const getManagerPendingRequestDetails = require('./Manager/getManagerPendingRequestDetails');
exports.getManagerPendingRequestDetails = onRequest(getManagerPendingRequestDetails);

const getManagerApprovedRequestsList = require('./Manager/getManagerApprovedRequestsList');
exports.getManagerApprovedRequestsList = onRequest(getManagerApprovedRequestsList);

const getManagerApprovedRequestDetails = require('./Manager/getManagerApprovedRequestDetails');
exports.getManagerApprovedRequestDetails = onRequest(getManagerApprovedRequestDetails);

const getSalesmanRecords = require('./General/getSalesmanRecords');
exports.getSalesmanRecords = onRequest(getSalesmanRecords);

const getSalesmanRecordsDetails = require('./General/getSalesmanRecordsDetails');
exports.getSalesmanRecordsDetails = onRequest(getSalesmanRecordsDetails);

const getInventory = require('./General/getInventory');
exports.getInventory = onRequest(getInventory);

const getInventoryNewItems = require('./General/getInventoryNewItems');
exports.getInventoryNewItems = onRequest(getInventoryNewItems);

const getInventoryReturnItems = require('./General/getInventoryReturnItems');
exports.getInventoryReturnItems = onRequest(getInventoryReturnItems);

const getWarehousesList = require('./General/getWarehousesList');
exports.getWarehousesList = onRequest(getWarehousesList);

const getCategoriesList = require('./General/getCategoriesList');
exports.getCategoriesList = onRequest(getCategoriesList);

const getProductsList = require('./General/getProductsList');
exports.getProductsList = onRequest(getProductsList);

const getProductsWithData = require('./General/getProductsWithData');
exports.getProductsWithData = onRequest(getProductsWithData);

const getSalesmanInfo = require('./Salesman/getSalesmanInfo');
exports.getSalesmanInfo = onRequest(getSalesmanInfo);

const getSalesmanTripsList = require('./General/getSalesmanTripsList');
exports.getSalesmanTripsList = onRequest(getSalesmanTripsList);

const postAddProduct = require('./General/postAddProduct');
exports.postAddProduct = onRequest(postAddProduct);

const postDeleteProduct = require('./General/postDeleteProduct');
exports.postDeleteProduct = onRequest(postDeleteProduct);

const assignProductsToSalesman = require('./postRequests/assignProductsToSalesman');
exports.assignProductsToSalesman = onRequest(assignProductsToSalesman);


// Request methods
// const getUserData = require('./getRequests/getUserData');
// const postUserData = require('./postRequests/postUserData');
// const updateUserData = require('./putRequests/updateUserData');
// const deleteUserData = require('./deleteRequests/deleteUserData');

// Defining cloud functions for each http method
// exports.getUserData = onRequest(getUserData);
// exports.postUserData = onRequest(postUserData);
// exports.updateUserData = onRequest(updateUserData);
// exports.deleteUserData = onRequest(deleteUserData);




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