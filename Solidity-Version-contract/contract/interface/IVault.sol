pragma solidity ^0.6.0;

interface IVault {
    function deposit(address token, uint amount) external view returns(bool);

    function withdraws(address token,address to, uint amount) external;

    function getTokenAddr(uint _index) external view returns(address);

    function tokenIfExisted(address _addr) external view returns(bool);
    
    function addToken(address _addr) external;
    function approve(address _addr,address _account) external;
}