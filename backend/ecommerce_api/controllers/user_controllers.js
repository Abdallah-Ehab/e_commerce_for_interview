const User = require("../models/user_model")
const asyncHandler = require("../config/async_handler")
const generateToken = require("../config/generatetoken")


exports.registerUser = asyncHandler(async(req,res,next)=>{
    const {email} = req.body 
    const findUser = await User.findOne({email})
    if(findUser){
        throw new Error("email already used")
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
           
            res.status(200).json({
                status:"success",
                user: findUser,
                token: generateToken(findUser._id)
            })
        }else{
            throw new Error("wrong password")
        }
    }
    else{
        throw new Error("user is not registered")
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
    const updatedUser = await User.findByIdAndUpdate(_id,{
        username: req.body.username ?? req.user.username,
        email:req.body.email ?? req.user.email,
        password: req.body.password ?? req.user.password,
        isAdmin: req.body.isAdmin ?? req.user.isAdmin
        
    },
    {
        new:true
    })
    res.status(202).json({
        status:"success",
        user:updatedUser
    })
})

exports.deleteUser = asyncHandler(async(req,res,next)=>{
    const {_id} = req.user
    const deletedUser = User.findByIdAndDelete(_id,{new:true})
    res.status(203).json({
        status:"success",
        user : null
    })
})