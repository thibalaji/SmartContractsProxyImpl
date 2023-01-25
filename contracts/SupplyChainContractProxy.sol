/** 
The purpose of this proxy is to help deploy versions of the actual smart contract(s) without impacting the end user
*/

//pragma solidity ^0.8.6;
pragma solidity >=0.6.2 <0.9.0;
import "truffle/console.sol";
//import "hardhat/console.sol";

contract SupplyChainContractProxy {

  //two assembly memory slots locations
  address private constant Proxy_Address = address(0); //0x626c756500000000000000000000000000000000000000000000000000000000; 
  address private constant SupplyChainAddress = address(0); //0x626c756500000000000000000000000000000000000000000000000000000000;

 
  constructor() public 
  {
    address slot = Proxy_Address;
    address _admin = msg.sender;
    assembly {    
      sstore(slot, _admin)
    }
  }

 
  //address of the owner
  function getProxyAddress() public view returns (address owner) 
  {
	console.log("getProxyAddress() called", gasleft());
    address slot = Proxy_Address;
    assembly {
      owner := sload(slot)
    }
  }

 
  //address of the contract with business console.logic
  function getSupplyChainContract() public view returns (address actualContractAddr) 
  {
	console.log("getSupplyChainContract() called", gasleft());
    address slot = SupplyChainAddress;
    assembly {
      actualContractAddr := sload(slot)
    }
  }


  //function used to change the address of the contract containing business console.logic
  
  function updateSupplyChainContractRef(address newContract) external 
  {
	console.log("updateSupplyChainContractRef() called", gasleft());
    //verify the sender is the admin
    require(msg.sender == getProxyAddress(), 'You must be an owner to change the contract');
    address slot = SupplyChainAddress;
    assembly 
	{
      //store in memory the new address
      sstore(slot, newContract)
    }
  }

 
//user calls a function that does not exist in this contract so the fallback function is called
//assembly is used



  function fallback() external payable 
  {
  
	require(msg.sender != getProxyAddress(), 'fallbackcalled');
  
	address addr = SupplyChainAddress;
	
	assembly
	{
		calldatacopy(0,0,calldatasize())
		let result := delegatecall(gas(),addr,0,calldatasize(),0,0)
		returndatacopy(0,0,returndatasize())
		switch result
		case 0 { revert(0, returndatasize()) }
		default { return(0,returndatasize()) }
	}
	
  }

  fallback() external payable 
  {
	//console.log("fallback() called", gasleft());
	//SupplyChainAddress.delegatecall(
	address _target = SupplyChainAddress;
	//code in Yul
    assembly 
	{
		/*
		get the address of the contract that contains business console.logic
		save address in temporary memory 
		*/	  
		//let _target := sload(SupplyChainAddress)      

		/*
		copy the function call in memory
		first parameter is the memory slot we want to copy the function call to
		second parameter is the memory slot we want to copy from
		third parameter is the size we want to copy which is all data 
		*/
		//calldatacopy(0x0, 0x0, calldatasize())

		/*
		https://eips.ethereum.org/EIPS/eip-7#parameters
		forward the call to the smart contract that contains the business console.logic
		specify the 
			gas,  (amount of gas the code may use in order to execute)
			address of contract,  (destination address whose code is to be executed)
			in_offset, (the offset into memory of the input)
			in_size, (the size of the input in bytes)
			out_offset, (the offset into memory of the output)		
			out_size, (the size of the scratch pad for the output)			
		if the call is successful it will be stored in the bool result 
		*/
		let result := delegatecall(gas(), _target, 0x0, calldatasize(), 0x0, 0)
		
		
		//~delegate_call(msg.gas,  _target, 0, ~calldatasize(), ~calldatasize, 10000)
		//delegatecall(gas(), _target, 0, calldatasize(), 0, 0)
		//let result := delegate_call(gas(), _target, 0x0, calldatasize(), 0x0, 10000)
		//(bool result, bytes memory data) = _target.delegatecall(0x0, calldatasize(), calldatacopy)
		//return(calldatasize(), 10000)

		//copy the return data into memory
		returndatacopy(0x0, 0x0, returndatasize())

		//if the result is 0 and failed then revert
		//switch result case 0 {revert(0, 0)} default 
		//{
		//	return (0, returndatasize())
		//}
    }
  }
}