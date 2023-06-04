// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//Contract to manage ofter of the contract
contract ContractOwnable {
    address owner;

    modifier isContractOwner() {
        require(msg.sender == owner, "For this you need to be the owner of the contract");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
}

contract ItemOwnership is ContractOwnable {
    mapping(address => mapping(uint256 => Item)) public itemDatabase;

    struct Item {
        address owner;
        mapping(string => string) attributes;
    }
    
    constructor() {
        super;
    }

    //Item methods
    function addItemToAdress(uint256 _id) public {

        Item storage newItem = itemDatabase[msg.sender][_id];
        newItem.owner = msg.sender;
        newItem.attributes["key1"] = "value1";

        // itemDatabase[msg.sender][_id];
    }

    // function test(uint256 _id) public view returns(Item item) { //TODO: Check how I can get the attributes
    //     return itemDatabase[msg.sender][_id];
    // }

    /*function removeItemFromAddress() public {

    }

    function updateItemFromAddress() public {

    }

    function getAllItemsFromAddress() public {

    }

    function getItemFromAddress() public {

    }

    function AddressHasItem() public {

    }

    //Item attributes
    function GetAttributesOfItem() public {

    }*/
}

