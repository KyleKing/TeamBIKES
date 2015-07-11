Books = new Mongo.Collection("books");

if (Meteor.isClient) {
	Meteor.subscribe('BooksPub');

	Router.route("WebixHome", function(){
		this.render("WebixHome");
	});

	Router.route("/datatable", function(){
		this.render("Datatable");
	});

	Router.route("/dataloading", function(){
		this.render("DataLoading");
	});

	Router.route("/fullscreen", function(){
		this.render("FullScreen");
	});

	Router.route("/template", function(){
		this.render("Template");
	});
}

if (Meteor.isServer){
	if (!Books.find().count()){
		Books.insert({
			author:"Anthony Doerr",
			name:"All the Light We Cannot See"
		});

		Books.insert({
			author:"Paula Hawkins",
			name:"The girl on the train"
		});
	}
}