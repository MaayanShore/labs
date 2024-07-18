// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Structs {


struct Todo{
string text;
bool complete;
}

Todo[] public  todos;

function fill(string calldata _text) public{

todos.push(Todo(_text,false));
todos.push(Todo({text:_text,complete:false}));

Todo memory t;
t.text=_text;
t.complete=true;
todos.push(t);
}

function get(uint index) public view  returns(string memory, bool ){
Todo storage t=todos[index];
return(t.text, t.complete);
}

function updateText(uint index, string calldata _text) public{
   Todo storage t=todos[index];
   t.text=_text;
}
function updateComlete(uint index) public{
   Todo storage t=todos[index];
t.complete=!t.complete;
}
}