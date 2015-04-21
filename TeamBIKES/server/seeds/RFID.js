if(RFIDdata.find({RFIDCode: 'lunchonthesky'}).count() === 0) {
  RFIDdata.insert({
    RFIDCode: 'lunchonthesky'
  });
}