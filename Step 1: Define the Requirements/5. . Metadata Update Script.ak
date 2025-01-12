validator update_metadata (ctx: ScriptContext, nft_id: String, new_metadata: String) -> Bool {
    let tx = ctx.tx;

    -- Check if the NFT owner approves the update
    tx.inputs.any((input) -> input.datum.id == nft_id) &&
    -- Update the metadata
    tx.outputs.any((output) -> output.datum.metadata == new_metadata)
}
