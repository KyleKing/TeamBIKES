// // Use UI.registerHelper..
// // Copied fromL http://stackoverflow.com/questions/18580495/format-a-date-from-inside-a-handlebars-template-in-meteor

var DateFormats = {
  shortest: "DD MM, YYYY",
  short: "DD MMMM - YYYY",
  long: "dddd DD.MM.YYYY HH:mm"
};

// Use UI.registerHelper..
UI.registerHelper("formatDate", function(datetime, format) {
  if (moment) {
    // can use other formats like 'lll' too
    format = DateFormats[format] || format;
    return moment(datetime).format(format);
  }
  else {
    return datetime;
  }
});