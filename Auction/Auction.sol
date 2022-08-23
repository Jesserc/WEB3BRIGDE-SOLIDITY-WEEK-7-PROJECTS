// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./IERC721.sol";

contract AuctionContract {
    //create an auction with an ERC721 token as prize to sell,
    //users will be able to bid for the token for a specific time frame and user with highest bid,
    // gets the token.
    ////====variables====////
    //-seller/owner address
    //-bidPrize = ERC721 token
    //-highestBid = uint
    //Bidders mapping to track bided balance
    ////====functions====////
    //-constructor to initiate some state variables ==>seller, bidPrize(address, tokenId), highestBid = startingBid(to be updated on biding)
    //-function to start bid
    //-payable function to bid
    //-function to withdraw amount bided, incase user lost the bid
    //-function to end bid and transfer bidPrize to highestBider and transfer bidAmount to seller
    //--additional
    //-function to return bid details(in the case of mapping)

    address seller;
    uint8 ID = 1;

    struct AuctionDetails {
        string title;
        IERC721 tokenBidPrize;
        uint256 highestBid;
        address highestBidder;
        bool started;
        uint256 startAt;
        bool ended;
        uint256 endAt;
    }
    struct test {
        string name;
    }

    mapping(address => uint256) bidders;
    mapping(uint256 => AuctionDetails) auctionDetail;

    constructor(
        string memory _title,
        address _tokenBidPrize,
        uint256 _startingBid
    ) {
        AuctionDetails storage auction = auctionDetail[ID];
        auction.title = _title;
        auction.tokenBidPrize = IERC721(_tokenBidPrize);
        auction.highestBid = _startingBid;
    }

    //function to start bid
    function startAuction(uint256 _endAt) external {
        AuctionDetails storage auction = auctionDetail[ID];
        require(!auction.started, "Auction already started");
        auction.startAt = block.timestamp;
        auction.started = true;
        auction.endAt = block.timestamp + (_endAt * 1 seconds);
    }

    function Bid() external payable {
        AuctionDetails storage auction = auctionDetail[ID];
        uint256 hasEnded = auction.endAt;
        uint256 hasStarted = auction.startAt;
        uint256 bid = auction.highestBid;
        require(msg.sender != address(0), "Address not valid");
        require(block.timestamp >= hasStarted, "Auction not started");
        require(block.timestamp <= hasEnded, "Auction already ended");
        require(auction.started, "Auction not started");
        require(msg.value > bid, "Amount too small");

        bidders[msg.sender] += msg.value;
        auction.highestBidder = msg.sender;
        auction.highestBid = msg.value;
    }

    function declineBid() external {
        //does this reset highest bidder? --yes, it does
        uint256 bal = bidders[msg.sender];
        bidders[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
    }

    //return bid details
    function returnBidDetails() external view returns (AuctionDetails memory) {
        return auctionDetail[ID];
    }
}
