// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

contract ReviewSystem {
    struct Review {
        uint256 serviceId;
        address reviewer;
        string comment;
        uint8 rating; // 1 to 5
    }

    mapping(uint256 => Review[]) public reviews; // serviceId => list of reviews

    event ReviewAdded(uint256 indexed serviceId, address indexed reviewer, string comment, uint8 rating);

    // Function to add a review
    function addReview(uint256 _serviceId, string memory _comment, uint8 _rating) public {
        require(_rating >= 1 && _rating <= 5, "Rating must be between 1 and 5");
        reviews[_serviceId].push(Review({
            serviceId: _serviceId,
            reviewer: msg.sender,
            comment: _comment,
            rating: _rating
        }));
        emit ReviewAdded(_serviceId, msg.sender, _comment, _rating);
    }

    // Function to get reviews for a specific service
    function getReviews(uint256 _serviceId) public view returns (uint256[] memory, address[] memory, string[] memory, uint8[] memory) {
        Review[] storage reviewList = reviews[_serviceId];
        uint256 length = reviewList.length;

        uint256[] memory serviceIds = new uint256[](length);
        address[] memory reviewers = new address[](length);
        string[] memory comments = new string[](length);
        uint8[] memory ratings = new uint8[](length);

        for (uint256 i = 0; i < length; i++) {
            serviceIds[i] = reviewList[i].serviceId;
            reviewers[i] = reviewList[i].reviewer;
            comments[i] = reviewList[i].comment;
            ratings[i] = reviewList[i].rating;
        }

        return (serviceIds, reviewers, comments, ratings);
    }
}