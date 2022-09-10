// ==UserScript==
// @name         Only Menu Functions
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       PrikolMen:-b
// @match        https://wiki.facepunch.com/gmod/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=facepunch.com
// @grant        none
// ==/UserScript==

var toRemove = []
function CheckA( a, li )
{
    if (a.className.includes( "cm" ) && !a.className.includes( "rm" )){
        toRemove.push( li );
        return true;
    }

    return false;
}

for (let level1 of document.getElementsByClassName("level1")) {
    let ul = level1.querySelector( "ul" );
    if (ul != null) {
        for (let li of ul.getElementsByTagName( "li" )) {
            if (li.getElementsByClassName( "level2" ).length > 0) continue;
            for (let a of li.getElementsByTagName( "a" )) {
                if (CheckA( a, li )) {
                    break;
                }
            }
        }
    }
}

for (let el of toRemove) {
    el.remove()
}
