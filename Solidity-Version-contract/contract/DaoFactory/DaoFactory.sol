pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "../Vault/Vault.sol";
import "../DaoManage/DaoManage.sol";
import "../Authority/Authority.sol";
// import "../lib/ERC20MODEL.sol";
import "../interface/IERC20MODEL.sol";
import "../interface/IDaoManage.sol";
import "../interface/IVault.sol";

contract DaoFactory{
    address public owner;
    address public erc20Factory;
    uint public index;
    
    struct DaoInfo{
        string name;
        string logo;
        string des;
        address authority;
        address manage;
        address vault;
    }
    mapping(address => uint[]) public userDaos;
    mapping(address => bool) public manageAllow;
    DaoInfo[] public array;
    
    constructor(address _owner,address _erc20Factory) public {
        owner = _owner;
        erc20Factory = _erc20Factory;
    }
    
    modifier onlyOnwer(){
        require(msg.sender == owner, "only owner");
        _;
    }
    
    function creatDaoWithNewToken(string memory _name,string memory _logo,string memory _des,string memory _tokenName,string memory _symble,uint8 _decimals, uint _totalSupply, uint _support) public {
        require(msg.sender != address(0), "Invalid address");
        address _manage = address(new DaoManage(msg.sender,address(this),_name,_logo,_des,_support));
        address _auth = address(new Authority(msg.sender,_manage));
        address _vault = address(new Vault(msg.sender,address(this),_manage, _auth));
        address _erc20 = IERC20MODEL(erc20Factory).creatToken(_name,_symble,_decimals,_vault,_totalSupply);
      
        DaoInfo memory addr = DaoInfo({
            name: _name,
            logo: _logo,
            des: _des,
            authority: _auth,
            manage: _manage,
            vault: _vault
        });
        
        array.push(addr);
        userDaos[msg.sender].push(index);
        
        manageAllow[_manage] = true;
        IDaoManage(_manage).init(_auth,_vault,index);
        IVault(_vault).addToken(_erc20);
        index++;
    }
    
    function creatDao(string memory _name,string memory _logo,string memory _des,address _token, uint _support) public {
        require(msg.sender != address(0), "Invalid address");
        address _manage = address(new DaoManage(msg.sender,address(this),_name,_logo,_des,_support));
        address _auth = address(new Authority(msg.sender,_manage));
        address _vault = address(new Vault(msg.sender,address(this),_manage, _auth));
        
        DaoInfo memory addr = DaoInfo({
            name: _name,
            logo: _logo,
            des: _des,
            authority: _auth,
            manage: _manage,
            vault: _vault
        });
        
        array.push(addr);
        userDaos[msg.sender].push(index);
        
        manageAllow[_manage] = true;
        IDaoManage(_manage).init(_auth,_vault,index);
        IVault(_vault).addToken(_token);
        index++;
    }
    
    function getArrayLength() public view returns(uint){
        return array.length;
    }
    
    function getDaoInfo(uint index) public view returns(DaoInfo memory){
        return array[index];
    }
    
    function getOwnedDaos() public view returns(uint[] memory){
        return userDaos[msg.sender];
    }
    
    function changeMemberNumber(uint _index,address _addr) public {
        // require(manageAllow[msg.sender])
        userDaos[_addr].push(_index);
    }
    
}