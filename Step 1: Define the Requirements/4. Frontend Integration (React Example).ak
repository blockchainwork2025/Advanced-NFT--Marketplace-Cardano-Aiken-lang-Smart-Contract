import { useWallet } from '@meshsdk/react';
import { Transaction } from '@meshsdk/core';

function App() {
  const { connected, connect, wallet } = useWallet();

  const listNFT = async () => {
    if (!connected) {
      await connect();
    }

    const tx = new Transaction();
    tx.addOutput({
      address: 'script_address', // Address of the smart contract
      value: { lovelace: '2000000' }, // Minimum ADA
      datum: {
        json: {
          id: 'nft123',
          owner: wallet.address,
          price: 5000000,
          metadata: 'ipfs://someHash',
          status: 'Active',
        },
      },
    });

    const signedTx = await wallet.signTx(tx);
    const txHash = await wallet.submitTx(signedTx);
    console.log(`Transaction submitted: ${txHash}`);
  };

  return (
    <div>
      <button onClick={listNFT}>List NFT</button>
    </div>
  );
}

export default App;
