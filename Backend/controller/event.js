import asyncHandler from '../middlewares/async.js';
import ErrorResponse from '../utils/errorResponse.js';
import User from '../model/user.js'
import Event from '../model/event.js'
export const addNewEvent = asyncHandler(async (req, res, next) => {
    // Assuming you have a event schema with fields like title, description, images, etc.
    try {
        // Extract event details from the request body
        const {

            title,
            subtitle,
            description,
            campus,
            postedAt,
            venueType,
            startDate,
            endDate,
            tags,
            capacity,
            eventImages,
            organizerInfo,
            attendees,
            registrationLink,
            contactInfo,
            eventType,
            criteria,
            prize,
            location,
            admins,
            feedback,
            createdBy
        } = req.body;

        // Create a new Event instance
        const newEvent = new Event({
            title,
            subtitle,
            description,
            campus,
            postedAt,
            venueType,
            startDate,
            endDate,
            tags,
            capacity,
            eventImages,
            organizerInfo,
            attendees,
            registrationLink,
            contactInfo,
            eventType,
            criteria,
            prize,
            location,
            feedback,
            admins,
            createdBy,
        });

        // Save the event to the database
        const savedEvent = await newEvent.save();
        console.log('Event Saved: ', savedEvent);
        res.status(200).json({
            success: true,
            data: savedEvent,
        });
    } catch (error) {
        console.error('Error saving event:', error);
        res.status(500).json({
            success: false,
            error: 'Internal Server Error',
        });
    }
});


export const getAllEvents = asyncHandler(async (req, res, next) => {
    const events = await Event.find();
    console.log(events);
    res.status(200).json({
        success: true,
        events: events,
    });
});


// @desc Get A EVent By It's Id
// @route GET/api/v1/auth/event/get-event-by-id:eventId
// @access Private
export const getEventById = asyncHandler(async (req, res, next) => {
    const eventId = req.params.eventId;

    const event = await Event.findById(eventId);

    if (!event) {
        return next(new ErrorResponse(`event with id ${eventId} not found`, 404));
    }


    console.log(event);
    res.status(200).json({
        success: true,
        event: event
    });
});


// @desc Update a Event
// @route PUT /api/v1/event/:id
// @access Private

export const updateEvent = asyncHandler(async (req, res, next) => {
    try {
        let event = await Event.findById(req.params.eventId);
        if (!event) {
            return next(new ErrorResponse(`No event with id of ${req.params.eventId}`, 404))
        }

        event = await Event.updateOne({ _id: req.params.eventId }, req.body, {
            new: true,
            runValidators: true
        })
        res.status(200).json({
            success: true,
            data: event
        })
    } catch (e) {
        console.log(e);
        res.status(400).json({
            success: false,
            error: e,
        })
    }
});