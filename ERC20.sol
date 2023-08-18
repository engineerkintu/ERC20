// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

contract ERC20{
    uint256 public totalSupply;
    string public name;
    string public symbol;

    mapping(address => uint256) public balanceOf;

    constructor(string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
    } 

    function decimals() external pure returns(uint8){
        return 18;
    }

    function transfer(address recepient, uint256 amount) external returns(bool){
        require(recepient != address(0), "ERC20: transfer to zero address" );

        uint256 senderBalance = balanceOf[msg.sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

        balanceOf[msg.sender] = senderBalance - amount;
        balanceOf[recepient] += amount;

        return true;
    }
}
