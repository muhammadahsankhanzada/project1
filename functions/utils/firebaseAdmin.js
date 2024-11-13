// Importing firebase admin sdk
const admin = require('firebase-admin');

// Checking if admin sdk is already initialized or not
if (!admin.apps.length) {
    // Initializing admin sdk if not initialized
    admin.initializeApp();
}
// Getting reference of firestore
const db = admin.firestore();

// Exporting firestore refrence so other files can use it
module.exports = db;