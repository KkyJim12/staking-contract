// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Stake {
    uint256 public middlePool; // Middle pool
    mapping(address => uint256) _stakingBalance; // Staking balance for each address

    /**
     * Stake eth to the pool
     *
     */
    function stake() external payable {
        _stakingBalance[msg.sender] += msg.value;
        middlePool += msg.value;
    }

    /**
     * Withdraw user balance from a pool
     *
     * @param _amount balance to be withdrawed
     */
    function withdraw(uint256 _amount) external {
        require(
            _stakingBalance[msg.sender] >= _amount,
            "Not enough balance in pool."
        );

        payable(msg.sender).transfer(_amount);
        _stakingBalance[msg.sender] -= _amount;
        middlePool -= _amount;
    }
}
