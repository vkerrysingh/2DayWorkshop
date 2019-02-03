pragma solidity >=0.4.22 <0.6.0;
import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";

library Library {
  struct UserAttributes {
     uint256 val;
     bool isAuth;
   }
}

contract SimpleCoin is Ownable{

    using Library for Library.UserAttributes;
    uint256 totalAmt;
    mapping(address=>Library.UserAttributes) accountMap;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Failed(string);

    constructor() public {
        totalAmt=2000000;
        accountMap[msg.sender].val=totalAmt;
        accountMap[msg.sender].isAuth = true;
    }

    modifier onlyAuthAccount(address account) {
        require(accountMap[account].isAuth);
        _;
    }

    function totalSupply() view public onlyAuthAccount(msg.sender) returns (uint256) {
        return totalAmt;
    }

    function myBalance() view public onlyAuthAccount(msg.sender) returns (uint256){
        return accountMap[msg.sender].val;
    }

    function symbol() pure public returns(string memory){
        return "VS";
    }

    function addAuthUser(address _user) public onlyAuthAccount(msg.sender) {
        accountMap[_user].isAuth = true;
    }

    function transfer(address _to, uint256 _value) public onlyAuthAccount(msg.sender) returns (bool){
        accountMap[msg.sender].val -= _value;
        accountMap[_to].val += _value;
        emit Transfer(msg.sender,_to,_value);
    }

    //Use of Ownable functions
    function balanceOfOwner(address _owner) view public onlyOwner() returns (uint256){
        return accountMap[_owner].val;
    }

    function transferOwner(address _newOwner) public {
        transferOwnership(_newOwner);
    }
}
