// Use UI.registerHelper..
// Copied fromL http://stackoverflow.com/questions/18580495/format-a-date-from-inside-a-handlebars-template-in-meteor
UI.registerHelper("formatDate", function(datetime, format) {
  var DateFormats = {
    shortest: 'MMM D, YYYY',
    short: 'hh:mm:ss a - MMM D, YYYY',
    // short: "DD MMMM - YYYY",
    long: 'H:m:s a - MMM D, YYYY'
    // long: "dddd DD.MM.YYYY HH:mm"
  };
  if (moment) {
    // can use other formats like 'lll' too
    format = DateFormats[format] || format;
    return moment(datetime).format(format);
  }
  else {
    return datetime;
  }
});