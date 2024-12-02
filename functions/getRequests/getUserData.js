
const db = require('../utils/firebaseAdmin');

const getUserData = async (req, res) => {
    // const collectionName = req.params.collectionName;
    const collectionName = 'Users';
    try {
        const snapshot = await db.collection(collectionName).get();
        if (snapshot.empty) {
            res.status(404).send('No collection found');
            return;
        }
        const data = snapshot.docs.map(doc => doc.data());
        res.status(200).json(data);
    } catch (error) {
        res.status(500).send('Error fetching data: ' + error);
    }
};

module.exports = getUserData; 
