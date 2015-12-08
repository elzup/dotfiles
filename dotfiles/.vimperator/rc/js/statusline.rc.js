let statusLine = document.getElementById("liberator-statusline");
let bottomBar = document.getElementById("liberator-bottombar");

// ステータスバーにブックマークアイコンを移動
let (statusBar = document.getElementById("status-bar")) {
  let (id = "star-button") {
    if(!document.getElementById("panel-" + id)) {
      let panel = document.createElement("statusbarpanel");
      panel.setAttribute("id", "panel-" + id);
      let (icon = document.getElementById(id)) {
        icon.setAttribute("class", "");
        panel.appendChild(icon);
      }
      statusBar.insertBefore(panel, statusBar.firstChild);
    }
  }
}
// ステータスラインの横にステータスバーを移動
let (statusBar = document.getElementById("status-bar")) {
  statusBar.style.maxHeight = "20px";
  bottomBar.appendChild(statusBar);
}
// ステータスラインにfaviconを移動
let (favicon = document.getElementById("page-proxy-stack")) {
  if (favicon != null) {
      favicon.style.maxWidth = favicon.style.maxHeight = "20px"
      statusLine.insertBefore(favicon, statusLine.firstChild);
  }
}
