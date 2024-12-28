// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract TravelService {
    struct Service {
        uint256 id;
        string name;
        string description;
        address owner;
        uint256 price;
        bool isActive;
    }

    mapping(uint256 => Service) public services;
    uint256 public serviceCount;

    // Function to get service details
    function getService(uint256 _id) public view returns (uint256, string memory, string memory, address, uint256, bool) {
        Service storage service = services[_id];
        return (service.id, service.name, service.description, service.owner, service.price, service.isActive);
    }
}