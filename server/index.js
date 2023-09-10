const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');

const PORT = process.env.PORT || 3001;

const DB = "mongodb://root:Wkumle3XWuZSxgfIolzS3Eup@aberama.iran.liara.ir:32074/my-app?authSource=admin&authMechanism=SCRAM-SHA-256";
mongoose.connect(DB).then(() => { console.log("DB Connected"); }).catch((err) => { console.log(err); })




const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(authRouter);


app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);

});

