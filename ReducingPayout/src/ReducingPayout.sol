// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ReducingPayout {
    /*
        This exercise assumes you know how block.timestamp works.
        1. This contract has 1 ether in it, each second that goes by, 
           the amount that can be withdrawn by the caller goes from 100% to 0% as 24 hours passes.
        2. Implement your logic in `withdraw` function.
        Hint: 1 second deducts 0.0011574% from the current %.
    */

    // The time 1 ether was sent to this contract
    uint256 public immutable depositedTime;

    constructor() payable {
        depositedTime = block.timestamp;
    }

    function withdraw() public {
        require(
            address(this).balance == 1 ether,
            "The contract balance isn't 1 ether"
        );
        uint256 ellapsedTimeInSeconds = block.timestamp - depositedTime;
        if (ellapsedTimeInSeconds < 24 hours) {
            uint256 remainingAmountInGwei = 1 ether -
                (0.000011574 ether * ellapsedTimeInSeconds);
            payable(msg.sender).transfer(remainingAmountInGwei);
        }
    }
}
