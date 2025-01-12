//we will integrate the NFT Listing, and, deploy

pub type Listing = {
    id: String,
    owner: Address,
    price: Option<Int>,
    metadata: String,   -- IPFS or metadata reference
    status: ListingStatus
}

pub type ListingStatus =
    | Active
    | Cancelled

validator list_nft (ctx: ScriptContext, listing: Listing) -> Bool {
    let tx = ctx.tx;

    -- Ensure the transaction inputs include the owner's address
    tx.inputs.any((input) -> input.address == listing.owner) &&
    -- Ensure the transaction outputs lock the NFT and price
    tx.outputs.any((output) -> {
        output.datum == listing &&
        output.value.lovelace >= 2000000
    })
}
