pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import {StructTypes} from '../lib/StructTypes.sol';
import './RouteManage.sol';
//Is not enabled
contract Vote {
    
   event voteToManager(address voter,address receiver,uint amount);
   event voteToMsManagerEvent(address voter,address receiver,uint amount);

   function vote() public {

   }

   function voteToMsManager() public {
         
   }
    
   function endManagerVote() public {
         
     // require(block.timestamp >  ,'Unexpired');
        
   }
    

}
