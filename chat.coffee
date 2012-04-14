# Initialize Messages from MongoDB "messages" collection
Messages = new Meteor.Collection "messages"

if Meteor.is_client
  # Export Messages model to client
  window.Messages = Messages

  # Load all documents in messages collection from Mongo
  Template.messages.messages = ->
    Messages.find({}, { sort: {time: -1} })

  # Listen for the following events on the entry template
  Template.entry.events =
    # All keyup events from the #messageBox element
    'keyup #messageBox': (event) ->
      if event.type == "keyup" && event.which == 13 # [ENTER]
        new_message = $("#messageBox")
        name = $("#name")

        # Save values into Mongo
        Messages.insert
          name: name.val(),
          message: new_message.val(),
          created: new Date()

        # Clear the input boxes
        new_message.val("")
        new_message.focus()

        # Make sure new chat messages are visible
        $("#chat").scrollTop 9999999;