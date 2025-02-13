// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IVotingV1 {
    function addCandidate(string memory _name) external;
    function vote(uint _candidateId) external;
    function getVotes(uint _candidateId) external view returns (uint);
    function getAllCandidates() external view returns (string[] memory);
    function getWinner() external view returns (string memory);
}
