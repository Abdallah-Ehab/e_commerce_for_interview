const express = require("express")
const {registerUser, loginUser,getUsers, editUser, deleteUser, refresh_token} = require("../controllers/auth_controller/user_controllers")
const {verifyTokenMiddleware,verifyIsAdminMiddleware} = require("../middlewares/authorize")
const { getAllProducts } = require("../controllers/product_controller/product_controller")

const router = express.Router()

router.get("/",(req,res)=>{
    res.send("hello")
})
// auth routes
router.post("/registerUser",registerUser)
router.post("/loginUser",loginUser)
router.get("/users",verifyTokenMiddleware,getUsers)
router.put("/editUser",verifyTokenMiddleware,verifyIsAdminMiddleware,editUser)
router.delete("/deleteUser",verifyTokenMiddleware,verifyIsAdminMiddleware,deleteUser)
router.post("/refresh",refresh_token)

//products routes
router.get("/products",verifyTokenMiddleware,getAllProducts)


module.exports = router


