// SPDX-License-Identifier: MIT
pragma solidity 0.8.*;

/*
   Project Requirement:
   Write a smart contract that implements the require(), assert() and revert() statements.
*/

contract MyToken {
    //private vaiables
    uint private ownerCode;
    address private owner;
    // public variables 
    struct token{
        string Name;
        string Abbrv;
        uint   TotalSupply;
    }
    token public coin;

    // mapping variable here
    mapping(address=>uint256) private balances;
    mapping(address => mapping(address=>bool)) private isPresent;

    constructor(){
        ownerCode = 143;
        owner = msg.sender;
        coin.Name = "borjalFuncErrs";
        coin.Abbrv = "borjalFE";
    }
    modifier IsOwner() {
        require(msg.sender == owner, "You do not own this token.");
        _;
    }
    function getCode() public view IsOwner returns (uint) {
        return ownerCode;
    }
    // mint function
    function mint(uint _val) external{
        address _addr = msg.sender;
        balances[_addr] += _val;
        coin.TotalSupply += _val;
        isPresent[_addr][address(this)] = true;
    }    
    // burn function
    function burn (uint _val) external{
        address _addr = msg.sender;
        assert(isPresent[_addr][address(this)]);
        if(balances[_addr] < _val){
            revert("Error: Balance is less than amount to be burned.");
        }else if(balances[_addr] >= _val){
            balances[_addr] -= _val;
            coin.TotalSupply -= _val;
            if(balances[_addr] == 0){
                isPresent[_addr][address(this)] = false;
                delete balances[_addr];
            }
        } 
    }
}