## Discovery

The Discovery section explains the evolution of Team BIKES discovery process through three key phases: decisions, exploration, and experimentation.  The decisions phase walks through how the team selected components that were going to be a part of the system.  The exploration phase includes the discussion of initial testing and introduction of core concepts.  The concepts include exploring XBee operations, building testing fixtures, NFC testing, and IRB approvals.  Lastly, the experimentation phase discusses various tests of individual components, such as lock testing, encryption protocol, and GPS experimentation.

Decisions.  The first steps the team took were to take the findings in the literature review and make decisions on how to continue the project.  The team decided to look into creating 3-D prototypes to model lock designs and to model various styles of locks.  The choice of 3-D printing available on the University of Maryland’s campus afforded the team a method to rapidly create the prototypes and quickly test design changes.  Aluminum was chosen as the material to fabricate the prototypes once 3-D printing demonstrated the concept.  The team chose the material because of its material properties, affordability, and ease of acquisition.

The team selected NFC technology as the RFID technology best suited for the unlocking and authentication need.  Finally, the team decided on which grants to apply for as to provide necessary funding alongside the Gemstone department semesterly-allowance.

3-D prototyping.  Rapid prototyping is any technique used to rapidly fabricate a model.  One type of rapid prototyping involves the use of 3D CAD software, which operators use to create a 3D model.  The model is converted into the appropriate file type for a number of rapid prototype machines including stereolithography (SLA), selective laser sintering (SLS), and fused deposition modeling (FDM).  Team BIKES had access to FDM machines, specifically the MakerBot products.  All of the printed lock prototypes were printed using MakerBot 5th Generation printers with PLA material.  These printers are readily available, use inexpensive material, and allow for rapid testing and design changes without great expense nor great time invested in a metal machine shop.

However, 3D printers present several drawbacks.  The MakerBot printers have limited accuracy, making small details impossible to duplicate upon repetition.  Circles smaller than one inch in diameter are often misshapen making it difficult to test part alignment or the effectiveness of pins and rods.  To compensate for this, the CAD designs must include extra dimension tolerance.  To save on material costs, the models are printed with a honeycomb fill instead of solid fill.  The honeycomb structure makes the print lighter, faster, and consumes less material at the cost of structural integrity.  During the Gemstone Undergraduate Research day, the weak structural integrity became apparent when the model was dropped and the locking arm broke away from the locking collar.  The compromised model was remedied by gluing the locking arm back together with the locking collar.  The hollow honeycomb structure also makes it difficult to make physical modifications to the printed model.  Any cuts or holes that are drilled into the model will expose the inner cavity.  For example, if attempting to modify the 3D printed model to fit an additional pin, the drilled hole would not amply guide the pin because of the now exposed irregular honeycomb structure.

Aluminum manufacturing.  Following the rapid prototyping stage, the team began aluminum machining.  Aluminum is a lightweight and strong metal, but it is still softer and more ductile than steel.  This combination of attributes allowed the team to increase machining speed, reduce material expenses, determine acceptable tolerances for machined parts, and setup automated CNC files for computer controlled machining.  The CNC uses CAD files and converts them into machine code, which then controls a mill and machines the stock material into the desired part.  In the interest of manufacturability, the lock designs were further refined.  In the loop lock pictured below in Figure 7, the collars would be machined separately from the locking arms, thus preventing the waste of a substantial amount of material.  The arms would be individually bent to the appropriate angle, inserted into the matching recesses in the collars, and welded in place to maximize the joint strength. This construction accurately represents an actual machining process for parts of this complexity, which is how the commercialized locks could be manufactured.

Figure 7.  Latest iteration of the loop lock.

RFID decision.  In the early development stages of the electronic hardware, the Arduino microcontroller was selected to process and operate the necessary electrical components within each smartlock.  The Arduino is frequently used in product development for its powerful processing power with a small footprint.  Additionally, there is a vast online collection of open-source codes and libraries due to its popularity.

NFC technology was chosen as the access control method for each smartlock.  The user will have to present a NFC chip to the reader placed on the smartlock to unlock and use the bike.  The decision was made after careful considerations of Bluetooth, RFID, and NFC explored in the literature review.  In attempts to streamline the user experience, the team ruled out Bluetooth technology, which requires pairing of devices.  Requiring users to pair personal devices to the smartlock for access control presents a limitation on the scalability and usability of the system.  Alternative, electronic payment technologies utilize NFC to communicate between the reader and NFC enabled credit card or mobile payment applications.  NFC also requires greater proximity than other RFID systems for communication.  The smaller range of operation reduces the chance of attackers to capture or alter the communication, adding to the innate security of the system. These characteristics played an important role in the team’s decision pursue NFC technology for user authentication.

Funding.  In addition to the semesterly funds of $300.00 provided through the Gemstone Department, the team sought outside support to supplement the costs of materials and bikes.  To do this, the team applied for and received a grant from the University of Maryland’s Sustainability Fund.  The team received a $4,000 grant in April of 2014, and the funds were used to purchase raw materials for the XBee network and RFID technology as well as materials to construct, mill, and test locks.  The team also submitted applications for the Pepsi Enhancement Fund distributed by the University of Maryland’s Stamp Student Union, the VentureWell Grant, and the 2014-15 Sustainability Fund.  Unfortunately, for these grants no additional funding was awarded.

Exploration.  The exploration subsection follows the primary research of the various technologies by each subteam including initial testing and the ensuing design changes.  The Locking subteam started material property testing; created computer aided design (CAD) models of purchased locks, and completed finite element analysis (FEA) analysis to compare data collected from physical tests to theoretical failure modes.  The Access Control subteam acquired a selection of authentication devices and evaluated each technology.  Geolocation purchased XBee hardware to test basic operations and to understand XBee product limitations.  For the website, the Geolocation subteam tested Ruby, Node, Meteor, and other comparable software frameworks to select the best framework for a stationless bikeshare.  Lastly, the team's Business subteam was able to get Institutional Review Board (IRB) approval that would be needed for future focus groups.

Finite element analysis and lock testing.  In order to predict and understand failure modes of commercial lock designs, the Locking subteam performed FEA analysis in Solidworks, a computer aided design software.  When testing, the machine could exert a maximum force of 25 kN.  The FEA analysis provided insight into whether or not the test would break a given lock and the likely method of failure.

Figure 8.  FEA analysis of cutting test on straight portion of U-lock.  Each force is 12.5 kN equating to 25 kN.

Figure 8 shows the FEA analysis for the proposed cutting test of the U-lock.  There are fixtures on both ends of the straight portion of the U-lock, like the actual test would incorporate, and two point loads equating to 25 kN of force.  This test shows that the U-lock would only displace around 0.002 inches, proving that the test would not break the lock and the cutter would need more than 25 kN to break through the metal.  It is also shown in Figure 9 that the OnGuard K9 folding lock would not break with a force of 25 kN.

Figure 9.  FEA analysis of cutting test on a straight portion of OnGuard K9 folding lock.  Each force is 12.5 kN equating to 25 kN.

To test the existing bike locks, Team BIKES needed to design and build fixtures that could interface with the testing machine.  To properly interface with this machine, the fixtures had to be able to withstand a load of up to 25 kN and be mounted with a M16 - 2x50 mm Cap Screw depicted in Appendix A.  The lock specimens are made of steel and steel composites; therefore, the fixture must be as strong or stronger in order to survive the applied forces without deformation that would influence the test results.  To ensure the fixtures have enough strength to handle the tests, the team chose hardened steel with a thickness of ⅛ in.  To accommodate all locks using a single set of fixtures, the team chose to build a pin and plate fixture, which can be seen in Figure 10 below.

Figure 10.  Testing fixtures with pins and bolt cutter head piece.

This design uses additive and bonding processes that are far less expensive and time consuming than subtractive processes such as milling through a solid block of steel.  Two plates are welded to the inside of each wing in a U-channel of steel.  These plates lengthen the wings of the channel, while simultaneously increasing the fixtures strength and stability under load.  In order to test the multitude of existing locks, two different sets of plates had to be used.  One set of plates was designed for tension testing and were placed on the inside or outside of the U-channel depending on the lock being tested.  The other set was designed for cutting the locks with the use of bolt cutter head pieces.  The first set of plates, used for tension tests, can be seen assembled with the test fixtures in Figure 11 below.

Figure 11.  Test fixtures attached to Tinius Olsten model H25K-T benchtop tester during the OnGuard K9 folding lock tension test.  The tension plates can be seen on either side of the bottom U-channel.  The tension plates are configured on the outside of the U-channel to fit the OnGuard K9 folding lock.

For the tension testing plates, two sets of three ½ in pins were used.  One set of pins are shorter in length than the other.  The longer set of pins are used to test the OnGuard K9 folding lock, and this allows the plates to be placed on the outside of the U-channel.  To pull the locks, an additional ½ in pin is placed in the center of the plates.  This pin secures the locks and restricts them from falling out of the fixtures.  Furthermore, the cutting testing plates were designed to allow the bolt cutter blades to fit.  To do this, a small rectangular section was cut out on the top left of the plate.  Two different sized pins, ⅜ in and ¼ in, were used to secure the bolt cutter onto the plates along with washers.  The addition of the washer ensures no moment is induced during testing.

Acquiring NFC materials.  Once NFC was selected, the first step towards a secure access system was to select a small, configurable, NFC reader to build the system around.  The first model tested was the Adafruit PN532 Reader/Writer available as an Arduino shield that could be used to write as well as read NFC tags.  While useful for initial exploration, the dual-mode feature had several drawbacks.  First of all, the tag writing feature presents a clear security risk to the system because the writing feature amounts to a broadcast of data sent through the module from the associated microcontroller to any nearby NFC tag.  The additional writing circuitry also increased the power draw of the module.  The most important shortcoming, however, is that Adafruit module was far too large to fit inside the electronics box for the prototype smartlock.  For that reason, the second module tested, the PN532 v3.0 by Seedstudio was selected based on its size- it had a footprint equivalent to that of the Arduino and stacked neatly on top of it.  This module had the smallest antenna of any of the modules considered, and the antenna was attached by a short external wire that allowed for more flexibility in the placement of the antenna inside of the electronics box.  The Seedstudio PN532 module solved many of the problems of the Adafruit module; it could only read tags, it had a lower power draw, and it could be more easily configured into a small space.  However, the Seedstudio module was ultimately abandoned due to signal integrity concerns that arose when a longer antenna attachment wire was used.  In response to this concern, the third NFC module tested was the NFC 2.0 by Elechouse which combined the antenna and reader circuitry on a single small module that is then wired to the Arduino.  At approximately a square inch in total size, this reader had a significantly smaller footprint than either of the others, but the wired connection to the Arduino was more robust than the connection between the PN532 v3.0 antenna and body.  Before comparing the acquired modules for reliability, ease of use, and power consumption, sizing and packaging concerns alone pointed to the Elechouse NFC 2.0 as the most viable solution.

Every time a new module was acquired, a tag read operation needed to be performed with it in order to assure that the module worked as expected and could be easily integrated into the hardware system by the team in the future.  The first step was to write code that would print out the NFC tag number captured by the reader to the serial port of the Arduino.  This seemingly simple exercise required team members to gather and install all necessary code libraries and correctly configure any options on the module to operate with the Arduino hardware.  After achieving this, the team could move on to a simple “Blink” test where the Arduino checked the tag ID acquired by the reader against a small, internal database of valid ID numbers and blinked a green LED if the tag matched, and a red LED if it did not.  Performing both of these tasks with all three readers ensured that the team had the necessary experience working with each tag to confidently test the properties of the readers.

Though all of the readers had a tag reading distance listed as part of the product specification, the team wanted to confirm that these properties held true under non-ideal conditions.  Simple tests were established to determine the distance at which each module could read a tag and the power it consumed.  For the distance test, a module was connected to an Arduino with a simple program that read the tag and printed the result to the Arduino’s serial port.  The module was then placed so that its face was perpendicular to the surface of a table and powered on.  Starting at a distance of 20 cm from the reader, the NFC tag was moved closer to the readers at intervals of 5 mm at a time, until the reader was able to recognize the tag.  This test was performed for each acquired module and repeated with different materials in close proximity to the NFC reader or tag.  For instance, placing a tin sheet within a centimeter of the NFC reader made tag reading distance random and uncontrollable.  The closer the metal, the shorter the reading distance has to be.  Additionally, the team confirmed that even a thick sheet of plastic separating the NFC tag and reader would not decrease the reading distance or accuracy.  The team also measured the operating voltage of the NFC reader modules to determine how far the voltage could be decreased and still ensure correct readings.  Additionally, the operating current of each module was measured for consideration in the final system design.  Figure 12 summarizes the measured results of the three aforementioned modules.

Figure 12.  Comparison of tested NFC modules.

XBee.  After deciding to pursue the ZigBee protocol, the team researched available modules.  The Geolocation subteam referenced the XBee Buying Guide on Sparkfun Electronics website, which aided in deciding which modules to purchase.  The system requirements that informed this decision included:

* Mesh network capability
* Sufficiently long transmission distances for a large coverage area
* Minimum per module cost

Other factors considered were the antenna type (duck, whip, or pigtail) and the frequency (2.4 GHz or 915 MHz).  Comparison of the antenna types can be seen in Figure 13.  The frequency had the most effect on the data rate.  The 2.4 GHz band had a higher data rate (250 kbps) than the 915 MHz band (up to 156 kbps).

Figure 13.  Comparison of antenna types

After reviewing the buying guide, the Geolocation subteam purchased the XBee Module Series 2B with various antenna types and frequency ranges for experimentation.  In order to interface with the modules, the Geolocation subteam purchased breakout boards that transitioned the pin spacing to a width that allowed for easier prototyping with a breadboard and added a direct USB interface.

Digi-Key’s XCTU XBee desktop application.  Once the XBee modules were acquired and configured, the Geolocation subteam began exploring how to interface with the modules.  Digi-Key’s XCTU application proved to be the best technique for interfacing with the modules for all of the configurations.  The subteam found that there were many different configuration parameters with various values and options for each parameter.  Some important configurations explored were the PAN ID, which served as the unique ID of the network that all of the modules share, the interfacing options of AT versus API, and the firmware options of the end device, router, or coordinator.

Firmware options.  The firmware options include two main components: node type (end device, router, or coordinator) and mode type (AT or API).  The Geolocation subteam team explored the differences in types and how they would affect the communications network.  The differences in node type are defined above in the Literature Review; however, their relation to the command mode type was explored in detail.  AT mode, or transparent mode, acts as a direct serial connection from the TX port of one module to the RX port of the next, much like a physical wire connection.  AT mode is useful when a message is being sent through an XBee module as if the XBee module acts as a physical wired connection.  API mode, or command mode, is more robust in that a command is sent to the XBee module rather than simply sending a message through it.  When a message is sent from an XBee module in API mode, the user must send a ZigBee packet that includes the command to the module representing that a message is to be transmitted, the message payload, and other fields as necessary, such as destination address.  Leveraging the ZigBee protocol in API mode allowed for more capabilities and control over the messages being sent due to the possibilities to add additional fields such as a specific destination address.  Additionally, other commands could be utilized to gain further capabilities such as requesting network information or the signal strength of the last received packet.

The different firmware allow for compatibility between variations, meaning an API mode coordinator could send a message to an AT mode end device.  For the desired communications system, the transmissions from the end devices simply need to send string messages formatted by an Arduino in the smartlock, as well as receive strings formatted by the website application.  Since this transmission requires no advanced features, the end devices were configured in AT mode to reduce complexity.  The routers’ purposes were simply to relay messages, so they too were configured in AT mode to reduce complexity.  However, the coordinator requires more complexity due to its role as the central node in the network and the bridge from the bikes to the website.  Because of the increased complexity, the coordinator is configured in API mode.

IRB approvals.  In order to carry out a focus group discussion to gather UMD students’ feedback regarding interest in bikeshare and progressing smart lock design, the Business subteam sought to acquire IRB approval, which reviews research involving human subjects.  The board monitors the human-subject research to protect those tested and to prevent harmful or coercive situations.  Once the IRB approved the application, the team organized and carried out the focus group.  With guidance provided by the Gemstone Department, the Business subteam completed two forms: a Human Subject Determination Form (HSD) and a copy of the focus group questions.  The HSD form was a way to determine if a full review would be necessary or if the planned focus group discussion could be exempt based on the minimal risk posed by the nature of the research and proposed questions.  In February 2015, the IRB found that the planned focus group discussion did not fulfill the requirements of human subject research, and the team could host the focus group.

Experimentation.  Once each subteam gained technical proficiency with the selected technology, each component could be further developed to be a reliable component of the future bikeshare system.  The Locking subteam used the custom fixtures to conduct materials testing on commercial bike locks.  The Access Control subteam tested the viability of solar cells as an energy source and experimented with encryption protocols, NFC tags, and Arduino coding styles.  Geolocation experimented with collecting the data needed for each bike using a GPS module and designed their database structure.

Lock testing results.  The Locking subteam gained firsthand experience by test fixtures to compare different bike locks’ material strengths.  The Locking subteam tested the Kryptonite Keeper 12 U-lock and the OnGuard K9 folding lock using Dr. Bonenberger’s material testing lab at the University of Maryland, College Park. These selection were based on common lock styles viewed around the University of Maryland campus. The campus Department of Transportation sells the Kryptonite Keeper 12, and was selected as our first benchmark lock for testing. The OnGuard K9 folding lock is representative of the folding style locks used on campus based on visual inspection. The team’s custom-built fixtures interfaced with the Tinius Olsten model H25K-T benchtop tester in Dr. Bonenberger’s lab, allowing for tension testing on both locks.  The test machine could provide a maximum force of 25 kN, which was enough to break both types of locks.  The following graphs represent the relevant data gathered from the Kryptonite Keeper 12 U-lock tests.

Figure 14.  Kryptonite Keeper 12 U-lock tension test one - force vs change in length.  This figure shows U-lock tension test 1 results, picturing every 150th data point for ease of reading.

Figure 15.  Kryptonite Keeper 12 U-lock tension test two - force vs change in length.  This figure shows U-lock tension test 2 results, picturing every 150th data point for ease of reading.

In the U-lock testing graphs, the line begins with a shallow slope.  This indicates that a large ∆L is achieved with a relatively small increase in force as the machine begins applying a tensile force on the lock and any gaps between the components of the machine are tightened.  When the material begins to deform, the slope of the line increases as more force is required to achieve the same change in length.  At the end of the graph, the slope of the line decreases again as the lock begins to fail and the machine needs less force to continue deforming the lock.  In the first trial, the lock failed at 20.07 kN of force, snapping apart at the bent foot side of the U-shaped shackle.  In the second trial, the lock failed at 20.65 kN of force, also failing at the bent foot.  This means that the weakest part of the lock, when subjected to a tensile force, is the interface between the shackle and crossbar on the bent foot side, the side that is not fixed by the U-lock’s key-actuated locking mechanism.  If both sides of the shackle were secured by the locking mechanism, as in the case with the Kryptonite Fahgettaboudit U-lock, the lock would be expected to withstand a greater tensile force before failure.

These force vs change in length graphs are comparable to stress-strain curves because stress is equal to force divided by cross-sectional area and strain is equal to change in length over original length.  Since the lock dimensions, cross-sectional area, and original length do not change significantly over the course of the test, these graphs will have about the same shape as a stress-strain curve.  The line follows the expected form of a stress-strain curve with slight differences caused by the fact that an assembly of multiple pieces is being tested rather than a single piece of material.  This difference causes the beginning of the graph to have a smaller slope as the pieces of the assembly shift to allow the maximum possible displacement without undergoing material deformation.  Once the slope of the graph becomes larger and linear, as can be seen in the middle section of the above graphs, the curve follows the expected pattern of the elastic region of a stress-strain curve.  In this region, the material deforms at a constant rate with respect to the force applied, and the material will regain its original dimensions upon the removal of the force.  When the slope of the graph begins to become smaller, curving downward, the material enters the plastic deformation region.  In this region, less force is needed to deform the material and the material becomes permanently deformed, meaning that if the force was removed the lock would not return to its original dimensions.  The graphs end when the lock failed and the machine stopped reading force and displacement values.  Figure 16 below shows one of the U-locks after testing.  Note the bent foot portion has popped out of the crossbar.

Figure 16.  Kryptonite Keeper 12 U-lock after tension testing.  The lock failed at the interface between the shackle’s bent foot and the crossbar.

The team also performed two tension tests on the OnGuard K9 folding lock.  The team modified the test fixtures to fit the folding lock, again using the Tinius-Olsten model H25K-T benchtop tester.  The graphs below represent the data gathered from these tests.

Figure 17.  OnGuard K9 folding lock tension test one - force vs change in length.  This figure shows folding lock tension test 1 results, picturing every 150th data point for ease of reading.

Figure 18.  OnGuard K9 folding lock tension test two - force vs change in length.  This figure shows folding lock tension test 2 results, picturing every 150th data point for ease of reading.

The folding lock test graphs follow the same general form as the U-lock test graphs, with noticeable variation in the early stages of testing.  In the first folding lock test, the graph started out with a larger slope, quickly entering the elastic deformation region.  The second test began by approaching zero slope before jumping to the linear, positively sloped region expected for elastic deformation.  This difference was caused by the large amount of moving parts in the OnGuard K9 folding lock.  In contrast to the U-lock, which is composed of only two parts, the folding lock features six different sections connected by hinges.  This allowed more freedom of movement in the lock in the initial stages of the test before the lock reached maximum elongation and began to deform.  Another difference between the U-lock tests and the folding lock tests is pictured in folding lock test one.  At the far right end of the graph, the data reaches a peak before sloping downward and reaching failure.  This peak indicates the ultimate tensile strength of the material, as can be seen when the applied force decreases but the deformation continues to occur.  The first folding lock failed at 6.507 kN after achieving a maximum of 6.661 kN and the second folding lock failed at 7.154 kN.  Figure 19 below pictures the folding lock during testing.

Figure 19.  OnGuard K9 folding lock during testing.

Since the U-locks were able to withstand forces of about 20 kN in both trials before failure while the folding locks were only able to withstand forces of about 7 kN, the team learned that the U-lock’s design is much more resistant to tensile forces than that of the folding lock.  The U-lock’s failure at the bent foot portion of the shackle indicates that if that side of the shackle was also secured by the U-lock’s key-actuated locking mechanism, it is likely that the lock could have withstood a greater tensile force before failure.  The team used this information to develop the Locking subteam’s preliminary designs, which will be discussed in the implementation section of the Development chapter.

GPS.  In combination with a secure lock, the bikeshare will need real-time location information.  The Geolocation subteam began researching and experimenting with a GPS module.  The GPS module was connected with an Arduino and operated using the National Marine Electronics Association (NMEA) protocol.  The NMEA protocol uses a comma-separated value (CSV) string to display different strings of information.  Luckily, an existing software library allowed for easy parsing of the NMEA data received over the GPS module that allowed for fast-acquisition and accurate GPS readings.