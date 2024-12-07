
const db = require('../utils/firebaseAdmin');

const getSalesmanInfo = async (req, res) => {
    const salesmanName = req.query.salesmanName;
    try {

        const salesmanRef = db
            .collection('Users')
            .doc('Staff')
            .collection('Salesmen')
            .doc(salesmanName);

        const documents = await salesmanRef.get();

        if (documents.exists) {
            res.status(200).json(documents.data());
        } else {
            res.status(404).send('Salesman data not found');
        }

    } catch (error) {
        res.status(500).send(error);
    }
}
module.exports = getSalesmanInfo;