// src/components/TravelService.js
import React, { useState } from 'react';
import { travelServiceContract, web3 } from '../contractInteractions';

const TravelService = () => {
    const [serviceName, setServiceName] = useState('');

    const addService = async () => {
        const accounts = await web3.eth.getAccounts();
        await travelServiceContract.methods.addService(serviceName).send({ from: accounts[0] });
        alert('Service added successfully!');
    };

    return (
        <div>
            <h2>Add Travel Service</h2>
            <input
                type="text"
                value={serviceName}
                onChange={(e) => setServiceName(e.target.value)}
                placeholder="Enter service name"
            />
            <button onClick={addService}>Add Service</button>
        </div>
    );
};

export default TravelService;