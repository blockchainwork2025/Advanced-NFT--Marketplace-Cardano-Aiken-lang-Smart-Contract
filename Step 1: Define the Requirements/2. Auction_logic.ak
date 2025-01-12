pub type Auction = {
    nft_id: String,
    seller: Address,
    highest_bid: Option<Bid>,
    end_time: Time
}

pub type Bid = {
    bidder: Address,
    amount: Int
}

validator place_bid (ctx: ScriptContext, auction: Auction, bid: Bid) -> Bool {
    let tx = ctx.tx;

    -- Ensure auction is active
    tx.current_time < auction.end_time &&
    -- Ensure the bid is higher than the current highest bid
    match auction.highest_bid {
        None -> bid.amount > 0,
        Some(highest) -> bid.amount > highest.amount
    } &&
    -- Ensure the bid is locked in the script
    tx.outputs.any((output) -> {
        output.value.lovelace == bid.amount &&
        output.datum == { auction_id: auction.nft_id, bid }
    })
}
