

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract Chemotronix is ERC20{

    constructor(address nftAddress) ERC20("Chemotronix", "CMX"){
       
    }

    mapping(string => uint256) public projectBalance;

    mapping(string => uint256) public projectRetiredCredits;

    mapping(address =>mapping(string => uint)) personalProjectBalance;

    mapping(string => bool) public verifiedProjects;

    uint256 public totalRetiredCredits;


    modifier onlyVerifiedProject(string memory projectId) {
        require(verifiedProjects[projectId], "Project not verified");
        _;
    }

    function verifyProject(string memory projectId) public {
        verifiedProjects[projectId] = true;
    }

    function getProjectBalance(string memory projectId) onlyVerifiedProject(projectId) public view returns (uint256) {
        return projectBalance[projectId];
    }

    function mint(string memory projectId, uint amount) onlyVerifiedProject(projectId) public {
        _mint(msg.sender, amount);
        projectBalance[projectId] += amount;
        personalProjectBalance[msg.sender][projectId] += amount;
    }

    function transferCredits(string memory projectId, address to, uint256 amount) onlyVerifiedProject(projectId) public { 
        _transfer(msg.sender, to, amount);
        personalProjectBalance[msg.sender][projectId] -= amount;
        personalProjectBalance[to][projectId] += amount;
    }

    function retireCredits(string memory projectId, uint256 amount) onlyVerifiedProject(projectId) public {
        _burn(msg.sender, amount);
        personalProjectBalance[msg.sender][projectId] -= amount;
        projectBalance[projectId] -= amount;
        projectRetiredCredits[projectId] += amount;
        totalRetiredCredits += amount;
    }

    function getPersonalProjectBalance(string memory projectId) onlyVerifiedProject(projectId) public view returns (uint256) {
        return personalProjectBalance[msg.sender][projectId];
    }

    function getProjectRetiredCredits(string memory projectId) onlyVerifiedProject(projectId) public view returns(uint256) {
        return projectRetiredCredits[projectId];
    }

    function getTotalRetiredCredits(string memory projectId) onlyVerifiedProject(projectId) public view returns(uint256) {
        return totalRetiredCredits;
    }
}

