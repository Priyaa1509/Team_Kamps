// src/components/ReviewSystem.js
import React, { useState } from 'react';
import { reviewSystemContract, web3 } from '../contractInteractions';

const ReviewSystem = () => {
    const [serviceId, setServiceId] = useState('');
    const [reviewText, setReviewText] = useState('');

    const submitReview = async () => {
        const accounts = await web3.eth.getAccounts();
        await reviewSystemContract.methods.submitReview(serviceId, reviewText).send({ from: accounts[0] });
        alert('Review submitted successfully!');
    };

    return (
        <div>
            <h2>Submit a Review</h2>
            <input
                type="text"
                value={serviceId}
                onChange={(e) => setServiceId(e.target.value)}
                placeholder="Enter service ID"
            />
            <textarea
                value={reviewText}
                onChange={(e) => setReviewText(e.target.value)}
                placeholder="Enter your review"
            />
            <button onClick={submitReview}>Submit Review</button> {/* Corrected here */}
        </div>
    );
};

export default ReviewSystem;