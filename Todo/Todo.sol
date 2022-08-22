// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract TODO {
    //todo structure
    struct Todo {
        string title;
        bool status;
    }
    Todo[] todos;

    function createTask(string memory _title) external {
        todos.push(Todo({title: _title, status: false}));
    }

    function updateText(string memory _newTitle, uint256 _index)
        external
        returns (bool success)
    {
        Todo storage todo = todos[_index];
        todo.title = _newTitle;
    }

    function setStatus(uint256 _index) external {
        Todo storage todo = todos[_index];
        todo.status = !todo.status;
    }

    function getTask() external returns (TODO) {}
}
