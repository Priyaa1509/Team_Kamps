// src/App.js
import React from 'react';
import './App.css'; // Import the CSS file
import TravelService from './TravelService';
import Booking from './Booking';
import ReviewSystem from './ReviewSystem';
import SimpleNFT from './SimpleNFT';
import UserRegistration from './UserRegistration';


function App() {
    return (
        <div className="container">
            <h1>NFT Marketplace and Travel Service</h1>
            <UserRegistration />
            <TravelService />
            <Booking />
            <ReviewSystem />
            <SimpleNFT />
        </div>
    );
}

export default App;