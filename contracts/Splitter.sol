pragma solidity ^0.4.11;

contract Owner{

address owner;

function Owner(){
	owner= msg.sender;
}	
modifier checkOwner(){
	require(msg.sender==owner);
	_;
}
function Kill () checkOwner{
selfdestruct(owner);
}
}

contract Splitter is Owner{
	
	struct Group{
		address senderAdd;
		address firstReceiverAdd;
		address secondReceiverAdd;
	}

//Group[] groups;
mapping (address => Group) groups;
mapping (address => uint) public balances;

//initialize the first group and owner
function Splitter(address _sender,address _firstReceiver, address _secondReceiver){
	groups[_sender] = Group(_sender,_firstReceiver,_secondReceiver);
}

//only owner can add other groups, it can be changed to be open as well
function addGroup (address _sender,address _firstReceiver, address _secondReceiver) public checkOwner{
   groups[_sender] = Group(_sender,_firstReceiver,_secondReceiver);
}

function split () payable public{
	
	Group storage currentGroup= groups[msg.sender];
	
	assert(msg.value%2==0&&msg.value>1);
	assert(currentGroup.senderAdd!=0);

	uint amountSplitted = msg.value/2;
	balances[currentGroup.firstReceiverAdd]=balances[currentGroup.firstReceiverAdd]+amountSplitted;
	balances[currentGroup.secondReceiverAdd]=balances[currentGroup.secondReceiverAdd]+amountSplitted;
	

}



function withdrawBalance() public returns(bool done){
	assert(balances[msg.sender]>0);
	msg.sender.transfer(balances[msg.sender]);
	balances[msg.sender] = 0;
	return true;


}

}