pragma solidity 0.4.24;

contract Vote{
    
    // structure
    struct candidator {
        string name;
        uint upVote;
    }
    
    // variable
    bool live;
    address owner;
    candidator[] public candidatorList;
    
    // mapping
    mapping(address => bool) Voted;
    
    // event
    event AddCandidator(string name);
    event UpVote(string candidator, uint upVote);
    event FinishVote(bool live);
    event Voting(address owner);
    
    // modifier
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    // constructor
    constructor() public {
        owner = msg.sender;
        live = true;
        
        emit Voting(owner);
    }
    
    // candidator
    function addCandidator(string _name) public onlyOwner{
        require(live == true);
        require(candidatorList.length < 5);
        candidatorList.push(candidator(_name, 0));
        
        // emit event
        emit AddCandidator(_name);
    }
    
    // voting
    function upVote(uint _indexOfCandidaor) public{
        require(live == true);
        require(_indexOfCandidaor < candidatorList.length);
        require(Voted[msg.sender] == false);
        candidatorList[_indexOfCandidaor].upVote++;
        
        Voted[msg.sender] = true;
        
        emit UpVote(candidatorList[_indexOfCandidaor].name, candidatorList[_indexOfCandidaor].upVote);
        
    }
    
    // finish vote
    function finishVote() public onlyOwner{
        require(live == true);
        live = false;
        
        emit FinishVote(live);
    }
}
