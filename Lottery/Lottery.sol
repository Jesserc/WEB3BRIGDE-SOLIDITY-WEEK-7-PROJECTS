// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//creating a lottery contract
//with my logic, there'll be a fixed price ETH for the lottery and users will

contract Lottery {
    uint256 lotteryPrize;
    uint256 public entryFee = .05 ether;
    uint8 public maxPlayer = 4;
    uint256 public luckyPlayerIndex;
    address immutable owner;
    address payable[] public players;

    //mappings
    //mapping to check winner of a particular ID of a lottery, after the winner is picked.
    mapping(uint32 => address payable) LotteryHistory;
    uint32 LotteryID = 1;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() payable {
        owner = msg.sender;
        lotteryPrize = msg.value;
    }

    function getLotteryPrize() external view returns (uint256) {
        return lotteryPrize;
    }

    function enterLottery() external payable {
        require(msg.sender != owner, "Error: owner can't play");
        require(msg.value >= entryFee, "Error: minimum entry amount not met");
        require(
            players.length < maxPlayer,
            "Error: max number of player reached"
        );

        players.push(payable(msg.sender));
    }

    function randomness() public view onlyOwner returns (uint256 randomNumber) {
        randomNumber = uint256(
            keccak256(
                abi.encode(block.timestamp, block.difficulty, players.length)
            )
        );
    }

    function pickWinner() external onlyOwner {
        uint256 index = randomness() % players.length;
        luckyPlayerIndex = index;
        players[index].transfer(address(this).balance);

        LotteryHistory[LotteryID] = players[index];
        LotteryID++;

        // reset the state of the contract
        players = new address payable[](0);
    }

    function returnLotteryHistory(uint32 id) public view returns (address) {
        return LotteryHistory[id];
    }

    function returnBalance() external view onlyOwner returns (uint256) {
        return address(this).balance;
    }
}
