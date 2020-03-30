var https = require("https");
var util = require("util");

exports.handler = function(event, context) {
  console.log(JSON.stringify(event, null, 2));
  console.log("From SNS:", event.Records[0].Sns.Message);

  var severity = "good";
  var message = event.Records[0].Sns.Message;
  var messageJSON = JSON.parse(message);
  var subject = event.Records[0].Sns.Subject;

  var postData = {
    channel: "#channel",
    username: "CodeDeploy",
    icon_emoji: ":codedeploy:"
  };

  if (messageJSON.status == "FAILED") {
    severity = "danger";
  }
  if (messageJSON.status == "STOPPED") {
    severity = "warning";
  }

  var fields = [];
  for (var key in messageJSON) {
    if (key == "deploymentOverview") {
      var value = [];
      var deploymentOverview = JSON.parse(messageJSON[key]);
      for (var status in deploymentOverview) {
        value.push(status + ": " + deploymentOverview[status]);
      }
      fields.push({
        title: key.replace(/([A-Z])/g, " $1").replace(/^./, function(str) {
          return str.toUpperCase();
        }),
        value: value.join(", ")
      });
    } else {
      fields.push({
        title: key.replace(/([A-Z])/g, " $1").replace(/^./, function(str) {
          return str.toUpperCase();
        }),
        value: messageJSON[key],
        short: true
      });
    }
  }

  postData.attachments = [
    {
      color: severity,
      fallback: message,
      title: subject,
      title_link:
        "https://console.aws.amazon.com/codedeploy/home?region=" +
        messageJSON.region +
        "#/deployments/" +
        messageJSON.deploymentId,
      fields: fields
    }
  ];

  var options = {
    method: "POST",
    hostname: "hooks.slack.com",
    port: 443,
    path: "/services/yourservicehookhere"
  };

  var req = https.request(options, function(res) {
    res.setEncoding("utf8");
    res.on("data", function(chunk) {
      context.done(null);
    });
  });

  req.on("error", function(e) {
    console.log("problem with request: " + e.message);
  });

  req.write(util.format("%j", postData));
  req.end();
};
