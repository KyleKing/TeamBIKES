UI.body.rendered = function () {
  new OutdatedBrowser({
    message: "Update your browser to view this website correctly.",
    title: "Your browser is out-of-date!",
    button: "Update my browser now ",
    bgColor: "#F25648",
    color: "#FFF",
    lowerThan: "transform"
  });
};