// Fund
// Withdraw

// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();  
        console.log("Funded FundMe with %s", SEND_VALUE);
        vm.stopBroadcast();
    }
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        fundFundMe(mostRecentlyDeployed);
    }   
}

contract WithdrawFundMe is Script {

    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        uint256 fundMeBalance = address(mostRecentlyDeployed).balance;
        FundMe(payable(mostRecentlyDeployed)).withdraw();  
        console.log("Withdraw FundMe with %s", fundMeBalance);
        vm.stopBroadcast();
    }

    function run() external {
        vm.startBroadcast();
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.stopBroadcast();
        withdrawFundMe(mostRecentlyDeployed);
    }  
}
