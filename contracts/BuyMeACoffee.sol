// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

error BuyMeACoffee__PriceMustBeAboveZero();

contract BuyMeACoffee {
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    address payable i_owner;
    Memo[] s_memos;

    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    constructor() {
        i_owner = payable(msg.sender);
    }

    /**
     * @dev buy a coffee for contract owner
     * @param _name name of the coffee buyer
     * @param _message a nice message from the coffee buyer
     */
    function buyCoffee(string memory _name, string memory _message)
        public
        payable
    {
        if (msg.value <= 0) {
            revert BuyMeACoffee__PriceMustBeAboveZero();
        }

        s_memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }
}
