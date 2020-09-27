pragma solidity ^0.6.12;

contract CheckPresence {
  string public employeeId;
  string public date;

  constructor(string memory employee, string memory insertedDate) public {
    employeeId = employee;
    date = insertedDate;
  }

  function update(string memory insertedDate) public {
    date = insertedDate;
  }

  function getPresence() public view returns (string memory){
    return string(abi.encodePacked(employeeId, " was here at ", date));
  }
}
