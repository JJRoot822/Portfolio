const Discord = require("discord.js");
const client = new Discord.Client();
const constants = require("./constants");
const utilities = require("./util");
const jokes = require("./jokes.json");

client.on("ready", () => {
  client.user.setActivity(constants.ACTIVITY, { type: "WATCHING" });
});

client.on("message", (receivedMessage) => {
  if (receivedMessage.author == client.user) {
    // Prevent bot from responding to its own messages
    return;
  }

  if (receivedMessage.content.startsWith("!")) {
    processCommand(receivedMessage);
  }
});

function processCommand(receivedMessage) {
  let fullCommand = receivedMessage.content.substr(1);
  let splitCommand = fullCommand.split(" ");
  let primaryCommand = splitCommand[0];
  let arguments = splitCommand.slice(1);

  console.log("Command received: " + primaryCommand);

  if (arguments.length > 0) {
    let args = "";

    arguments.forEach((value, index, array) => {
      if (index < array.length - 1) {
        args += `${value}, `;
      } else {
        args += `${value}`;
      }
    });

    console.log(`Arguments Received: ${args}`);
  } else {
    console.log("Arguments Received: None");
  }

  if (primaryCommand == constants.HELP_COMMAND) {
    helpCommand(arguments, receivedMessage);
  } else if (primaryCommand == constants.JOKE_COMMAND) {
    telljokeCommand(arguments, receivedMessage);
  } else {
    receivedMessage.channel.send(
      "Uh... This is awkward. That's not a valid command. Try `!help` or `!telljoke`"
    );
  }
}

function telljokeCommand(arguments, receivedMessage) {
  let jokeIndex = Math.round(utilities.randomNumber(0, jokes.length));
  let joke = jokes[jokeIndex].joke;

  if (arguments.length > 0) {
    receivedMessage.channel.send(
      `Oops! Looks like you entered ${arguments.length} argument(s). This command can't take any arguments.`
    );
  } else {
    receivedMessage.channel.send(
      `I have a joke for you, ${receivedMessage.author.toString()}.\n\n${joke}`
    );
  }
}

function helpCommand(arguments, receivedMessage) {
  if (arguments.length > 0) {
    if (arguments.length > 1) {
      receivedMessage.channel.send(
        "Sorry, but you can't include more than one argument."
      );
    } else {
      if (arguments[0] === constants.JOKE_COMMAND) {
        receivedMessage.channel.send(
          "To have me tell a joke, put `!telljoke` in the chat with no arguments."
        );
      } else if (arguments[0] === constants.HELP_COMMAND) {
        receivedMessage.channel.send(
          "To have me give you help with a command, put `!help` in the chat with either `telljoke` or `help` as arguments."
        );
      } else {
        receivedMessage.channel.send(
          "Invalid Argument Provided. The proper syntax for the help command is `!help [topic]`"
        );
      }
    }
  } else {
    receivedMessage.channel.send(
      "I'm not sure what you need help with. Try `!help [topic]`"
    );
  }
}

client.login(constants.DISCORD_BOT_SECRET_TOKEN);
