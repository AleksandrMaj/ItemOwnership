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
        string[] attributeKeys;
    }
    
    constructor() {
        super;
    }

    //Item methods
    function addItemToAdress(uint256 _id) public {

        Item storage newItem = itemDatabase[msg.sender][_id];
        newItem.owner = msg.sender;
        newItem.attributes["key1"] = "value1"; //TODO: Be able to determine own attributes
        newItem.attributes["key2"] = "value2";
        newItem.attributeKeys.push("key1");
        newItem.attributeKeys.push("key2");
    }

    function getAttributesOfItemByID(uint256 _id) public view returns(string[] memory, string[] memory) {
        Item storage item = itemDatabase[msg.sender][_id];
        string[] memory attributeValues = new string[](item.attributeKeys.length);

        for(uint256 i = 0; i < item.attributeKeys.length; i++) {
            attributeValues[i] = item.attributes[item.attributeKeys[i]];
        }
        return (item.attributeKeys, attributeValues);
    }

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

