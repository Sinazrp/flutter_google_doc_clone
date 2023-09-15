const express = require('express');
const User = require('../model/user');
const jwt = require('jsonwebtoken');

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

            res.status(201).json({ user });

        }
        if (user) {
            res.status(200).json({ user })

        }
    }
    catch (error) {
        res.status(500).json({ error });
    }

}
);
module.exports = authRouter;