pragma solidity >=0.4.22 <0.6.0;
contract SimpleCoin{

    uint256 totalAmt;
    address owner;
    mapping(address=>uint256) accountMap;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Failed(string);

    modifier hasBalanceAmt(address _sourceAddress, uint256 _value){
        if (accountMap[msg.sender] >= _value) {
            _;
        }
        else
            emit Failed("Failed");
    }

    constructor() public {
        owner=msg.sender;
        totalAmt=2000000;
        accountMap[msg.sender]=totalAmt;
    }

    function totalSupply() view public returns (uint256) {
        return totalAmt;
    }


    function balanceOf(address _owner) view public returns (uint256){
        return accountMap[_owner];
    }

    function myBalance() view public returns (uint256){
        return accountMap[msg.sender];
    }

    function symbol() pure public returns(string memory){
        return "VS";
    }

    function transfer(address _to, uint256 _value) public hasBalanceAmt(msg.sender,_value) returns (bool){
        accountMap[msg.sender] -= _value;
        accountMap[_to] += _value;
        emit Transfer(msg.sender,_to,_value);
    }

}
