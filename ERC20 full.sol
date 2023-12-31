// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

contract ERC20{
    uint256 public totalSupply;
    string public name;
    string public symbol;

    mapping(address => uint256) public balanceOf;

    //mapping which maps from owner's address to spender address to the allowance value
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
    } 

    function decimals() external pure returns(uint8){
        return 18;
    }

    function transfer(address recepient, uint256 amount) external returns(bool){
        return _transfer(msg.sender, recepient, amount);
    }

    function transferFrom(address sender, address recepient, uint256 amount) external returns(bool){
        uint256 currentAllowance = allowance[sender][msg.sender];

        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");

        allowance[sender][msg.sender] = currentAllowance - amount;

        return _transfer(sender, recepient, amount);
    }

    function approve(address spender, uint256 amount) external returns(bool){
        require(spender != address(0), "ERC20: approve to the zero address");

        allowance[msg.sender][spender] = amount;

        return true;

    }

    function _transfer(address sender, address recepient, uint256 amount) private returns(bool){
        require(recepient != address(0), "ERC20: transfer to zero address" );

        uint256 senderBalance = balanceOf[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

        balanceOf[sender] = senderBalance - amount;
        balanceOf[recepient] += amount;

        return true;
    }
}
