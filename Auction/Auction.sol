// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract AuctionContract {
    //create an auction with an ERC721 token as prize to sell,
    //users will be able to bid for the token for a specific time frame and user with highest bid,
    // gets the token.
    ////====variables====////
    //-seller/owner address
    //-bidPrize = ERC721 token
    //-highestBid = uint
    //highestBidders mapping to track bided balance
    ////====functions====////
    //-constructor to initiate some state variables ==>seller, bidPrize(address, tokenId), highestBid = startingBid(to be updated on biding)
    //-function to start bid
    //-payable function to bid
    //-function to withdraw amount bided, incase user lost the bid
    //-function to end bid and transfer bidPrize to highestBider and transfer bidAmount to seller
    //--additional
    //-function to return bid details(in the case of mapping)

    struct BidDetails {
        bytes18 title;
    }

    function returnBidDetails() external view returns (BidDetails storage) {
        return BidDetails;
    }
}
