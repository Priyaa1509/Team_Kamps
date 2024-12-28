// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract Booking {
    struct BookingDetails {
        uint256 serviceId;
        address userAddress;
        uint256 bookingTime;
        uint256 price;
    }

    mapping(uint256 => BookingDetails[]) public bookings; // serviceId => list of bookings

    event BookingCreated(uint256 indexed serviceId, address indexed userAddress, uint256 bookingTime, uint256 price);

    // Function to book a service
    function bookService(uint256 _serviceId, uint256 _price) public {
        BookingDetails memory newBooking = BookingDetails({
            serviceId: _serviceId,
            userAddress: msg.sender,
            bookingTime: block.timestamp,
            price: _price
        });

        bookings[_serviceId].push(newBooking);
        emit BookingCreated(_serviceId, msg.sender, block.timestamp, _price);
    }

    // Function to get bookings for a specific service
    function getBookings(uint256 _serviceId) public view returns (uint256[] memory, address[] memory, uint256[] memory, uint256[] memory) {
        BookingDetails[] memory bookingList = bookings[_serviceId];
        uint256 length = bookingList.length;

        uint256[] memory serviceIds = new uint256[](length);
        address[] memory userAddresses = new address[](length);
        uint256[] memory bookingTimes = new uint256[](length);
        uint256[] memory prices = new uint256[](length);

        for (uint256 i = 0; i < length; i++) {
            serviceIds[i] = bookingList[i].serviceId;
            userAddresses[i] = bookingList[i].userAddress;
            bookingTimes[i] = bookingList[i].bookingTime;
            prices[i] = bookingList[i].price;
        }

        return (serviceIds, userAddresses, bookingTimes, prices);
    }
}