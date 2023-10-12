// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Stake {
    uint256 public middlePool; // Middle pool
    mapping(address => uint256) public _stakingBalance; // Staking balance for each address

    /**
     * Update deposit value
     *
     * @param _amount amount of deposit event
     */
    event Deposit(address _depositAddress, uint256 _amount);

    /**
     * Update withdraw value
     *
     * @param _amount amount of withdraw event
     */
    event Withdraw(address _withdrawAddress, uint256 _amount);

    /**
     * Set middle pool value to 0
     *
     */
    constructor() {
        middlePool = 0;
    }

    /**
     * Deposit eth to the pool
     *
     */
    function deposit() external payable {
        _stakingBalance[msg.sender] += msg.value;
        middlePool += msg.value;

        emit Deposit(msg.sender, msg.value);
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

        emit Withdraw(msg.sender, _amount);
    }
}
