# Integration

Following the independent development of each sub-system, the entire team coordinated the integration of the three sub-systems into a bikeshare ready for testing.  The final goal of the integration process was to demonstrate that the Arduino on-board the smartlock could process information from the NFC and GPS modules and communicate with the MongoDB online database through the XBee network.  The system would thus need to correctly authenticate users and prompt the appropriate actuation of the locking mechanism.  The integration process was separated into four demonstrations, progressively improving on the previous to ensure proper operation of key functions through all demonstrations.  The first demonstration aimed to establish a channel of communication between the XBee end device on each smartlock and the XBee coordinator connected to the Mongo database.  The second demonstration configured authentication by adding the NFC reader communications to the XBee end device and successfully passing messages back and forth with the database.  The third demonstration scaled the second demonstration by relaying communications between the XBee end devices to an XBee coordinator through an XBee router acting as a node to introduce the idea of an XBee network.  The final demonstration integrated the mechanical components to digitally lock and unlock the smartlock based on a proper authentication message.  Each demonstration extended the possibility of each individual component in an incremental fashion until the team achieved a system ready to be scaled for a potential test implementation.  System diagrams visualizing these four demonstrations are included in Appendix B.