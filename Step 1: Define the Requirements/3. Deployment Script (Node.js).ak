import { BlockfrostProvider, MintingPolicy } from '@meshsdk/core';
import { readFileSync } from 'fs';

// Load compiled script
const compiledScript = JSON.parse(readFileSync('./output/listing.json', 'utf-8'));

// Initialize provider
const blockfrost = new BlockfrostProvider({
  projectId: 'your_project_id',
});

// Deploy the listing validator
const mintingPolicy = new MintingPolicy({
  type: 'PlutusV2',
  script: compiledScript.cborHex,
});

const deploy = async () => {
  const txHash = await blockfrost.submitMintingPolicy(mintingPolicy);
  console.log(`Listing validator deployed with TX hash: ${txHash}`);
};

deploy();
