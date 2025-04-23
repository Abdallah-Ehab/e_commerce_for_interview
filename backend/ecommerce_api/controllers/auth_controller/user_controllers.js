const User = require("../../models/auth_models/user_model")
const asyncHandler = require("../../config/async_handler")
const generateToken = require("../../config/generatetoken")
const RefreshToken = require('../../models/auth_models/refresh_token_model')

exports.registerUser = asyncHandler(async(req,res,next)=>{
    const {email} = req.body 
    const findUser = await User.findOne({email})
    if(findUser){
        res.status(409).json({
            status:"failed",
            message:"user already exists"
        })
    }else{
        const newUser = await User.create(req.body)
        
        res.status(201).json({
            status:"success",
            user :newUser
        })
    }
})

exports.loginUser = asyncHandler(async(req,res,next)=>{
    const {email,password} = req.body
    const findUser = await User.findOne({email})
    
    if(findUser != null){
        const passwordMatched = await findUser.isPasswordMatched(password)
        if(passwordMatched){
            const access_token = generateToken(findUser.id,"15m")
            const refreshtoken = generateToken(findUser.id,"7d")
            createRefreshToken(findUser.id,refreshtoken)
            res.status(200).json({
                status:"success",
                user: findUser,
                access_token: access_token,
                refresh_token: refreshtoken
            })
        }else{
            return res.status(401).json({
                status: "failed",
                message : "unauthorized request"
            })
        }
    }
    else{
        return res.status(401).json(
            {
                status:"failed",
                message: "user is not signed up"
            }
        )
    }
})


exports.getUsers= asyncHandler(async(req,res,next)=>{
    const users = await User.find()
    if(users){
        res.status(200).json({
            status:"success",
            count:users.length,
            users
        })
    }else{
        throw new Error("users not found")
    }
})

exports.editUser = asyncHandler(async(req,res,next)=>{
        const {_id} = req.user
        const user = await UserModel.findById(_id);
        if (!user) {
            return res.status(404).json({ status: "failed", message: "User not found" });
        }

        if (req.body.hasOwnProperty("username")) user.username = req.body.username;
        if (req.body.hasOwnProperty("email")) user.email = req.body.email;
        if (req.body.hasOwnProperty("password")) user.password = req.body.password;
        if (req.body.hasOwnProperty("isAdmin")) user.isAdmin = req.body.isAdmin;


        await user.save();

        res.status(200).json({
            status: "success",
            user: user
        });
    } 
)

exports.deleteUser = asyncHandler(async(req,res,next)=>{
    const {_id} = req.user
    const deletedUser = User.findByIdAndDelete(_id,{new:true})
    res.status(204).json({
        status:"success",
        user : null
    })
})

exports.refresh_token = asyncHandler(async(req,res,next)=>{
    const {refresh_token} = req.body
    if(!refresh_token){
        return res.status(403).json({message: "Invalid refresh token"})
    }
    const tokenDoc = await RefreshToken.findOne({token: refresh_token})
    if(!tokenDoc){
        return res.status(403).json({message:"Invalid refresh token"})
    }
    if(tokenDoc.expiresIn < new Date()){
        return res.status(403).json({message:"Invalid refresh token"})
    }
    const userId = tokenDoc.userId
    const new_refresh_token = generateToken(userId,"7d")
    const new_access_token = generateToken(userId,"15m")
    await RefreshToken.deleteOne({userId:userId})
    await createRefreshToken(userId,new_refresh_token)

    res.status(201).json({
        access_token: new_access_token,
        refresh_token: new_refresh_token
    })
    
})

const createRefreshToken = async(id,token)=>{
    await RefreshToken.create({
        userId: id,
        token: token,
        expiresIn: new Date(Date.now() + (7 * 24 * 60 * 60 * 1000)) 
    })
}