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

    function updateText(string memory _newTitle, uint256 index)
        external
        returns (bool success)
    {
        Todo storage todo = todos[index];
        todo.title = _newTitle;
        //or
        //todos[index].title = _newTitle;
        success = true;
    }

    function setStatus(uint256 index) external {
        Todo storage todo = todos[index];
        todo.status = !todo.status;

        //or
        //todos[index].status = !todos[index].status;
    }

    function getTask(uint256 index) external view returns (Todo memory) {
        return todos[index];
    }
}
