function addBookmark(id) {
    fetch('/nedelja01/api/bookmarks/add/' + id, {
        credentials: "include"
    })
    .then(response => response.json())
    .then(json => {
        getBookmarks();
    });
}

function clearBookmarks() {
    fetch('/nedelja01/api/bookmarks/clear/', {
        credentials: "include"
    })
    .then(response => response.json())
    .then(json => {
        getBookmarks();
    });
}

function getBookmarks() {
    fetch('/nedelja01/api/bookmarks/', {
        credentials: "include"
    })
    .then(response => response.json())
    .then(json => {
        let bookmarks = json.bookmarks;

        displayBookmarks(bookmarks);
    });
}

function displayBookmarks(bookmarks) {
    let div = document.getElementById('bookmarks');
    div.innerText = '';

    for (let bookmark of bookmarks) {
        let link = document.createElement('a');
        link.style.display = 'block';
        link.innerText = bookmark.title;
        link.setAttribute('href', '/nedelja01/auction/' + bookmark.auction_id);
        link.setAttribute('target', '_blank');

        div.appendChild(link);
    }

    if (bookmarks.length > 0) {
        let clearButton = document.createElement('button');
        clearButton.innerHTML = 'Clear bookmarks';
        clearButton.addEventListener('click', clearBookmarks);

        div.appendChild(clearButton);
    } else {
        div.innerText = 'Niste dodali aukcije...';
    }
}

window.addEventListener('load', getBookmarks);
