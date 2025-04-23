
const { default: mongoose } = require("mongoose");

const refresh_token_schema = mongoose.Schema({
    userId:{
    "type":mongoose.Schema.Types.ObjectId,
    "ref": "User"
    },
    token:{
        "type":String,
        "required":true
    },
    expiresIn:{
        "type":Date,
        "required":true
    }
})

const RefreshToken = new mongoose.model("RefreshToken",refresh_token_schema)


module.exports = RefreshToken;