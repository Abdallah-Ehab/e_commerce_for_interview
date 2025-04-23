const jwt = require("jsonwebtoken")
const User = require("../models/auth_models/user_model")
const asyncHandler = require("../config/async_handler")

const verifyTokenMiddleware = asyncHandler(async(req,res,next)=>{
    let token;
    if(req?.headers?.authorization?.startsWith("Bearer")){
        token = req?.headers?.authorization.split(" ")[1]
        if(token){
            try{
                const decoded = jwt.verify(token,process.env.SECRET)
                const user = await User.findById(decoded.id)
                req.user = user
                next()
            }catch(e){
               next(e)
            }
            console.log(decoded)
            
        }else{
            next(new Error("no tokens found"))
        }
    }else{
        next(new Error("user not authorized"))
    }
    
})

const verifyIsAdminMiddleware = asyncHandler(async(req,res,next)=>{
    const {isAdmin} = req.user
    if(isAdmin){
        next()
    }else{
        next(new Error("you are not admin"))
    }
})

module.exports = {verifyTokenMiddleware,verifyIsAdminMiddleware}