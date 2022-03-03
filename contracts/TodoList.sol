// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract TodoList {
    address private owner;
    uint256 public taskCount;
    uint256 public completedTaskCount;
    uint256 public uncompletedTaskCount;

    struct Task {
        uint256 id;
        string content;
        bool completed;
    }

    mapping(uint256 => Task) public tasks;

    constructor() {
        owner = msg.sender;
        taskCount = 0;
    }

    function createTask(string memory _content) public {
        require(msg.sender == owner, "Only owner can add a task");
        taskCount++;
        uncompletedTaskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);
    }

    function toggleCompleted(uint256 _id) public {
        require(msg.sender == owner, "Only owner can toggle a task");
        Task memory _task = tasks[_id];
        if (_task.completed) {
            completedTaskCount--;
            uncompletedTaskCount++;
        } else {
            completedTaskCount++;
            uncompletedTaskCount--;
        }
        _task.completed = !_task.completed;
        tasks[_id] = _task;
    }
}
