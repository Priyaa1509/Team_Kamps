// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract UserRegistration {
    struct User {
        address userAddress;
        string name;
        string email;
        bool isRegistered;
    }

    mapping(address => User) public users;

    event UserRegistered(address indexed userAddress, string name, string email);

    // Function to register a user
    function registerUser (string memory _name, string memory _email) public {
        require(!users[msg.sender].isRegistered, "User  already registered");
        
        users[msg.sender] = User({
            userAddress: msg.sender,
            name: _name,
            email: _email,
            isRegistered: true
        });

        emit UserRegistered(msg.sender, _name, _email);
    }

    // Function to get user details
    function getUserDetails() public view returns (string memory name, string memory email) {
        require(users[msg.sender].isRegistered, "User  not registered");
        User memory user = users[msg.sender];
        return (user.name, user.email);
    }
}