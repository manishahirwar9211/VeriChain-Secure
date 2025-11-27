// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title VeriChain Secure
 * @dev A lightweight contract demonstrating secure record storage,
 * event logging, and ownership-restricted updates.
 */
contract Project {
    address public owner;

    struct Record {
        string data;
        uint256 timestamp;
    }

    mapping(uint256 => Record) private records;
    uint256 public recordCount;

    event RecordCreated(uint256 indexed recordId, string data, uint256 timestamp);
    event RecordUpdated(uint256 indexed recordId, string newData, uint256 timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Create a new record.
     * @param _data Text data of the record.
     */
    function createRecord(string memory _data) public onlyOwner {
        recordCount++;
        records[recordCount] = Record(_data, block.timestamp);
        emit RecordCreated(recordCount, _data, block.timestamp);
    }

    /**
     * @dev Update an existing record.
     * @param _id Record ID to modify.
     * @param _newData Updated text data.
     */
    function updateRecord(uint256 _id, string memory _newData) public onlyOwner {
        require(_id > 0 && _id <= recordCount, "Invalid ID");

        records[_id] = Record(_newData, block.timestamp);
        emit RecordUpdated(_id, _newData, block.timestamp);
    }

    /**
     * @dev Get a stored record.
     * @param _id Record ID to query.
     */
    function getRecord(uint256 _id) public view returns (string memory, uint256) {
        require(_id > 0 && _id <= recordCount, "Invalid ID");
        Record memory r = records[_id];
        return (r.data, r.timestamp);
    }
}

