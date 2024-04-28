const Joi = require("joi");

const userSchema = Joi.object({
    email: Joi.string().email().max(50).required(),
    first_name: Joi.string().max(20).required(),
    last_name: Joi.string().max(20).required(),
    username: Joi.string().max(20).required()
});

// Shouldn't ever need to use visibilitySchema
const visibilitySchema = Joi.object({
    id: Joi.number().integer().required(),
    type: Joi.string().max(10).required()
});

const eventSchema = Joi.object({
    id: Joi.number().integer().required(),
    name: Joi.string().max(50).required(),
    location: Joi.string().max(50).required(),
    url: Joi.string().uri().max(255),
    emoji: Joi.string().max(20),
    description: Joi.string().max(255).required(),
    visibility: Joi.number().integer().required(),
    start: Joi.date().iso(),
    end: Joi.date().iso()
});

const collectionSchema = Joi.object({
    id: Joi.number().integer().required(),
    name: Joi.string().max(50).required(),
    description: Joi.string().required(),
    u_email: Joi.string().email().max(50).required()
});

const eventCollectedSchema = Joi.object({
    event_id: Joi.number().integer().required(),
    collection_id: Joi.number().integer().required(),
    date_added: Joi.date().iso().required()
});

const keenedSchema = Joi.object({
    u_email: Joi.string().email().max(50).required(),
    event_id: Joi.number().integer().required()
});

module.exports = { userSchema };