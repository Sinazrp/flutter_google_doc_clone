const express = require('express');
const documentRouter = express.Router();
const Document = require('../model/document');
const auth = require('../middleware/auth');

// Route to get all documents
documentRouter.get('/doc/me', auth, async (req, res) => {
    try {
        const documents = await Document.find({ userId: req.userId });
        res.json(documents);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// Route to create a new document
documentRouter.post('/doc/create', auth, async (req, res) => {



    try {
        const { createdAt } = req.body;
        let document = new Document({
            userId: req.userId,
            title: 'Untitled Document',
            createdAt: createdAt,
            content: [],
        });

        const newDocument = await document.save();
        res.json(newDocument);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

documentRouter.post("/doc/title", auth, async (req, res) => {
    try {

        const { id, title } = req.body;
        const document = await Document.findByIdAndUpdate(id, { title });
        res.json(document);


    } catch (error) {
        res.status(500).json({ error: error.message })

    }
})
module.exports = documentRouter;