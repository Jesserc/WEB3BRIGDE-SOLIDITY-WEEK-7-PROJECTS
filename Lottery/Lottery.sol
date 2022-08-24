// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//creating a lottery contract
//with my logic, there'll be a fixed price ETH for the lottery and users will

contract Lottery {
    uint256 lotteryPrize;
    uint256 entryFee = .05 ether;
    uint8 maxPlayer = 4;
    address immutable owner;
    address payable[] players;

    //mappings
    //mapping to check winner of a particular no. of a lottery, after the winner is picked,
    //and the money is transferred to the winner, when en
    mapping(uint32 => address payable) LotteryHistory;
    uint32 LotteryID = 1;

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

    function randomness() internal returns (uint256 randomNumber) {
        randomNumber = uint256(
            keccak256(
                abi.encode(block.timestamp, block.difficulty, players.length)
            )
        );
    }

    function pickWinner() external {
        uint256 index = randomness() % players.length;
        players[index].transfer(address(this).balance);

        LotteryHistory[LotteryID] = players[index];
        LotteryID++;

        // reset the state of the contract
        players = new address payable[](0);
    }

    function returnLotteryHistory(uint32 id) public view returns (address) {
        return LotteryHistory[id];
    }
}
