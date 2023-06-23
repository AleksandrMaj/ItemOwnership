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
    mapping(address => mapping(uint256 => Item)) itemDatabase;

    struct Item {
        address owner;
        mapping(string => string) attributes;
        string[] attributeKeys;
    }
    
    constructor() {
        super;
    }

    //Item methods
    function addItemToAdress(uint256 _id, string[] memory _attributeKeys, string[] memory _attributeValues) public {
        Item storage newItem = itemDatabase[msg.sender][_id];
        newItem.owner = msg.sender;

        require(_attributeKeys.length == _attributeValues.length, "[ERROR] The length of the keys and values are note equal");

        for(uint256 i = 0; i < _attributeKeys.length; i++) {
            newItem.attributes[_attributeKeys[i]] = _attributeValues[i];
        }
        newItem.attributeKeys = _attributeKeys;
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

    }*/
}

