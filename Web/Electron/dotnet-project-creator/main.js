const { app, BrowserWindow, ipcMain, dialog, webContents } = require('electron');
const path = require('path');

let mainWindow;

function createWindow () {
  mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false
    }
  });

  mainWindow.loadFile("index.html");

  // mainWindow.webContents.openDevTools();
}

ipcMain.on("choose-directory", event => {
  dialog.showOpenDialog(mainWindow, {
    properties: [ 'openDirectory' ]
  }).then(result => {
    if (!result.canceled) {
      let selectedPath = result.filePaths[0];
      console.log(selectedPath);
      mainWindow.webContents.send("dir", selectedPath);
    }
  }).catch(error => {
    console.log(error);
  });  
});

app.whenReady().then(() => {
  createWindow();

  app.on('activate', function () {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
