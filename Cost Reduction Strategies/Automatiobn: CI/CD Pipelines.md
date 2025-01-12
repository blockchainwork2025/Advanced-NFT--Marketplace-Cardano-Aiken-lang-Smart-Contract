### Automation: CI/CD Pipelines

CI/CD with GitHub Actions

Automate contract compilation, testing, and deployment using GitHub Actions.

Create a .github/workflows/aiken-pipeline.yml file:


....
yaml

name: Aiken CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  build-and-test:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Install Aiken
      run: |
        curl -L https://aiken-lang.org/install.sh | sh
        echo "Aiken installed successfully."

    - name: Build Contracts
      run: aiken build --optimize

    - name: Test Contracts
      run: aiken check

  deploy:
    runs-on: ubuntu-latest
    needs: build-and-test

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Deploy Contracts
      env:
        BLOCKFROST_PROJECT_ID: ${{ secrets.BLOCKFROST_PROJECT_ID }}
      run: |
        node deploy-scripts.js
        echo "Contracts deployed successfully."

...
# Store Secrets Securely
Add BLOCKFROST_PROJECT_ID in GitHub Secrets for secure access.

### Additional Cost-Saving Deployment Techniques

Test on Local Network
Before deploying to the Preview Testnet, test contracts on a local Cardano node:

1. Set up a local Cardano testnet using Cardano Node.
2. Use cardano-cli to simulate deployment without fees.

## Batch Listing Deployments
Instead of deploying each NFT listing individually, batch them into a single deployment:

...
javascript


const deployMultipleListings = async (listings) => {
  const tx = new Transaction();
  listings.forEach((listing) => {
    tx.addOutput({
      address: contractAddress,
      value: { lovelace: '2000000' },
      datum: listing,
    });
  });

  const signedTx = await wallet.signTx(tx);
  const txHash = await wallet.submitTx(signedTx);
  console.log(`Batch listings deployed! TX hash: ${txHash}`);
};
...