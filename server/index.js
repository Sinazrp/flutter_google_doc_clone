const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const http = require('http');
const authRouter = require('./routes/auth');
const documentRouter = require('./routes/document');

const PORT = process.env.PORT || 3001;

const DB = "mongodb://root:Wkumle3XWuZSxgfIolzS3Eup@aberama.iran.liara.ir:32074/my-app?authSource=admin&authMechanism=SCRAM-SHA-256";





const app = express();
var server = http.createServer(app);
/* var socket = require('socket.io');
var io = socket(server); */
// shorter way
var io = require('socket.io')(server);

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(documentRouter);
app.use(authRouter);



mongoose.connect(DB).then(() => { console.log("DB Connected"); }).catch((err) => { console.log(err); });

io.on('connection', (socket) => {
    socket.on('join', (data) => {
        socket.join(data);
        console.log(`io joind on document ${data}`);


    })

})


server.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);

});

