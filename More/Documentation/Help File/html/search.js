var lastq = "";

function requery() {
  if (!jswords || !jsfiles) return;  // still loading
  
  var currentq = $('#squery').val();//document.LeftFrame.document.query.q.value;
  if (currentq == lastq)
    return;

  var results = localfind(currentq.split(" "))
  lastq = currentq;
  updateResults(results);
}

// This function is adapted from David Mertz's public domain Gnosis Utils for Python
// with some extra gymnastics since jsfiles uses the more compact js array instead of object/dicts
function localfind(wordlist) {
  var entries = {};
  var hits = {}
  for (var idx=0; idx < jsfiles.length; idx++) {
    hits[idx] = jsfiles[idx];         // copy of the fileids index
  }
  for (var idx in wordlist) {
    var word = wordlist[idx]
    word = word.toUpperCase()
    if (!jswords[word]) return {}     // Nothing for this one word (fail)
    var entry = {}
    for (var idx=0; idx < jswords[word].length; idx++) {  // For each word, get index
       entry[jswords[word][idx]] = "hit";                 //   of matching files
    }

    for (var fileid in hits) { // Eliminate hits for every non-match
      if (!entry[fileid]) {
        delete hits[fileid];
      }
    }
  }
  return hits;
}

function print_obj(obj) {
  var str = "{";
  for (var x in obj) {
    str += x + ":" + obj[x] + ",";
  }
  alert( str + "}")
}


function updateResults(results) {
  $("#results").empty();

  var co = 0;
  
  for (var fileid in results) {
	co = co + 1;
  }
  
  if (co == 0) {
		$("#results").append('Your search did not match any documents.<p>Make sure all keywords are spelt correctly.<br>Try different or more general keywords.');
		return;
  }
  
  for (var fileid in results) {
    var hit = jsfiles[fileid];
	var title = jstitle[fileid];
    var res_link = '<a href="' + hit + '?s=' + escape(lastq) +'" target="RightFrame">' + title + '</a><br>';
	$("#results").append(res_link);
  }
}

function makeHyperlink( url, text, title ) {
  var aelem = document.createElement("a");
  if (title) aelem.setAttribute( "title", title );
  if (url)   aelem.setAttribute( "href", url );
  aelem.setAttribute("target", "RightFrame");
  aelem.appendChild(document.createTextNode(text))
  return aelem;
}

