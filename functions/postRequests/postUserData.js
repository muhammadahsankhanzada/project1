
const db = require('../utils/firebaseAdmin');

const postUserData = async (req, res) => {
    const { collectionName, newData } = req.body;
    try {
        const docRef = await db.collection(collectionName).add(newData);
        res.status(200).send(`Document created with ID: ${docRef.id}`);
    } catch (error) {
        res.status(500).send('Error creating document');
    }
};

module.exports = postUserData;  
