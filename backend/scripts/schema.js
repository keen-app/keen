const Joi = require("joi");

const userSchema = Joi.object({
    first_name: Joi.string().max(15),
    last_name: Joi.string().max(15),
    age: Joi.number().integer().min(1).required(),
    email: Joi.string().email().max(30).required()
});

module.exports = { userSchema };