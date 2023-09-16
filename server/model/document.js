const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const DocumentSchema = new Schema({
    userId: {
        type: String,
        required: true,
        ref: 'User'
    },
    createdAt: {
        required: true,
        type: Number,
    },
    title: {
        type: String,
        required: true,
        trim: true,
    },
    content: {
        type: Array,
        default: []
    }
});

const Document = mongoose.model('Document', DocumentSchema);

module.exports = Document;