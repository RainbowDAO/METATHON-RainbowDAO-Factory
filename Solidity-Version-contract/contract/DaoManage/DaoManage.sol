pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "../interface/IAuthority.sol";
import "../interface/IVault.sol";
import "../interface/IERC20.sol";
import "../interface/IDaoFactory.sol";
import {Set} from "../lib/TokenSet.sol";

contract DaoManage{
    using Set for Set.Address;
    address public creator;
    address public factory;
    address public auth;
    address public vault;
    string  name;
    string  logo;
    string  des;
    uint public voteId;
    uint public support;
    uint public index;
    
    mapping(address => string) public memberName;
    mapping(address => bool) public moderators;
    mapping(uint => Proposal) public proposalInfo;
    mapping(uint => mapping(address => bool)) public voters;
    
    struct Proposal{
        uint voteId;
        bool executed;
        string title;
        string description;
        
        uint startTime;
        uint endTime;
        uint voteTime;
        uint supportAmount;
        uint refuseAmount;
        uint minAmount;
        address erc20;
        address to;
        uint amount;
    }
    
    Set.Address applying;
    Set.Address members;
    Proposal[] public proposalArray;
    
    constructor(address _creator,address _factory,string memory _name,string memory _logo, string memory _des, uint _support) public {
        creator = _creator;
        factory = _factory;
        support = _support;
        // auth = IAuthority(_auth);
        // vault = _vault;
        
        name = _name;
        logo = _logo;
        des = _des;
        members.add(_creator);
    }
    
    modifier onlyManage(){
        require(msg.sender == creator || moderators[msg.sender], "No permisstion");
        _;
    }
    
    function applyJoin(address addr) public returns(bool){
        require(!members.contains(addr),"Is memeber");
        require(!applying.contains(addr),"Applying");
        applying.add(addr);
        return true;
    }
    
    function approveApply(address addr) public returns(bool){
        require(msg.sender == creator || IAuthority(auth).hasAuthority(msg.sender,"DaoManage","approveApply"));
        applying.remove(addr);
        members.add(addr);
        IDaoFactory(factory).changeMemberNumber(index,addr);
        return true;
    }
    
    function vetoApply(address addr) public returns(bool){
        require(msg.sender == creator || IAuthority(auth).hasAuthority(msg.sender,"DaoManage","vetoApply"));
        applying.remove(addr);
        return true;
    }
    
    
    function newProposal(string calldata title, string calldata description, uint endTime, uint voteTime, uint minAmount,address token, address to, uint amount) external {
        // require(IAuthority(auth).hasAuthority(msg.sender,"DaoManage","newProposal"));
        // require(members.contains(msg.sender),"Not member");
        
        //auth or tokenNumber
        Proposal memory pro = Proposal({
            voteId: voteId,
            executed: false,
            title: title,
            description: description,
            startTime: block.timestamp,
            endTime: endTime,
            voteTime: voteTime,
            supportAmount: 0,
            refuseAmount: 0,
            minAmount: minAmount,
            erc20: token,
            to: to,
            amount: amount
        });
        
        proposalInfo[voteId] = pro;
        proposalArray.push(pro);
        voteId++;
    }
    
    function vote(uint _voteId,address _account, uint number) public returns(bool){
        require(_voteId <= voteId,"Not exsited");
        require(members.contains(_account),"Not member");
        // require(proposalInfo[voteId].endTime >= block.timestamp && proposalInfo[voteId].executed == false, "expired");
        require(!voters[_voteId][_account]);
        require(number == 1 || number == 2,"error param");
        
        
        if(number == 1){
            proposalInfo[_voteId].supportAmount = proposalInfo[_voteId].supportAmount+1;
        }
        if(number == 2){
            proposalInfo[_voteId].refuseAmount = proposalInfo[_voteId].refuseAmount+1;
        }
        voters[_voteId][_account] = true;
        if(proposalInfo[_voteId].supportAmount >= proposalInfo[_voteId].minAmount){
            // IVault(vault).withdraws(proposalInfo[_voteId].erc20,proposalInfo[_voteId].to,proposalInfo[_voteId].amount);
            IERC20(proposalInfo[_voteId].erc20).transferFrom(vault,proposalInfo[_voteId].to,proposalInfo[_voteId].amount);
            proposalInfo[_voteId].executed = true;
        }
        return true;
    }
    
    function execute(uint _voteId) external {
        // require(_voteId <= voteId,"Not exsited");
        // require(!proposalInfo[_voteId].executed);
        // require(proposalInfo[_voteId].supportAmount != 0);
        // require(proposalInfo[_voteId].supportAmount >= proposalInfo[_voteId].minAmount);
        // support
        // IVault(vault).withdraw(proposalInfo[_voteId].erc20,proposalInfo[_voteId].to,proposalInfo[_voteId].amount);
        // proposalInfo[_voteId].executed = true;
    }
    
    // function test(address token,address vault,address to, uint amount) public{
    //     IERC20(token).transferFrom(vault,to,amount);
    // }
    
   

    function getProposalByVoteId(uint voteId) public view returns(Proposal memory){
        return proposalArray[voteId];
    }
    
    function init(address _auth, address _vault,uint _index) public {
        require(msg.sender == factory,"only factory");
        auth = _auth;
        vault = _vault;
        index = _index;
    }
    
    
    function getApplyingLength() public view returns(uint){
        return applying.length();
    }
    
    function getProposalLength() public view returns(uint){
        return proposalArray.length;
    }
    
    function getProposalInfo(uint index) public view returns(Proposal memory){
        return proposalInfo[index];
    }
    
    function getApplyingByIndex(uint index) public view returns(address){
        return applying.at(index);
    }
    
    function getMemberLength() public view returns(uint){
        return members.length();
    }
    
    function getMemberByIndex(uint index) public view returns(address){
        return members.at(index);
    }
    
}


