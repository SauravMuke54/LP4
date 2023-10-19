// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalRecords {

    struct MedicalRecord {
        uint recordId;
        string patientName;
        string data; // Encrypted medical data
        address provider; // The healthcare provider who added the record
        uint timestamp;
    }

    mapping(uint => MedicalRecord) public records;
    uint public recordCounter;

    event MedicalRecordAdded(uint indexed recordId, string patientName, address provider, uint timestamp);

    constructor() {
        recordCounter = 0;
    }

    // Add a new medical record
    function addMedicalRecord(string memory _patientName, string memory _data) public {
        recordCounter++;
        records[recordCounter] = MedicalRecord(recordCounter, _patientName, _data, msg.sender, block.timestamp);
        emit MedicalRecordAdded(recordCounter, _patientName, msg.sender, block.timestamp);
    }

    // Get the number of medical records
    function getRecordCount() public view returns (uint) {
        return recordCounter;
    }

    // Get a specific medical record by ID
    function getMedicalRecord(uint _recordId) public view returns (string memory, address, uint) {
        require(_recordId > 0 && _recordId <= recordCounter, "Record not found");
        MedicalRecord memory record = records[_recordId];
        return (record.data, record.provider, record.timestamp);
    }
}
