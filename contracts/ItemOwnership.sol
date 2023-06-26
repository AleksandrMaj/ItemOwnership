// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//Contract to manage ofter of the contract
contract ContractOwnable {
    address owner;

    modifier isContractOwner() {
        require(
            msg.sender == owner,
            "For this you need to be the owner of the contract"
        );
        _;
    }

    constructor() {
        owner = msg.sender;
    }
}

contract ItemValidator {
    mapping(address => mapping(uint256 => Item)) itemDatabase;

    struct Item {
        address owner;
        mapping(string => string) attributes;
        string[] attributeKeys;
    }

    modifier itemIsAvailable(uint256 _id) {
        require(
            itemDatabase[msg.sender][_id].owner == msg.sender,
            "[ERROR] ID not available"
        );
        _;
    }

    modifier itemIdIsNotUsed(uint256 _id) {
        require(
            itemDatabase[msg.sender][_id].owner != msg.sender,
            "[ERROR] ID always in use"
        );
        _;
    }
}

contract ItemOwnership is ContractOwnable, ItemValidator {
    constructor() {
        super;
    }

    //Item methods
    function addItemToAdress(
        uint256 _id,
        string[] memory _attributeKeys,
        string[] memory _attributeValues
    ) public itemIdIsNotUsed(_id) {
        require(
            _attributeKeys.length == _attributeValues.length,
            "[ERROR] The length of the keys and values are note equal"
        );

        Item storage newItem = itemDatabase[msg.sender][_id];
        newItem.owner = msg.sender;

        for (uint256 i = 0; i < _attributeKeys.length; i++) {
            newItem.attributes[_attributeKeys[i]] = _attributeValues[i];
        }
        newItem.attributeKeys = _attributeKeys;
    }

    function getAttributesOfItemByID(uint256 _id)
        public
        view
        itemIsAvailable(_id)
        returns (string[] memory, string[] memory)
    {
        Item storage item = itemDatabase[msg.sender][_id];
        string[] memory attributeValues = new string[](
            item.attributeKeys.length
        );

        for (uint256 i = 0; i < item.attributeKeys.length; i++) {
            attributeValues[i] = item.attributes[item.attributeKeys[i]];
        }
        return (item.attributeKeys, attributeValues);
    }

    function removeItemFromAddress(uint256 _id) public itemIsAvailable(_id) {
        delete itemDatabase[msg.sender][_id];
    }

    function updateItemFromAddress(
        uint256 _id,
        string[] memory _attributeKeys,
        string[] memory _attributeValues
    ) public itemIsAvailable(_id) {
        require(
            _attributeKeys.length == _attributeValues.length,
            "[ERROR] The length of the keys and values are note equal"
        );
        
        Item storage item = itemDatabase[msg.sender][_id];
        item.owner = msg.sender;

        for (uint256 i = 0; i < _attributeKeys.length; i++) {
            item.attributes[_attributeKeys[i]] = _attributeValues[i];
        }
        item.attributeKeys = _attributeKeys;
    }

    /*function getAllItemsFromAddress() public {

    }

    function getItemFromAddress() public {

    }

    function AddressHasItem() public {

    }*/
}
