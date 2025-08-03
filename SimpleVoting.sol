// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    address public owner;

    struct Candidate {
        string name;
        uint voteCount;
    }

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    constructor(string memory _name1, string memory _name2) {
        owner = msg.sender;
        candidates.push(Candidate(_name1, 0));
        candidates.push(Candidate(_name2, 0));
    }

    function vote(uint _candidateIndex) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateIndex < candidates.length, "Invalid candidate");

        candidates[_candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getVotes() public view returns (uint[] memory) {
        uint[] memory counts = new uint[](candidates.length);
        for (uint i = 0; i < candidates.length; i++) {
            counts[i] = candidates[i].voteCount;
        }
        return counts;
    }

    function getCandidateName(uint index) public view returns (string memory) {
        require(index < candidates.length, "Invalid index");
        return candidates[index].name;
    }
}
