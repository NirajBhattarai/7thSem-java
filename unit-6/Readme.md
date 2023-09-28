# Setting up JavaFX on Eclipse

Follow the steps below to set up JavaFX on Eclipse:

## 1. Download JavaFX SDK
- Visit the official [OpenJFX](https://openjfx.io/) site.
- Navigate to the "Download" section.
- Download the latest JavaFX SDK for your OS.

## 2. Extract the JavaFX SDK
- Once the download is complete, extract the zip file to a suitable location on your computer, e.g., `C:\javafx-sdk-17`.

## 3. Install e(fx)clipse
- Open Eclipse.
- Navigate to `Help` -> `Eclipse Marketplace`.
- Search for `e(fx)clipse` and install the plugin.
- Restart Eclipse after installation.

## 4. Configure JavaFX in Eclipse
- Open Eclipse, and go to `Window` -> `Preferences`.
- Under `Java` -> `Build Path` -> `User Libraries`, click `New` to create a new user library.
- Name it (e.g., `JavaFX17`) and click OK.
- With your new library selected, click on `Add External JARs`.
- Navigate to the `lib` folder in your JavaFX SDK directory, select all JAR files, and add them.
- Expand your library, select `Native library location`, click on `Edit`, and point it to the `bin` directory of the JavaFX SDK.

## 5. Setting Up a New JavaFX Project
- Go to `File` -> `New` -> `Other` and select `JavaFX` -> `JavaFX Project`.
- Provide a project name and click `Finish`.
- Right-click on the project -> `Build Path` -> `Add Libraries` -> `User Library` and select your JavaFX library.

## 6. Add VM Arguments
- Right-click on your project -> `Run As` -> `Run Configurations`.
- Under `Arguments`, in the VM arguments section, add:

