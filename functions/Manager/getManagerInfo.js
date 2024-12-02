
const db = require('../utils/firebaseAdmin');

const getManagerInfo = async (req, res) => {
    try {

        const managerDocRef = db
            .collection('Users')
            .doc('Staff')
            .collection('Managers')
            .doc('Ahsan');

        const documents = await managerDocRef.get();

        if (documents.exists) {
            res.status(200).json(documents.data());
        } else {
            res.status(404).send('Manager not found');
        }

    } catch (error) {
        res.status(500).send(error);
    }
}
module.exports = getManagerInfo;