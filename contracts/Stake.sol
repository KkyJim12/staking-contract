// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Stake {
    uint256 public middlePool; // Middle pool
    mapping(address => uint256) public _stakingBalance; // Staking balance for each address

    struct Transaction {
        address requestAddress;
        string actionType;
        uint256 amount;
    }

    Transaction[] public transactions;

    /**
     * Update latest transaction
     *
     * @param _requestAddress address of interacting user
     * @param _actionType type of action, must be deposit or withdraw
     * @param _amount amount of transaction event
     */
    event UpdateLatestTransaction(
        address _requestAddress,
        string _actionType,
        uint256 _amount
    );

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

        Transaction memory latestTransaction;
        latestTransaction = Transaction(msg.sender, "deposit", msg.value);

        transactions.push(latestTransaction);

        emit UpdateLatestTransaction(msg.sender, "deposit", msg.value);
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

        Transaction memory latestTransaction;
        latestTransaction = Transaction(msg.sender, "withdraw", _amount);

        transactions.push(latestTransaction);

        emit UpdateLatestTransaction(msg.sender, "withdraw", _amount);
    }

    function getLatestFiveTransactions()
        public
        view
        returns (Transaction[] memory)
    {
        uint256 length = transactions.length;
        uint256 count = 5;

        // Ensure we don't try to get more elements than are available
        if (count > length) {
            count = length;
        }

        Transaction[] memory result = new Transaction[](count);
        for (uint256 i = 0; i < count; i++) {
            result[i] = transactions[length - count + i];
        }

        return result;
    }
}
