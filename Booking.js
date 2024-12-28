// src/components/Booking.js
import React, { useState } from 'react';
import { bookingContract, web3 } from '../contractInteractions';

const Booking = () => {
    const [serviceId, setServiceId] = useState('');

    const bookService = async () => {
        const accounts = await web3.eth.getAccounts();
        await bookingContract.methods.bookService(serviceId).send({ from: accounts[0] });
        alert('Service booked successfully!');
    };

    return (
        <div>
            <h2>Book a Service</h2>
            <input
                type="text"
                value={serviceId}
                onChange={(e) => setServiceId(e.target.value)}
                placeholder="Enter service ID"
            />
            <button onClick={bookService}>Book Service</button>
        </div>
    );
};

export default Booking;