// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract TodoContract {
    event TaskEvent(string);

    //todo structure
    struct Todo {
        string title;
        bool status;
    }
    Todo[] todos;

    function createTask(string memory _title) external {
        todos.push(Todo({title: _title, status: false}));
        emit TaskEvent("Task created");
    }

    function updateText(string memory _newTitle, uint256 index) external {
        Todo storage todo = todos[index];
        todo.title = _newTitle;
        //or
        //todos[index].title = _newTitle;
        emit TaskEvent("Task title updated");
    }

    function setStatus(uint256 index) external {
        Todo storage todo = todos[index];
        todo.status = !todo.status;

        //or
        //todos[index].status = !todos[index].status;
        emit TaskEvent("Task status updated");
    }

    function getATask(uint256 index) external view returns (Todo memory) {
        return todos[index];
    }

    function getAllTasks() external view returns (Todo[] memory) {
        return todos;
    }

    function deleteTask(uint256 index) external returns () {
        // for(uint i = index; i > todos.length; i--){
        // }
        // todos[index] = todos[todos.length - 1];
        // todos.pop();
        // success = true;
        for (uint256 i = 0; i < todos.length - 1; i++) {
            todos[i] = todos[i + 1];
        }
        todos.pop();

        emit TaskEvent("Task deleted");
    }
}
