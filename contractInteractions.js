import SimpleNFT from './artifacts/SimpleNFT.json';

const Web3 = require("web3");
const fs = require("fs");
const path = require("path");
require("dotenv").config(); // Load environment variables from .env

// Set up web3 with a provider
const providerUrl = process.env.PROVIDER_URL || "https://mainnet.infura.io/v3/a07e9afac5fd4c96963727ad70241d03";
const web3 = new Web3(new Web3.providers.HttpProvider(providerUrl));

// Load contract addresses dynamically from config.js
const contractAddresses = require("./config");

// Load ABIs from JSON files
const loadABI = (contractName) => {
    const filePath = path.join(__dirname, "build/contracts", ${contractName}.json);
    try {
        const fileData = JSON.parse(fs.readFileSync(filePath, "utf8"));
        return fileData.abi;
    } catch (err) {
        console.error(Error loading ABI for ${contractName}:, err.message);
        throw err;
    }
};

// Initialize contract instances dynamically
const contracts = {
    UserRegistration: new web3.eth.Contract(loadABI("UserRegistration"), contractAddresses.UserRegistration),
    Booking: new web3.eth.Contract(loadABI("Booking"), contractAddresses.Booking),
    ReviewSystem: new web3.eth.Contract(loadABI("ReviewSystem"), contractAddresses.ReviewSystem),
    SimpleNFT: new web3.eth.Contract(SimpleNFT.abi, contractAddresses.SimpleNFT), // Updated to use imported ABI
    TravelService: new web3.eth.Contract(loadABI("TravelService"), contractAddresses.TravelService),
};

// Export the contracts and web3 instance
module.exports = {
    web3,
    userRegistrationContract: contracts.UserRegistration,
    bookingContract: contracts.Booking,
    reviewSystemContract: contracts.ReviewSystem,
    simpleNFTContract: contracts.SimpleNFT,
    travelServiceContract: contracts.TravelService,
};