const { ipcRenderer } = require('electron');

const templates = [
    {
        "name": ".NET MAUI App", 
        "shortName": "maui", 
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": ".NET MAUI Blazor App",
        "shortName": "maui-blazor",
        "languages": [ "C#"],
        "isFile": false
    }, 
    {
        "name": ".NET MAUI Class Library",
        "shortName": "mauilib",
        "languages": [ "C#" ],
        "isFile": false
    }, 
    {
        "name": ".NET MAUI ContentPage (C#)",
        "shortName": "maui-page-csharp",
        "languages": [ "C#" ],
        "isFile": true
    }, 
    {
        "name": ".NET MAUI ContentView (XAML)",
        "shortName": "maui-view-xaml",
        "languages": [ "C#" ],
        "isFile": true
    }, 
    {
        "name": ".NET MAUI ContentView (C#)",
        "shortName": "maui-view-csharp",
        "languages": [ "C#"],
        "isFile": true
    }, 
    {
        "name": ".NET MAUI ContentPage (XAML)",
        "shortName": "maui-page-xaml",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": ".NET MAUI ResourceDictionary (XAML)",
        "shortName": "maui-dict-xaml",
        "languages": [ "C#" ],
        "isFile": true
    }, 
    {
        "name": "Android Activity template",
        "shortName": "android-activity",
        "languages": [ "C#" ],
        "isFile": true
    }, 
    {
        "name": "Android Class Library",
        "shortName": "androidlib",
        "languages": [ "C#" ],
        "isFile": false
    }, 
    {
        "name": "Android Application",
        "shortName": "android",
        "languages": [ "C#" ],
        "isFile": false
    }, 
    {
        "name": "Android Java Library Binding",
        "shortName": "android-bindinglib",
        "languages": [ "C#" ],
        "isFile": false
    }, 
    {
        "name": "Android Layout template",
        "shortName": "android-layout",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "Android Wear Application",
        "shortName": "androidwear",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "ASP.NET Core Empty",
        "shortName": "web",
        "languages": [ "C#", "F#" ],
        "isFile": false
    },
    {
        "name": "ASP.NET Core gRPC Service",
        "shortName": "grpc",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "ASP.NET Core Web API",
        "shortName": "webapi",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "ASP.NET Core Web App",
        "shortName": "razor",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "ASP.NET Core Web App (Model-View-Controller)",
        "shortName": "mvc",
        "languages": [ "C#", "F#" ],
        "isFile": false
    },
    {
        "name": "ASP.NET Core with Angular",
        "shortName": "angular",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "ASP.NET Core with React.js and Redux",
        "shortName": "reactredux",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "ASP.NET Core with React.js",
        "shortName": "react",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "Blazor Server App",
        "shortName": "blazorserver",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "Blazor Server App Empty",
        "shortName": "blazorserver-empty",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "Blazor WebAssembly App",
        "shortName": "blazorwasm",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "Blazor WebAssembly App Empty",
        "shortName": "blazorwasm-empty",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "Class Library",
        "shortName": "classlib",
        "languages": [ "C#", "F#", "VB" ],
        "isFile": false
    },
    {
        "name": "Console App",
        "shortName": "console",
        "languages": [ "CE", "F#", "VB" ],
        "isFile": false
    },
    {
        "name": "Gitignore File",
        "shortName": "gitignoe",
        "languages": [ "Config" ],
        "isFile": true
    },
    {
        "name": "Dotnet Local Tool Manifest File",
        "shortName": "tool-manifest",
        "languages": [ "Config" ],
        "isFile": true
    },
    {
        "name": "EditorConfig File",
        "shortName": "editorconfig",
        "languages": [ "Config" ],
        "isFile": true
    },
    {
        "name": "global.json File",
        "shortName": "globaljson",
        "languages": [ "Config" ],
        "isFile": true
    },
    {
        "name": "iOS Application",
        "shortName": "ios",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "iOS Binding Library",
        "shortName": "iosbinding",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "iOS Class Library",
        "shortName": "ioslib",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "iOS Controller",
        "shortName": "ios-controller",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "iOS Tabbed Application",
        "shortName": "ios-tabbed",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "iOS View",
        "shortName": "ios-view",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "iOS View Controller",
        "shortName": "ios-viewcontroller",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "Mac Catalyst Application",
        "shortName": "maccatalyst",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "Mac Catalyst Binding Library",
        "shortName": "maccatalystbinding",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "Mac Catalyst Class Library",
        "shortName": "maccatalystlib",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "Mac Catalyst Controller",
        "shortName": "maccatalyst-controller",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "Mac Catalyst Storyboard",
        "shortName": "maccatalyst-storyboard",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "Mac Catalyst View",
        "shortName": "maccatalyst-view",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "Mac Catalyst View Controller",
        "shortName": "maccatalyst-viewcontroller",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "MSTest Test Project",
        "shortName": "mstest",
        "languages": [ "C#", "F#", "VB" ],
        "isFile": false
    },
    {
        "name": "MVC ViewImports",
        "shortName": "viewimports",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "MVC ViewStart",
        "shortName": "viewstart",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "NuGet Config",
        "shortName": "nugetconfig",
        "languages": [ "Config" ],
        "isFile": true
    },
    {
        "name": "NUnit 3 Test Item",
        "shortName": "nunit-test",
        "languages": [ "C#", "F#", "VB" ],
        "isFile": false
    },
    {
        "name": "NUnit 3 Test Project",
        "shortName": "nunit",
        "languages": [ "C#", "F#", "VB" ],
        "isFile": false
    },
    {
        "name": "Protocol Buffer File",
        "shortName": "proto",
        "languages": [ "None" ],
        "isFile": true
    },
    {
        "name": "Razor Class Library",
        "shortName": "razorclasslib",
        "languages": [ "C#" ],
        "isFile": false
    },
    {
        "name": "Razor Component",
        "shortName": "razorcomponent",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "Razor Page",
        "shortName": "page",
        "languages": [ "C#" ],
        "isFile": true
    },
    {
        "name": "Solution File",
        "shortName": "sln",
        "languages": [ "Solution" ],
        "isFile": true
    },
    {
        "name": "Web Config",
        "shortName": "webconfig",
        "languages": [ "Config" ],
        "isFile": true
    },
    {
        "name": "Windows Forms App",
        "shortName": "winforms",
        "languages": [ "C#", "VB" ],
        "isFile": false
    },
    {
        "name": "Windows Forms Class Library",
        "shortName": "winformslib",
        "languages": [ "C#", "VB" ],
        "isFile": false
    },
    {
        "name": "Windows Forms Control Library",
        "shortName": "winformscontrollib",
        "languages": [ "C#", "VB" ],
        "isFile": false
    },
    {
        "name": "Worker Service",
        "shortName": "worker",
        "languages": [ "C#", "F#" ],
        "isFile": false
    },
    {
        "name": "WPF Application",
        "shortName": "wpf",
        "languages": [ "C#", "VB" ],
        "isFile": false
    },
    {
        "name": "WPF Class library",
        "shortName": "wpflib",
        "languages": [ "C#", "VB" ],
        "isFile": false
    },
    {
        "name": "WPF Custom Control Library",
        "shortName": "wpfcustomcontrollib",
        "languages": [ "C#", "VB" ],
        "isFile": false
    },
    {
        "name": "WPF User Control Library",
        "shortName": "wpfusercontrollib",
        "languages": [ "C#", "VB" ],
        "isFile": false
    },
    {
        "name": "xUnit Test Project",
        "shortName": "xunit",
        "languages": [ "C#", "F#", "VV" ],
        "isFile": false
    }
];

const dirPathField = document.getElementById("proj-dir-field");
const chooseDirectoryButton = document.getElementById("choose-dir-btn");
const templateSelect = document.getElementById("template-select");
const languageSelect = document.getElementById("language-select");
const projectFilterRadio = document.getElementById("proj-filter-radio");
const fileFilterRadio = document.getElementById("file-filter-radio");
 
let projectDir = "";

chooseDirectoryButton.addEventListener('click', () => {
    ipcRenderer.send("choose-directory", "");
});

languageSelect.addEventListener('change', optionsChanged);
projectFilterRadio.addEventListener('change', optionsChanged);
fileFilterRadio.addEventListener('change', optionsChanged);
  

ipcRenderer.on("dir", (event, path) => {
    dirPathField.value = path;
});

function optionsChanged() {
    const selectedValue = languageSelect.value;
    const isOnlyProjectsChecked = projectFilterRadio.checked;
    const isOnlyFilesChecked = fileFilterRadio.checked;
    
    while (templateSelect.options.length) {
        templateSelect.remove(0);
    }
    
    if (isOnlyFilesChecked) {
        templates.filter(t => {
            return t.isFile === true;
        }).filter(t => {
            if (selectedValue === "C#") {
                return t.languages.includes("C#");
            } else if (selectedValue === "F#") {
                return t.languages.includes("F#");
            } else if (selectedValue === "VB") {
                return t.languages.includes("VB");
            } else {
                return !t.languages.includes("C#g") && 
                       !t.languages.includes("F#") && 
                       !t.languages.includes("VB")
            }
        }).forEach(t => {
            const templateOption = document.createElement('option');

            templateOption.value = t.shortName;
            templateOption.innerText = t.name;

            templateSelect.options.add(templateOption);
        });
    }

    if (isOnlyProjectsChecked) {
        templates.filter(t => {
            return t.isFile === false;
        }).filter(t => {
            if (selectedValue === "C#") {
                return t.languages.includes("C#");
            } else if (selectedValue === "F#") {
                return t.languages.includes("F#");
            } else if (selectedValue === "VB") {
                return t.languages.includes("VB");
            } else {
                return t.languages.includes("Config") || 
                       t.languages.length === 0
            }
        }).forEach(t => {
            const templateOption = document.createElement('option');

            templateOption.value = t.shortName;
            templateOption.innerText = t.name;

            templateSelect.options.add(templateOption);
        });
    }
}
