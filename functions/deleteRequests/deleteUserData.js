
const db = require('../utils/firebaseAdmin');

const deleteUserData = async (req, res) => {
    const { collectionName, docId } = req.params;
    try {
        const docRef = db.collection(collectionName).doc(docId);
        await docRef.delete();
        res.status(200).send('Document deleted successfully');
    } catch (error) {
        res.status(500).send('Error deleting document');
    }
};

module.exports = deleteUserData; 
