const jwt = require("jsonwebtoken")

const generateToken=(id,expiresIn)=>{
    return jwt.sign({id},process.env.SECRET,{expiresIn})
}

module.exports = generateToken