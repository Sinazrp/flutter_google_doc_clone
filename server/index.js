const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const Document = require('./model/document');

const authRouter = require('./routes/auth');
const documentRouter = require('./routes/document');

const PORT = process.env.PORT || 3001;

const DB = "mongodb://root:Wkumle3XWuZSxgfIolzS3Eup@aberama.iran.liara.ir:32074/my-app?authSource=admin&authMechanism=SCRAM-SHA-256";



const { createServer } = require('node:http');
const { Server } = require('socket.io');

const app = express();
const server = createServer(app);
const io = new Server(server);



io.on('connection', (socket) => {
    console.log('a user connected');
    socket.on('join', (documentId) => {
        socket.join(documentId);
        console.log("io joind on document : " + documentId);
    });
    socket.on('typing', (data) => socket.broadcast.to(data.room).emit('changes', data));

    socket.on('save', (data) => {
        saveData(data);
        io.to()

    });
    const saveData = async (data) => {
        let document = await Document.findById(data.docId);
        document.content = data.delta;
        document = await document.save();
    }

});



app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(documentRouter);
app.use(authRouter);



mongoose.connect(DB).then(() => { console.log("DB Connected"); }).catch((err) => { console.log(err); });




server.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);

});

