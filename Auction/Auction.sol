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

    struct BidDetails {
        string title;
        IERC721 tokenBidPrize;
        uint256 highestBid;
        uint256 highestBidder;
        bool started;
        uint256 startAt;
        bool ended;
        uint256 endAt;
    }

    mapping(address => uint256) bidders;
    mapping(uint256 => BidDetails) bidDetails;

    constructor(string memory _title, address _tokenBidPrize) {
        BidDetails storage bid = bidDetails[ID];
        bid.title = _title;
        bid.tokenBidPrize = IERC721(_tokenBidPrize);
    }

    //function to start bid
    function startBid(uint256 _endAt) external {
        BidDetails storage bid = bidDetails[ID];
        require(!bid.started, "Bid already started");
        bid.startAt = block.timestamp;
        bid.started = true;
        bid.endAt = block.timestamp + (_endAt * 1 seconds);
    }

    function bid() external {}

    //return bid details
    function returnBidDetails() external view returns (BidDetails memory) {
        return bidDetails[ID];
    }
}
