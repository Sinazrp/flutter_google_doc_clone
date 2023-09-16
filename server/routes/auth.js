const express = require('express');
const User = require('../model/user');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, profilePic } = req.body;
        let user = await User.findOne({ email: email });
        if (!user) {
            user = new User({
                name,
                email,
                profilePic
            });
            user = await user.save();
        }

        const token = jwt.sign({ id: user._id }, "passwordKey")
        res.status(200).json({ user, token });
    }
    catch (error) {
        res.status(500).json({ error });
    }

}
);

authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.userId);
    res.status(200).json({ user, token: req.token });
});


module.exports = authRouter;