const joi = require("joi");

const loginValidation = joi.object({
    email:joi.string().email().required(),
    password:joi.string().required()
});

const registerValidation = joi.object({
    username:joi.string().required(),
    email:joi.string().email().required(),
    password:joi.string().required(),
    isAdmin:joi.boolean().required().default(false)
});



const validationMiddleware = (schema)=>{
    return async(req,res,next)=>{
        try{
            const {error} = await schema.validateAsync(req.body)
            if(error){
                next(error)
            }
        }catch(err){
            next(err)
        }
    }
}

module.exports = {
  loginValidation,
  registerValidation,
  validationMiddleware
}