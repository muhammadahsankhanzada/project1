const db = require('../utils/firebaseAdmin');

const getSalesmanRecordsDetails = async (req, res) => {
    const salesmanName = 'Muhammad Ahsan';
    try {
        const salesmanDetailsRef = db.collection('Users')
            .doc('Staff')
            .collection('Salesmen').doc(salesmanName);

        const snapshot = await salesmanDetailsRef.get();

        if (snapshot.exists) {
            salesmanDetails = snapshot.data();

            const tripsRef = salesmanDetailsRef.collection('Trips');
            const tripsSnapshot = await tripsRef.get();

            const trips = tripsSnapshot.docs.map(doc => ({
                id: doc.id,
                ...doc.data(),
            }));
            res.status(200).json({
                salesmanDetails: salesmanDetails,
                trips: trips
            });
        } else {
            res.status(404).send('No records found');
        }
        // const salesmanDetailsRef = db.collection('Users')
        //     .doc('Staff')
        //     .collection('Salesmen').doc(salesmanName);

        // const snapshot = await salesmanDetailsRef.get();

        // if (snapshot.exists) {

        //     const salesmanDetails = snapshot.data();
        //     res.status(200).json(salesmanDetails);
        // } else {
        //     res.status(404).send('No records found');
        // }
    } catch (error) {
        res.status(500).send(error);
    }
}

module.exports = getSalesmanRecordsDetails;