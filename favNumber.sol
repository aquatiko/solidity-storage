pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

// This contract allows owner to set allowed user and those users can store/retreive a favourite number of their choice.
// Onwer can see fav number of all users but can't set them.


contract Storage{

    mapping(address => bool) allowedUsers;
    address owner;

    mapping(address => uint) favNum;

    constructor(){
        console.log("owner set to", msg.sender);
        owner = msg.sender;
        allowedUsers[msg.sender] = true; // owner is allowed by default
    }

    function addUsers(address userAddress) public isOwner {
        allowedUsers[userAddress] = true;
    }

    function setFavNumber(uint num) public isAllowed {
        favNum[msg.sender] = num;
    }

    function getFavNumberByAddress(address userAddress) public view authenticateUser(userAddress) returns(uint){
        return favNum[userAddress];
    }

    modifier isOwner{
        require(msg.sender == owner, "Only owner is allowed for this operation");
        _;
    }

    modifier authenticateUser(address userAddress){
        require((msg.sender == userAddress) || (msg.sender == owner), "User can't access other user's data");
        _;
    }

    modifier isAllowed{
        require(allowedUsers[msg.sender] == true, "User not allowed for operation");
        _;
    }
}
