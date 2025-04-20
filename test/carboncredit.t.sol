// // SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {ChemotronixManager} from "../src/carboncredit.sol";

contract ChemotronixTest is Test {
    ChemotronixManager public chemotronix;

    function setUp() public {
        chemotronix = new ChemotronixManager();
        chemotronix.verifyProject("project1");
        chemotronix.verifyProject("project2");
        chemotronix.verifyProject("project3");
        chemotronix.verifyProject("project4");
    }

    function test_VerifiedProject() public view {
        assertTrue(chemotronix.verifiedProjects("project1"));
        assertTrue(chemotronix.verifiedProjects("project2"));
        assertTrue(chemotronix.verifiedProjects("project3"));
        assertTrue(chemotronix.verifiedProjects("project4"));
    }

    // function test_Mint() public {
    //     uint256 initialBalance = chemotronix.balanceOf(address(this));
    //     chemotronix.mint("project1", 100);
    //     uint256 newBalance = chemotronix.balanceOf(address(this));
    //     assertEq(newBalance, initialBalance + 100);
    //     assertEq(chemotronix.getProjectBalance("project1"), 100);
    //     assertEq(chemotronix.getPersonalProjectBalance("project1"), 100);
    //     assertEq(chemotronix.getProjectBalance("project2"), 0);
    // }


    // function test_TransferCredits() public {
    //     chemotronix.mint("project1", 100);
    //     address recipient = address(0x123);
    //     uint256 initialSenderBalance = chemotronix.getPersonalProjectBalance("project1");
    //     uint256 initialRecipientBalance = chemotronix.getPersonalProjectBalance("project1");
    //     chemotronix.transferCredits("project1", recipient, 50);
    //     assertEq(chemotronix.getPersonalProjectBalance("project1"), initialSenderBalance - 50);
    //     assertEq(chemotronix.getPersonalProjectBalance("project1"), initialRecipientBalance + 50);
    // }

}