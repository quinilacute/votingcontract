// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IVotingV1.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract VotingV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable, IVotingV1 {
    // Storage variables
    string[] internal candidates;
    mapping(uint => uint) internal votes;
    mapping(address => bool) internal hasVoted;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    function initialize() public initializer {
        __Ownable_init_unchained(msg.sender);
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyOwner
    {
        // No extra logic needed
    }

    // V1: Anyone can add a candidate
    function addCandidate(string memory _name) external override {
        candidates.push(_name);
    }

    function vote(uint _candidateId) external override {
        require(!hasVoted[msg.sender], "Already voted");
        require(_candidateId < candidates.length, "Invalid candidate id");
        votes[_candidateId]++;
        hasVoted[msg.sender] = true;
    }

    function getVotes(uint _candidateId) external view override returns (uint) {
        require(_candidateId < candidates.length, "Invalid candidate id");
        return votes[_candidateId];
    }

    function getAllCandidates() external view override returns (string[] memory) {
        return candidates;
    }

    function getWinner() external view override returns (string memory) {
        uint winningVoteCount = 0;
        uint winningCandidateId = 0;
        for (uint i = 0; i < candidates.length; i++) {
            if (votes[i] > winningVoteCount) {
                winningVoteCount = votes[i];
                winningCandidateId = i;
            }
        }
        return candidates[winningCandidateId];
    }
}
