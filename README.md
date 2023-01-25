This implementation helps build a Smart contract for supply chain. The objective is to build the stubs required to switch the supply chain implementations without impacting the end user.

SupplyChainContractProxy - Proxy contract is to store the references to the actual Supply chain implementation(ex SupplyChainUpd1.sol)

SupplyChainUpd1 - Actual supply chain implementation contract

Executing the code in truffle

1) Download the .sol code into the contracts folder
2) Compile the contracts by executing
        'truffle compile'
   from the command prompt
   
 ![image](https://user-images.githubusercontent.com/12578459/214450374-32a6c102-4d62-4153-b89b-ce18e315a4ff.png)
   
3) Deploy the contract to the MATIC daily Mumbai network
        'truffle deploy --reset --network matic'

4) Connect the truffle console to the MATIC network
        'truffle console --network matic'

![image](https://user-images.githubusercontent.com/12578459/214450454-deae7b98-e0df-4a48-965a-3345f521d5db.png)
        
5) Interact with the contract

![image](https://user-images.githubusercontent.com/12578459/214452826-aa9f68f7-d7b5-4202-9696-e615e32d7337.png)

![image](https://user-images.githubusercontent.com/12578459/214452161-acea8b7d-aabe-49de-baa0-877fa78a729f.png)

