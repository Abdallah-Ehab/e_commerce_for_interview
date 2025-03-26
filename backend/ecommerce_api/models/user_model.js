const mongoose = require("mongoose")
const bcrypt = require("bcrypt")


const userSchema = mongoose.Schema({
    username:{
        "type":String,
        "required":true
    },
    email:{
        "type":String,
        "required":true,
        "unique":true
    },
    password:{
        "type":String,
        "required":true
    },
    isAdmin:{
        "type": Boolean,
        "required":true
    }
})

userSchema.pre("save",async function(next){
    const salt = await bcrypt.genSaltSync(10);
    this.password = await bcrypt.hashSync(this.password, salt);
    next();
})

userSchema.methods.isPasswordMatched= async function(enteredPassword){
    return await bcrypt.compare(enteredPassword,this.password)
}

const UserModel = new mongoose.model("User",userSchema)

module.exports = UserModel


