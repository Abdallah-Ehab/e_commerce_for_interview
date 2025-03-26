const jwt = require("jsonwebtoken")
const User = require("../models/user_model")
const asyncHandler = require("../config/async_handler")

const verifyTokenMiddleware = asyncHandler(async(req,res,next)=>{
    let token;
    if(req?.headers?.authorization?.startsWith("Bearer")){
        token = req?.headers?.authorization.split(" ")[1]
        if(token){
            const decoded = jwt.verify(token,process.env.SECRET)
            console.log(decoded)
            const user = await User.findById(decoded.id)
            req.user = user
            next()
        }else{
            throw new Error("no tokens found")
        }
    }else{
        throw new Error("user not authorized")
    }
    
})

const verifyIsAdminMiddleware = asyncHandler(async(req,res,next)=>{
    const {isAdmin} = req.user
    if(isAdmin){
        next()
    }else{
        throw new Error("you are not admin")
    }
})

module.exports = {verifyTokenMiddleware,verifyIsAdminMiddleware}