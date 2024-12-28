// src/components/UserRegistration.js
import React, { useState } from 'react';
import { userRegistrationContract, web3 } from '../contractInteractions';

const UserRegistration = () => {
    const [username, setUsername] = useState('');

    const registerUser  = async () => {
        const accounts = await web3.eth.getAccounts();
        await userRegistrationContract.methods.register(username).send({ from: accounts[0] });
        alert('User  registered successfully!');
    };

    return (
        <div>
            <h2>User Registration</h2>
            <input
                type="text"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                placeholder="Enter username"
            />
            <button onClick={registerUser }>Register</button>
        </div>
    );
};

export default UserRegistration;