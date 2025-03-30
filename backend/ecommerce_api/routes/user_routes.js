const express = require("express")
const {registerUser, loginUser,getUsers, editUser, deleteUser} = require("../controllers/user_controllers")
const {verifyTokenMiddleware,verifyIsAdminMiddleware} = require("../middlewares/authorize")

const router = express.Router()

router.get("/",(req,res)=>{
    res.send("hello")
})
router.post("/registerUser",registerUser)
router.post("/loginUser",loginUser)
router.get("/users",verifyTokenMiddleware,getUsers)
router.put("/editUser",verifyTokenMiddleware,verifyIsAdminMiddleware,editUser)
router.delete("/deleteUser",verifyTokenMiddleware,verifyIsAdminMiddleware,deleteUser)
module.exports = router