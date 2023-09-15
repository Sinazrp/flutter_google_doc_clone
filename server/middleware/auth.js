const auth = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token")
        if (!token) {
            return res.status(401).json({ msg: "no token , access denied" })

        }
        const verified = jwt.verify(token, passwordKey);
        if (!verified) {
            return res.status(401).json({ msg: "token not valid" })

        }
        req.userId = verified.id;
        req.token = verified.token;

    } catch (error) {

    }
}