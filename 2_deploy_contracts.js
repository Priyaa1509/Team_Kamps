const UserRegistration = artifacts.require("UserRegistration");
const TravelService = artifacts.require("TravelService");
const Booking = artifacts.require("Booking");
const ReviewSystem = artifacts.require("ReviewSystem");
const SimpleNFT = artifacts.require("SimpleNFT"); // Added closing quote

module.exports = function(deployer) {
    deployer.deploy(UserRegistration);
    deployer.deploy(TravelService);
    deployer.deploy(Booking);
    deployer.deploy(ReviewSystem);
    deployer.deploy(SimpleNFT);
};