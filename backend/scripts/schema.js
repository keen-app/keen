const Joi = require('joi');

// User schema
const userSchema = Joi.object({
  email: Joi.string().email().required(),
  first_name: Joi.string().max(255).required(),
  last_name: Joi.string().max(255).required(),
  username: Joi.string().max(255).required(),
});

// Privacy setting enum
const privacySettingSchema = Joi.string().valid('public', 'private');

// Event schema
const eventSchema = Joi.object({
  id: Joi.number().integer(), // For primary key
  name: Joi.string().max(255).required(),
  visibility: privacySettingSchema.required(),
  start: Joi.date().iso(), // Using ISO 8601 format for timestamps
  end_time: Joi.date().iso(),
  emoji: Joi.string().max(20),
  location: Joi.string().max(255),
  url: Joi.string().uri(),
  description: Joi.string(),
});

// Collection schema
const collectionSchema = Joi.object({
  id: Joi.number().integer(),
  name: Joi.string().max(255).required(),
  description: Joi.string(),
  user_email: Joi.string().email().required(), // Foreign key
});

// Contains schema (junction table for Collection and Event)
const containsSchema = Joi.object({
  event_id: Joi.number().integer().required(), // Foreign key to Event
  collection_id: Joi.number().integer().required(), // Foreign key to Collection
  datetime_added: Joi.date().iso().default(new Date()), // Default value for datetime_added
});

// Keened schema (junction table for User and Event)
const keenedSchema = Joi.object({
  user_email: Joi.string().email().required(), // Foreign key to User
  event_id: Joi.number().integer().required(), // Foreign key to Event
});

module.exports = {
  userSchema,
  eventSchema,
  collectionSchema,
  containsSchema,
  keenedSchema,
};
