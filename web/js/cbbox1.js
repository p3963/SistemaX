/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.addEventListener('focusin', function (event) {
	if (event.target.matches('[contenteditable]')) {
        console.log('focused')

        var editable = event.target

        // enter edit mode
        editable.classList.add("editing")
        
        // get text
        var text = editable.innerText

        // create input
        var input = document.createElement("input");
        input.type = "text";
        input.className = "editable-mirror";
        input.setAttribute("list", "pc");
//        input.setAttribute("list", "browsers");
        input.value = text;

        editable.appendChild(input);

        input.focus()
        
	}
}, false);
document.addEventListener('focusout', function (event) {
    if (event.target.matches('.editable-mirror')) {
        console.log('blur')
        
        var input = event.target
        var editable = input.closest("[contenteditable]")

        // leave edit mode
        editable.classList.remove("editing")

        // get text
        var text = input.value;

        // destroy input
        input.parentNode.removeChild(input);

        // apply value
        editable.innerText = text;
    }
}, false);


