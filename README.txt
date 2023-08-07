# Solidity Project - Item Ownership Contract

This Solidity project consists of a contract called `ItemOwnership`, which allows users to manage ownership and attributes of items in a decentralized manner. It also includes two other contracts, `ContractOwnable` and `ItemValidator`, to handle ownership management and validation of items, respectively.

## Contract Functionality

The `ItemOwnership` contract provides the following functionality:

1. Add an item with attributes to the address of the sender.
2. Retrieve the attributes of an item by its ID.
3. Remove an item from the address of the sender.
4. Update the attributes of an existing item.
5. Get the total number of items owned by the sender's address.
6. Retrieve a list of all item IDs owned by the sender's address.
7. Check if a specific attribute exists in any of the items owned by the sender's address.

## Contract Description

### ContractOwnable

The `ContractOwnable` contract manages the owner of the `ItemOwnership` contract. The contract contains the following function:

#### `modifier isContractOwner()`

This modifier restricts certain functions to be executed only by the owner of the contract.

### ItemValidator

The `ItemValidator` contract provides item validation functionality for the `ItemOwnership` contract. It includes the following modifiers:

#### `modifier itemIsAvailable(uint256 _id)`

This modifier checks if the item with the given ID belongs to the sender's address.

#### `modifier itemIdIsNotUsed(uint256 _id)`

This modifier ensures that the given item ID is not already in use by the sender's address.

### ItemOwnership

The `ItemOwnership` contract inherits from both `ContractOwnable` and `ItemValidator`. It enables users to create, manage, and retrieve items associated with their addresses. The contract contains the following functions:

#### `function addItemToAddress(uint256 _id, string[] memory _attributeKeys, string[] memory _attributeValues) public itemIdIsNotUsed(_id)`

This function allows the sender to add a new item with the provided ID and attributes to their address.

#### `function getAttributesOfItemByID(uint256 _id) public view itemIsAvailable(_id) returns (string[] memory, string[] memory)`

This function retrieves the attributes of an item with the given ID owned by the sender's address.

#### `function removeItemFromAddress(uint256 _id) public itemIsAvailable(_id)`

This function allows the sender to remove an item with the specified ID from their address.

#### `function updateItemFromAddress(uint256 _id, string[] memory _attributeKeys, string[] memory _attributeValues) public itemIsAvailable(_id)`

This function updates the attributes of an existing item owned by the sender's address.

#### `function getAmountOfItems() public view returns (uint256)`

This function returns the total number of items owned by the sender's address.

#### `function getAllItemsFromAddress() public view returns (uint256[] memory)`

This function returns a list of all item IDs owned by the sender's address.

#### `function AddressHasItem(string memory searchKey, string memory value) public view returns (bool)`

This function checks if any of the items owned by the sender's address has an attribute with a specific value.

## License

This contract is released under the MIT License. Please refer to the `SPDX-License-Identifier` tag at the top of the contract for more details.

## Note

This README file provides a brief overview of the functionality and structure of the Solidity project. For more detailed information about each contract and its functions, please refer to the comments and documentation within the individual contract files.
