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
- Right-click on your project -> `Run As` -> `Run Configurations`.
- Under `Arguments`, in the VM arguments section, add:


## Introduction to JavaFX's FlowPane

JavaFX provides a set of layout panes that enable the design of user interface controls based on a certain logic or natural flow. One such layout is the `FlowPane`.

A `FlowPane` arranges its children in a flow that wraps at the pane's boundary. This behavior is reminiscent of how words wrap at the end of a line when writing text. You can think of `FlowPane` as a line of elements; when the space for that line is exhausted, elements transition to the next line, and so forth.

This layout is particularly useful for applications where there's an uncertain or dynamic number of children that need to be displayed.

Below is a simple JavaFX program demonstrating `FlowPane`:

```java
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.FlowPane;
import javafx.stage.Stage;

public class FlowPaneExample extends Application {
    
    @Override
    public void start(Stage primaryStage) {
        // Create a FlowPane
        FlowPane flowPane = new FlowPane();
        
        // Add some controls to the FlowPane
        for (int i = 1; i <= 20; i++) {
            flowPane.getChildren().add(new Button("Button " + i));
        }
        
        // Create a scene with the FlowPane and set it on the stage
        Scene scene = new Scene(flowPane, 400, 200);
        primaryStage.setTitle("FlowPane Example");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
    
    public static void main(String[] args) {
        launch(args);
    }
}
```

## Introduction to JavaFX's BorderPane

In JavaFX, `BorderPane` is one of the most fundamental and versatile layout panes. It divides the space into five distinct regions: top, right, bottom, left, and center. Each region can only contain one node, but that node can be another container to nest additional nodes.

- **Top and Bottom**: Typically used for menus, banners, or informational areas.
- **Right and Left**: Generally used for navigation, side components, or secondary information.
- **Center**: This is where the main content typically goes. It occupies all the space left after the other regions have been rendered.

The advantage of using `BorderPane` is its simple logic of positioning nodes, making it easy to create organized and well-structured UIs.

Below is a simple JavaFX program demonstrating `BorderPane`:

```java
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

public class BorderPaneExample extends Application {
    
    @Override
    public void start(Stage primaryStage) {
        BorderPane borderPane = new BorderPane();

        // Add nodes to the BorderPane
        borderPane.setTop(new Button("Top"));
        borderPane.setRight(new Button("Right"));
        borderPane.setBottom(new Button("Bottom"));
        borderPane.setLeft(new Button("Left"));
        borderPane.setCenter(new Button("Center"));

        Scene scene = new Scene(borderPane, 300, 200);
        primaryStage.setTitle("BorderPane Example");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
```

## Introduction to JavaFX's HBox

In JavaFX, `HBox` is a layout pane which lays out its children in a single horizontal row. If the hbox has a border and/or padding set, the contents will be laid out within those insets.

`HBox` is particularly useful when you want to align elements horizontally in a single row. It takes care of the spacing and alignment of nodes/components placed in it, and it can automatically resize child nodes if the window is resized.

Here's a simple JavaFX program that demonstrates the use of `HBox`:

```java
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.HBox;
import javafx.stage.Stage;

public class HBoxExample extends Application {
    
    @Override
    public void start(Stage primaryStage) {
        // Create an HBox
        HBox hbox = new HBox();
        
        // Set spacing between child nodes
        hbox.setSpacing(10);
        
        // Set padding of HBox
        hbox.setPadding(new Insets(15, 12, 15, 12));

        // Add buttons to the HBox
        hbox.getChildren().addAll(new Button("Button 1"), new Button("Button 2"), new Button("Button 3"));
        
        // Create a scene with the HBox and set it on the stage
        Scene scene = new Scene(hbox, 300, 200);
        primaryStage.setTitle("HBox Example");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
    
    public static void main(String[] args) {
        launch(args);
    }
}
```


## Introduction to JavaFX's VBox

In JavaFX, `VBox` is a layout pane that arranges its children in a single vertical column. Similar to the `HBox` which aligns elements horizontally, the `VBox` aligns elements vertically. It's useful when you want to place UI elements on top of each other in a columnar manner.

`VBox` handles the spacing and alignment of its child nodes/components and can automatically resize them if the window is adjusted.

Here's a simple JavaFX program that demonstrates the use of `VBox`:

```java
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class VBoxExample extends Application {
    
    @Override
    public void start(Stage primaryStage) {
        // Create a VBox
        VBox vbox = new VBox();
        
        // Set spacing between child nodes
        vbox.setSpacing(10);
        
        // Set padding of VBox
        vbox.setPadding(new Insets(15, 12, 15, 12));

        // Add buttons to the VBox
        vbox.getChildren().addAll(new Button("Button 1"), new Button("Button 2"), new Button("Button 3"));
        
        // Create a scene with the VBox and set it on the stage
        Scene scene = new Scene(vbox, 200, 200);
        primaryStage.setTitle("VBox Example");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
    
    public static void main(String[] args) {
        launch(args);
    }
}
```
## Introduction to JavaFX's GridPane

`GridPane` in JavaFX is a highly flexible layout pane that allows you to create a grid of rows and columns in which to place UI elements. Each UI element occupies a "cell" within the grid. You can specify which row and column each component should be placed in, control the spacing between rows and columns, and even span multiple rows or columns with a single component.

The grid is particularly useful for creating forms or any other user interface layout that needs precise alignment of multiple controls.

Below is a simple JavaFX program that demonstrates the use of `GridPane`:

```java
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;

public class GridPaneExample extends Application {
    
    @Override
    public void start(Stage primaryStage) {
        // Create a GridPane
        GridPane grid = new GridPane();
        grid.setPadding(new Insets(10, 10, 10, 10));
        grid.setVgap(5);
        grid.setHgap(5);

        // Add controls to the GridPane
        grid.add(new Label("Name:"), 0, 0);
        grid.add(new TextField(), 1, 0);
        grid.add(new Label("Age:"), 0, 1);
        grid.add(new TextField(), 1, 1);
        grid.add(new Button("Submit"), 1, 2);

        // Create a scene with the GridPane and set it on the stage
        Scene scene = new Scene(grid, 300, 150);
        primaryStage.setTitle("GridPane Example");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
    
    public static void main(String[] args) {
        launch(args);
    }
}
```
```

import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

public class CombinedControlsExample extends Application {
    
    @Override
    public void start(Stage primaryStage) {
        GridPane grid = new GridPane();
        grid.setPadding(new Insets(10, 10, 10, 10));
        grid.setVgap(5);
        grid.setHgap(5);

        // Label
        Label label = new Label("This is a label");
        grid.add(label, 0, 0);

        // TextField
        TextField textField = new TextField();
        grid.add(textField, 1, 0);

        // Button
        Button button = new Button("Click Me");
        button.setOnAction(e -> {
            Alert alert = new Alert(Alert.AlertType.INFORMATION, "Button was clicked!");
            alert.showAndWait();
        });
        grid.add(button, 0, 1);

        // RadioButton
        RadioButton rb1 = new RadioButton("Option 1");
        RadioButton rb2 = new RadioButton("Option 2");
        ToggleGroup group = new ToggleGroup();
        rb1.setToggleGroup(group);
        rb2.setToggleGroup(group);
        grid.add(rb1, 0, 2);
        grid.add(rb2, 1, 2);

        // CheckBox
        CheckBox checkBox = new CheckBox("Check me out");
        grid.add(checkBox, 0, 3);

        // Hyperlink
        Hyperlink link = new Hyperlink("OpenAI");
        link.setOnAction(e -> {
            // Handle hyperlink action, e.g. open a browser
        });
        grid.add(link, 1, 3);

        // Menu
        MenuBar menuBar = new MenuBar();
        Menu menu = new Menu("File");
        MenuItem item1 = new MenuItem("New");
        MenuItem item2 = new MenuItem("Open");
        menu.getItems().addAll(item1, item2);
        menuBar.getMenus().add(menu);

        // Tooltip
        Tooltip tooltip = new Tooltip("Hover over the text field");
        textField.setTooltip(tooltip);

        // FileChooser button
        Button fileChooserButton = new Button("Open File");
        fileChooserButton.setOnAction(e -> {
            FileChooser fileChooser = new FileChooser();
            fileChooser.setTitle("Open File");
            fileChooser.showOpenDialog(primaryStage);
        });
        grid.add(fileChooserButton, 0, 4);

        VBox vbox = new VBox(menuBar, grid);
        Scene scene = new Scene(vbox, 300, 300);
        primaryStage.setTitle("Combined Controls Example");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
    
    public static void main(String[] args) {
        launch(args);
    }
}
```