# Design Patterns in Swing

## 1. Observer (Event Listener) Pattern
Swing heavily relies on the Observer pattern, especially in event handling.

### Concept
- The **Observer pattern** defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.

# Observer Pattern

The Observer Pattern defines a one-to-many relationship between objects, such that when one object (the "subject" or "observable") changes its state, all of its dependents ("observers") are notified and updated automatically.

## Key Components:
- **Observable (Subject)**: The object being observed. It maintains a list of observers and provides methods to add, remove, and notify them.
- **Observer**: An interface that defines the methods to be invoked when the observable changes its state.

## Workflow:
1. An observer subscribes (registers) with an observable to receive updates.
2. When the state of the observable changes, it notifies all its registered observers.
3. Each observer then takes appropriate action based on the update.

## Benefits:
- **Decoupling**: The observable is independent of its observers, and vice versa. This allows for modularity and separation of concerns.
- **Dynamic relationships**: Observers can be added or removed at runtime.

## Example in Java:

```java
import java.util.ArrayList;
import java.util.List;

// Observable
class Subject {
    private List<Observer> observers = new ArrayList<>();
    private int state;

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
        notifyAllObservers();
    }

    public void attach(Observer observer) {
        observers.add(observer);
    }

    private void notifyAllObservers() {
        for (Observer observer : observers) {
            observer.update();
        }
    }
}

// Observer interface
interface Observer {
    void update();
}

// Concrete Observer
class BinaryObserver implements Observer {
    private Subject subject;

    public BinaryObserver(Subject subject) {
        this.subject = subject;
        this.subject.attach(this);
    }

    @Override
    public void update() {
        System.out.println("Binary state: " + Integer.toBinaryString(subject.getState()));
    }
}

public class ObserverPatternDemo {
    public static void main(String[] args) {
        Subject subject = new Subject();

        new BinaryObserver(subject);

        System.out.println("Setting state to 5");
        subject.setState(5);
    }
}
```
  
### In Swing
- Swing components (`JButton`, `JTextField`, etc.) are the "subjects" (or "observables").
- Event listeners (`ActionListener`, `MouseListener`, etc.) act as the "observers".

### Example
```java
JButton button = new JButton("Click me");
button.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
        System.out.println("Button clicked!");
    }
});
```

## Model-View-Controller (MVC) Pattern in Swing

### Model

The **Model** represents data and the business logic. It's agnostic of the user interface. Changes in the user interface (View) won't affect the Model and vice versa.

## View
The **View** displays the data from the Model to the user and is the UI. It retrieves data from the Model for its display but doesn't interact directly with it.

## Controller
The **Controller** acts as an intermediary between the Model and the View. It processes user input from the View, potentially updates the Model, and then refreshes the View.

```

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Model
class DataModel {
    private DefaultListModel<String> listModel;

    public DataModel() {
        listModel = new DefaultListModel<>();
    }

    public void addItem(String item) {
        listModel.addElement(item);
    }

    public DefaultListModel<String> getListModel() {
        return listModel;
    }
}

// View
class DataView {
    private JFrame frame;
    private JList<String> list;
    private JTextField textField;
    private JButton addButton;

    public DataView() {
        frame = new JFrame("MVC Demo");
        frame.setLayout(new BorderLayout());

        list = new JList<>();
        frame.add(new JScrollPane(list), BorderLayout.CENTER);

        textField = new JTextField();
        frame.add(textField, BorderLayout.NORTH);

        addButton = new JButton("Add");
        frame.add(addButton, BorderLayout.SOUTH);

        frame.setSize(300, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }

    public JButton getAddButton() {
        return addButton;
    }

    public JTextField getTextField() {
        return textField;
    }

    public void updateList(DefaultListModel<String> model) {
        list.setModel(model);
    }
}

// Controller
class DataController {
    private DataModel model;
    private DataView view;

    public DataController(DataModel model, DataView view) {
        this.model = model;
        this.view = view;

        initView();
    }

    private void initView() {
        view.updateList(model.getListModel());

        view.getAddButton().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String input = view.getTextField().getText();
                model.addItem(input);
                view.updateList(model.getListModel());
                view.getTextField().setText("");
            }
        });
    }
}

// Driver
public class MVCDemo {
    public static void main(String[] args) {
        DataModel model = new DataModel();
        DataView view = new DataView();
        new DataController(model, view);
    }
}
```


## Layout Management in Swing

In Java Swing, **Layout Managers** are used to arrange components in a particular sequence and layout depending on the requirements of the application. Swing provides several built-in layout managers that allow developers to create complex and responsive GUIs without the need to specify exact pixel positions for each component.## Layout Management in Swing

In Java Swing, **Layout Managers** are used to arrange components in a particular sequence and layout depending on the requirements of the application. Swing provides several built-in layout managers that allow developers to create complex and responsive GUIs without the need to specify exact pixel positions for each component.

## BorderLayout in Swing: Problem, Solution, and Example


The `BorderLayout` is one of the most commonly used layout managers in Java Swing. It divides the container into five distinct regions: North, South, East, West, and Center. Each region can contain one component, and each behaves differently in terms of resizing.

### Key Characteristics

- **North and South**: Typically expand horizontally, but maintain their preferred height.
- **East and West**: Expand vertically, but maintain their preferred width.
- **Center**: Expands both horizontally and vertically to take up any remaining space.

### Code Example:

```java
import javax.swing.*;
import java.awt.*;

public class TextEditorDemo {

    public static void main(String[] args) {
        JFrame frame = new JFrame("Text Editor");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 300);
        frame.setLayout(new BorderLayout());

        // Menu Bar (North)
        JMenuBar menuBar = new JMenuBar();
        JMenu fileMenu = new JMenu("File");
        menuBar.add(fileMenu);
        frame.add(menuBar, BorderLayout.NORTH);

        // Text Area (Center)
        JTextArea textArea = new JTextArea();
        JScrollPane scrollPane = new JScrollPane(textArea);
        frame.add(scrollPane, BorderLayout.CENTER);

        // Status Bar (South)
        JLabel statusBar = new JLabel("Line count: 0");
        frame.add(statusBar, BorderLayout.SOUTH);

        frame.setVisible(true);
    }
}
```

## GridLayout in Swing: Problem, Solution, and Example

### Definition:

The `GridLayout` is a layout manager that arranges components in a grid of equal-sized cells. Each component occupies one cell, and the cells are filled row-wise. If the number of components exceeds the specified rows and columns, the grid will automatically adjust to accommodate the additional components.

### Characteristics:

1. **Uniform Cell Size**: All cells in the `GridLayout` have an equal width and height. This ensures that every component gets the same amount of space, irrespective of its individual size.

2. **Row-Wise Filling**: Components are added to the grid from left to right and top to bottom.

3. **No Gaps**: By default, there are no gaps between the cells. However, one can specify horizontal and vertical gaps using the appropriate constructor.

4. **Resizable**: When the container housing the `GridLayout` is resized, the layout automatically recalculates the cell sizes to fit the new container size.

5. **Specifiable Rows and Columns**: The number of rows and columns can be specified during the creation of the `GridLayout`. If one dimension is set (e.g., number of rows), the other dimension (number of columns) can adjust dynamically based on the number of components added.

6. **Flexible**: If the number of components added to a `GridLayout` exceeds the number of cells based on the specified rows and columns, the layout will automatically reconfigure itself to fit the extra components.

---

By using the `GridLayout`, developers can create consistent and organized user interfaces where components are displayed in an orderly grid.

### Problem Statement:

Suppose you're tasked with creating a basic calculator application. The interface requires a grid of numeric buttons (0-9), basic operations (+, -, *, /), and a "Compute" button. How would you structure this using a `GridLayout`?

### Solution with GridLayout:

The `GridLayout` is ideal for this design as it arranges components in a rectangular grid where all cells are of equal size. 

For our calculator:
- We could use a 4x4 grid.
- Numbers 1-9 can occupy the first three rows.
- The bottom row can have 0, the arithmetic operations, and the "Compute" button.

### Code Example:

```java
import javax.swing.*;
import java.awt.*;

public class CalculatorDemo {

    public static void main(String[] args) {
        JFrame frame = new JFrame("Basic Calculator");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 300);

        JPanel panel = new JPanel(new GridLayout(4, 4));

        // Adding buttons
        for (int i = 1; i <= 9; i++) {
            panel.add(new JButton(String.valueOf(i)));
        }
        panel.add(new JButton("0"));
        panel.add(new JButton("+"));
        panel.add(new JButton("-"));
        panel.add(new JButton("*"));
        panel.add(new JButton("/"));
        panel.add(new JButton("Compute"));

        frame.add(panel);
        frame.setVisible(true);
    }
}
```

## GridBagLayout in Swing: Problem, Solution, and Example

### Definition:

The `GridBagLayout` is one of the most versatile and flexible layout managers in Java Swing. It allows you to arrange components in a grid where each component can span multiple rows or columns, and each cell can have different sizes. Components are laid out based on "constraints" that specify their position and behavior within a container.

### Characteristics:

1. **Grid-Based**: Like `GridLayout`, it is grid-based, but unlike `GridLayout`, the grids (cells) can have different sizes.

2. **Constraints-Based Positioning**: Components are positioned using a `GridBagConstraints` object, which specifies constraints like grid position, padding, anchor, fill, and weight.

3. **Flexible Cell Size**: Cells can span multiple rows or columns. This allows for complex UI designs where one component might take up a larger portion of the screen compared to others.

4. **Weighted Distribution**: You can assign weights to specific rows or columns, which controls how much space they occupy relative to other rows or columns when the window is resized.

5. **Control Over Fill and Anchor**: The `fill` constraint determines if and how a component should expand to occupy extra space in its cell. The `anchor` constraint lets you decide the position of a component within its cell (e.g., centered, left-justified, right-justified, etc.).

6. **Padding and Insets**: Provides control over the amount of padding around components, ensuring precise positioning and consistent spacing.

7. **Resizable**: Like other layout managers, `GridBagLayout` responds when the parent container is resized, adjusting the components according to their constraints.

---

The `GridBagLayout`, while being one of the most powerful layout managers, also comes with a steeper learning curve. However, the flexibility and precision it offers make it an ideal choice for complex user interface designs.

### Problem Statement:

Imagine you're creating a registration form for an application. The form should have labels on the left (like "Name:", "Email:", "Password:"), corresponding input fields on the right, and a "Submit" button centered below the fields. Due to varying label and input lengths, and the desire for a flexible layout, which Swing layout manager would you choose?

### Solution with GridBagLayout:

`GridBagLayout` is the most flexible layout manager in Swing. It allows components to be laid out based on "constraints" that specify their position and behavior within a container.

For our registration form:
- Labels can be placed in the first column.
- Input fields can be in the second column.
- The "Submit" button can span both columns and be centered below the fields.

### Code Example:

```java
import javax.swing.*;
import java.awt.*;

public class RegistrationFormDemo {

    public static void main(String[] args) {
        JFrame frame = new JFrame("Registration Form");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);
        
        JPanel panel = new JPanel(new GridBagLayout());
        GridBagConstraints constraints = new GridBagConstraints();

        // Name Label
        constraints.gridx = 0;
        constraints.gridy = 0;
        panel.add(new JLabel("Name:"), constraints);

        // Name Field
        constraints.gridx = 1;
        constraints.gridy = 0;
        panel.add(new JTextField(15), constraints);

        // Email Label
        constraints.gridx = 0;
        constraints.gridy = 1;
        panel.add(new JLabel("Email:"), constraints);

        // Email Field
        constraints.gridx = 1;
        constraints.gridy = 1;
        panel.add(new JTextField(15), constraints);

        // Password Label
        constraints.gridx = 0;
        constraints.gridy = 2;
        panel.add(new JLabel("Password:"), constraints);

        // Password Field
        constraints.gridx = 1;
        constraints.gridy = 2;
        panel.add(new JPasswordField(15), constraints);

        // Submit Button
        constraints.gridx = 0;
        constraints.gridy = 3;
        constraints.gridwidth = 2; // Span across 2 columns
        constraints.anchor = GridBagConstraints.CENTER; // Center the button
        panel.add(new JButton("Submit"), constraints);

        frame.add(panel);
        frame.setVisible(true);
    }
}
```

## GroupLayout in Swing: Problem, Solution, and Example

### Definition:

The `GroupLayout` is a layout manager designed specifically to cater to modern UI design patterns. Introduced with Java 6, its primary goal is to simplify the creation of complex layouts by grouping components together (either sequentially or in parallel), enabling you to align and synchronize sizes of components.

### Characteristics:

1. **Sequential and Parallel Groupings**: Components can be grouped either sequentially (one after another) or in parallel (aligned with each other).

2. **Designed for GUI Builders**: Though it can be used manually, `GroupLayout` is mainly designed for GUI builders like NetBeans. The layout specifications can be verbose and complex, making the visual tools beneficial.

3. **Gap Management**: `GroupLayout` provides automatic gap management. It can insert gaps between components and honor the platform-specific guidelines for margins and spacing.

4. **Alignment and Synchronization**: Components can be aligned based on their leading or trailing edges, baselines, or centers. It can also synchronize the sizes of components, ensuring, for example, that two buttons maintain the same width.

5. **Resizable**: `GroupLayout` respects component size preferences but will stretch them if extra space is available. However, how much each component grows can be controlled.

6. **Honors Minimum, Preferred, and Maximum Sizes**: While laying out components, `GroupLayout` considers their minimum, preferred, and maximum sizes.

7. **No Grid**: Unlike `GridBagLayout` or `GridLayout`, `GroupLayout` doesn't work on a traditional grid system. Instead, it manages components based on their relationships (groupings).

---

By grouping components and providing powerful alignment and sizing synchronization, `GroupLayout` offers a way to design complex user interfaces with a cleaner and more intuitive approach than some of the older layout managers.

### Problem Statement:

You're tasked with designing a login form for an application. The form should have a couple of labels ("Username:" and "Password:") on the left, corresponding input fields on the right, and two buttons ("Login" and "Cancel") below the fields. How can you achieve this using Swing's layout managers?

### Solution with GroupLayout:

`GroupLayout` was designed for GUI builders, but it can also be used manually. It's perfect for creating forms because it allows components to be positioned in parallel and sequential groups. For the login form:

- Labels will be placed in a parallel group vertically.
- Input fields will also be placed in another parallel group vertically.
- Both labels and fields will be grouped sequentially, horizontally.
- The "Login" and "Cancel" buttons will be placed in a sequential group horizontally.

### Code Example:

```java
import javax.swing.*;
import java.awt.*;

public class LoginFormDemo {

    public static void main(String[] args) {
        JFrame frame = new JFrame("Login Form");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 150);

        JPanel panel = new JPanel();
        GroupLayout layout = new GroupLayout(panel);
        panel.setLayout(layout);

        // Components
        JLabel userLabel = new JLabel("Username:");
        JLabel passLabel = new JLabel("Password:");
        JTextField userField = new JTextField(10);
        JPasswordField passField = new JPasswordField(10);
        JButton loginButton = new JButton("Login");
        JButton cancelButton = new JButton("Cancel");

        // Horizontally: place components in sequence
        layout.setHorizontalGroup(
            layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(userLabel)
                    .addComponent(passLabel))
                .addGroup(layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(userField)
                    .addComponent(passField)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(loginButton)
                        .addComponent(cancelButton)))
        );

        // Vertically: group components parallel
        layout.setVerticalGroup(
            layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(userLabel)
                    .addComponent(userField))
                .addGroup(layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(passLabel)
                    .addComponent(passField))
                .addGroup(layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(loginButton)
                    .addComponent(cancelButton))
        );

        frame.add(panel);
        frame.pack();
        frame.setVisible(true);
    }
}
```

## Using No Layout Managers

### Definition:

By default, every container in Swing has a layout manager to manage the positioning and sizing of components. However, sometimes developers might decide to manage the positioning and sizing of components manually by setting the layout manager to `null`. This means you're handling the layout yourself without the assistance of any predefined layout manager.

### Characteristics:

1. **Absolute Positioning and Sizing**: When not using a layout manager, you have to explicitly set the bounds (i.e., x, y, width, and height) of every component using the `setBounds` method.

2. **No Automatic Adjustment**: Components won't automatically adjust their position or size when the container is resized. The components will stay exactly where you've placed them.

3. **Higher Control**: Developers get pixel-perfect control over every aspect of the component's positioning and size.

4. **Less Responsive**: Without a layout manager, creating a responsive design that looks good on all screen sizes and resolutions can be challenging.

5. **Maintenance Challenges**: As the UI evolves or scales, managing component positions and sizes manually can become tedious and prone to errors.

6. **Platform Independence**: One of the core strengths of Swing is its ability to provide a consistent look and feel across different platforms. Using no layout manager might sacrifice some of this consistency.

---

### Considerations:

While using no layout manager gives you ultimate control, it's often at the expense of flexibility and maintainability. It's typically recommended for situations where absolute positioning is necessary, and the container won't be resized or modified frequently.

For complex, dynamic, or resizable interfaces, using an appropriate layout manager can save time, reduce errors, and result in a more user-friendly interface.

## Example: No Layout Manager for a Login Form

Consider a scenario where you want to create a basic login form with two labels ("Username" and "Password"), corresponding text fields, and a "Login" button.

### Code Example:

```java
import javax.swing.*;

public class NoLayoutManagerExample {
    public static void main(String[] args) {
        // Create a new JFrame instance
        JFrame frame = new JFrame("Login Form");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 200);
        
        // Set layout to null for manual positioning
        frame.setLayout(null);
        
        // Create components
        JLabel userLabel = new JLabel("Username:");
        JLabel passLabel = new JLabel("Password:");
        JTextField userField = new JTextField(15);
        JPasswordField passField = new JPasswordField(15);
        JButton loginButton = new JButton("Login");
        
        // Set positions using setBounds
        userLabel.setBounds(50, 30, 80, 25);
        userField.setBounds(130, 30, 100, 25);
        passLabel.setBounds(50, 70, 80, 25);
        passField.setBounds(130, 70, 100, 25);
        loginButton.setBounds(105, 110, 80, 25);
        
        // Add components to the frame
        frame.add(userLabel);
        frame.add(userField);
        frame.add(passLabel);
        frame.add(passField);
        frame.add(loginButton);
        
        // Set the frame visibility
        frame.setVisible(true);
    }
}
```


## Custom Layout Managers

### Introduction:

In Java Swing, while there are several predefined layout managers available, there might be specific scenarios or unique requirements where they might not fit the bill. For these cases, developers can create their own custom layout managers by implementing the `LayoutManager` interface or extending existing ones like `LayoutManager2`. A custom layout manager provides granular control over how components are arranged in a container, giving you the freedom to define your own rules and behavior for component placement.

### Characteristics:

1. **Flexibility**: The primary advantage is the ability to define your own layout logic to suit any specific needs or designs.
  
2. **Granular Control**: You determine the exact behavior of components in various scenarios like resizing, adding, or removing components.

3. **Reuse**: Once defined, a custom layout manager can be reused across different projects or components, ensuring consistent UI design.

4. **Complexity**: Developing a custom layout manager can be more complex than using predefined ones, especially when considering various edge cases and component interactions.

5. **Performance**: As you control the layout logic, there's potential for optimization, especially in scenarios where standard layout managers might be inefficient.

---

### Example:

Let's create a simple custom layout manager that arranges components in a diagonal fashion:

## CenterColumnLayout - Custom Layout Manager


### Example:

```java
import java.awt.*;

public class CenterColumnLayout implements LayoutManager {

    private int vgap;  // vertical gap between components

    public CenterColumnLayout(int vgap) {
        this.vgap = vgap;
    }

    @Override
    public void addLayoutComponent(String name, Component comp) {}

    @Override
    public void removeLayoutComponent(Component comp) {}

    @Override
    public Dimension preferredLayoutSize(Container parent) {
        Dimension dim = new Dimension(0, 0);
        int n = parent.getComponentCount();

        for (int i = 0; i < n; i++) {
            Component c = parent.getComponent(i);
            if (c.isVisible()) {
                Dimension d = c.getPreferredSize();
                dim.width = Math.max(dim.width, d.width);
                if (i > 0) {
                    dim.height += vgap;
                }
                dim.height += d.height;
            }
        }
        Insets insets = parent.getInsets();
        dim.width += insets.left + insets.right;
        dim.height += insets.top + insets.bottom + vgap * 2;
        return dim;
    }

    @Override
    public Dimension minimumLayoutSize(Container parent) {
        return preferredLayoutSize(parent);
    }

    @Override
    public void layoutContainer(Container parent) {
        Insets insets = parent.getInsets();
        int maxWidth = parent.getWidth() - (insets.left + insets.right);
        int totalHeight = preferredLayoutSize(parent).height - (insets.top + insets.bottom);
        int startY = (parent.getHeight() - totalHeight) / 2; // start y-coordinate to make it centered

        int x, y = startY;

        for (Component c : parent.getComponents()) {
            if (c.isVisible()) {
                Dimension d = c.getPreferredSize();
                x = (maxWidth - d.width) / 2; // center the component horizontally
                c.setBounds(x, y, d.width, d.height);
                y += d.height + vgap;  // move y-coordinate for next component
            }
        }
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("CenterColumnLayout Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 300);
        frame.setLayout(new CenterColumnLayout(10));

        frame.add(new JButton("Button 1"));
        frame.add(new JButton("Button 2"));
        frame.add(new JLabel("Centered Label"));
        frame.add(new JButton("Button 3"));

        frame.setVisible(true);
    }
}
```
## Text Input in Swing

# Text Input in Swing

## Introduction
In Java's Swing framework, text input components play a fundamental role in user interaction. Whether it's for a simple login form, a text editor, or a search field, Swing provides a variety of components tailored to different input needs. These components facilitate the acquisition of textual data from users, which can be processed, stored, or displayed as per application requirements.

## Characteristics

- **Flexibility**: Swing text components can handle everything from plain text to styled content like HTML.
- **Interactivity**: These components can be combined with listeners to respond immediately to user actions or inputs.
- **Customizability**: The look and feel of text input components can be customized using various methods, including using custom UIs and painting routines.
- **Data Security**: For sensitive input, like passwords, Swing provides components that can mask entered data.
- **Extensibility**: The Swing text components' behavior can be extended, and their properties can be tailored to specific needs.

## Types

### 1. `JTextField`
   - **Description**: A single-line textbox ideal for short textual input.
   - **Example**:
     ```java
     JTextField textField = new JTextField(20);  // 20 columns wide
     frame.add(textField);
     ```

### 2. `JPasswordField`
   - **Description**: A text field specialized for password entry. It conceals the actual characters typed.
   - **Example**:
     ```java
     JPasswordField passwordField = new JPasswordField(20);
     frame.add(passwordField);
     ```

### 3. `JTextArea`
   - **Description**: A multiline text area suitable for larger text input or display. Can be embedded in a scroll pane for added functionality.
   - **Example**:
     ```java
     JTextArea textArea = new JTextArea(5, 20);  // 5 rows and 20 columns
     JScrollPane scrollPane = new JScrollPane(textArea);
     frame.add(scrollPane);
     ```

### 4. `JEditorPane`
   - **Description**: A versatile text component capable of editing plain text, RTF, and HTML content.
   - **Example**:
     ```java
     JEditorPane editorPane = new JEditorPane();
     editorPane.setContentType("text/html");
     editorPane.setText("<h1>Hello, Swing!</h1><p>This is HTML content.</p>");
     frame.add(new JScrollPane(editorPane));
     ```

Each of these text input types in Swing serves a distinct purpose and is geared towards specific use cases. Choosing the right one depends on the requirements of the application being developed.

# TextFields in Swing

## Introduction
`JTextField` is one of the most commonly used components in Java Swing for gathering text input from the user. It provides a single-line area for the user to input text.

## Characteristics
- **Single Line Input**: `JTextField` is ideal for single-line input, like usernames, search queries, or any short text input.  
- **Customizable Size**: The size of the field can be defined by the number of columns it should display.
- **Event Handling**: Action listeners can be added to respond to events, such as when the user presses the Enter key.
- **Text Manipulation**: Methods like `getText()` and `setText(String t)` provide ways to retrieve and set the content of the text field respectively.

## Example

Here's a simple Swing example to demonstrate the use of `JTextField`:

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class TextFieldExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("JTextField Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        JPanel panel = new JPanel();
        
        JLabel label = new JLabel("Enter your name:");
        panel.add(label);
        
        JTextField textField = new JTextField(20);
        panel.add(textField);
        
        JButton button = new JButton("Submit");
        button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String name = textField.getText();
                JOptionPane.showMessageDialog(frame, "Hello, " + name + "!");
            }
        });
        panel.add(button);
        
        frame.add(panel);
        frame.setVisible(true);
    }
}
```

# PasswordFields in Swing

## Introduction
`JPasswordField` is a Swing component used for inputting sensitive data such as passwords. It inherits from `JTextField` but masks the entered text for added security. Typically, the characters entered into a `JPasswordField` are replaced by asterisks (`*`) or dots to conceal the password from prying eyes.

## Characteristics
- **Text Masking**: By default, `JPasswordField` masks entered characters with a dot (`•`). You can change this masking character if needed.
- **Character Retrieval**: It provides a method `getPassword()` which returns the password as a char array instead of a string for security reasons. It is recommended to handle password data as char array and then clear it as soon as it's not needed to minimize the time it stays in memory.
- **Text Manipulation**: Like `JTextField`, it provides the `setText(String t)` method, but caution should be exercised when using it with sensitive data.
- **Event Handling**: Similar to `JTextField`, action listeners can be added to respond to user actions.

## Example

Here's a simple Swing example to demonstrate the use of `JPasswordField`:

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class PasswordFieldExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("JPasswordField Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        JPanel panel = new JPanel();
        
        JLabel label = new JLabel("Enter your password:");
        panel.add(label);
        
        JPasswordField passwordField = new JPasswordField(20);
        panel.add(passwordField);
        
        JButton button = new JButton("Submit");
        button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                char[] password = passwordField.getPassword();
                // Handle password. Here, just displaying length for demonstration.
                JOptionPane.showMessageDialog(frame, "Password length: " + password.length);
                // Clear the password char array for security
                java.util.Arrays.fill(password, '0');
            }
        });
        panel.add(button);
        
        frame.add(panel);
        frame.setVisible(true);
    }
}
```

# TextAreas in Swing

## Introduction
`JTextArea` is a multi-line area in Java Swing that allows users to enter or display plain text. It's suitable for larger chunks of text, such as comments, descriptions, or any form of multiline input.

## Characteristics
- **Multiline Input**: Unlike `JTextField`, which is for single-line input, `JTextArea` supports multiline text entry.
- **Scrolling**: Often wrapped inside a `JScrollPane` to provide scroll bars when the text exceeds the visible area.
- **Text Manipulation**: Methods like `append(String text)`, `getText()`, and `setText(String t)` are available to manage the text within the area.
- **Line Wrapping**: Provides the capability to set line wrapping, ensuring that lines are wrapped at word boundaries.
- **Editable & Non-Editable**: You can make a `JTextArea` non-editable, which is useful for displaying logs or other text-based outputs that users shouldn't modify.

## Example

Here's a simple Swing example demonstrating the use of `JTextArea`:

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class TextAreaExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("JTextArea Example");
        frame.setSize(400, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        JPanel panel = new JPanel();
        
        JTextArea textArea = new JTextArea(10, 30); // 10 rows, 30 columns
        textArea.setLineWrap(true);
        textArea.setWrapStyleWord(true);
        
        JScrollPane scrollPane = new JScrollPane(textArea);
        panel.add(scrollPane);
        
        JButton button = new JButton("Display Text");
        button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                JOptionPane.showMessageDialog(frame, textArea.getText());
            }
        });
        panel.add(button);
        
        frame.add(panel);
        frame.setVisible(true);
    }
}
```

# JScrollPane in Swing

## Introduction
`JScrollPane` is a component in Java Swing that provides a scrollable view of another component. When the visible area of the contained component is smaller than the component itself, scroll bars become available, allowing users to navigate through the full content.

## Characteristics
- **Viewport**: The visible part of the contained component is referred to as the viewport. 
- **Scroll Bars**: Horizontal and/or vertical scroll bars are provided based on the size of the content relative to the viewport. They can be set to always appear, never appear, or appear only when necessary.
- **Adjustable Viewing Area**: The size of the viewport can be adjusted, which in turn affects when the scroll bars appear.
- **Compatibility**: `JScrollPane` can work with various components, most commonly with `JTextArea`, `JTable`, `JList`, and `JTree`.

## Example

Here's a simple Swing example to demonstrate the use of `JScrollPane`:

```java
import javax.swing.*;
import java.awt.*;

public class ScrollPaneExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("JScrollPane Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Create a long content for JTextArea
        String longText = "This is a long text that exceeds the visible area of the JFrame.\n";
        for (int i = 0; i < 20; i++) {
            longText += longText;
        }

        JTextArea textArea = new JTextArea(longText);
        JScrollPane scrollPane = new JScrollPane(textArea);

        frame.add(scrollPane);
        frame.setVisible(true);
    }
}
```

# JLabel in Swing

## Introduction
`JLabel` is a lightweight Swing component used to display a short piece of text, an image, or both. It doesn't react to user input, making it ideal for labelling other user interface components.

## Characteristics
- **Text Display**: Can display a single line of text. For multiline text, HTML formatting can be utilized.
- **Image Display**: Can display an icon (usually an `ImageIcon`) alongside or instead of text.
- **Alignment**: Both text and image can be aligned horizontally and vertically within the label's borders.
- **Tooltips**: Tooltips can be associated with a `JLabel` to provide additional information when the user hovers over it.
- **Labelling Components**: One common use of `JLabel` is to label other components, especially components that don't display their own labels, such as `JTextField`.

## Example

Here's a simple Swing example to demonstrate the use of `JLabel`:

```java
import javax.swing.*;
import java.awt.*;

public class LabelExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("JLabel Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new FlowLayout());

        JLabel label = new JLabel("Enter your name:");
        JTextField textField = new JTextField(15);
        
        // Associating JLabel with JTextField using setLabelFor()
        label.setLabelFor(textField);

        frame.add(label);
        frame.add(textField);
        frame.setVisible(true);
    }
}
```

# Choice Components in Swing

## Definition
Choice components in Swing offer a way to make selections or choices within a user interface. They present multiple options to the user, from which one or several can be chosen based on the nature of the component.

## Types

### 1. Check Boxes (`JCheckBox`)
- **Definition**: A `JCheckBox` represents an on/off or true/false choice. Multiple check boxes can be selected simultaneously.
- **Usage**: Often used when the user is allowed to make multiple selections from a set of options.

### 2. Radio Buttons (`JRadioButton`)
- **Definition**: A `JRadioButton` allows a single choice from a set of options. Radio buttons are typically grouped together using the `ButtonGroup` class, ensuring that only one can be selected at a time.
- **Usage**: Suitable when only one option needs to be selected from a group.

### 3. Combo Boxes (`JComboBox`)
- **Definition**: A `JComboBox` provides a drop-down list of items from which users can select. It can be both non-editable (select only) and editable (allowing custom input).
- **Usage**: Used when the user needs to choose from a predefined list of options, with optional custom input in the case of an editable combo box.

### 4. Sliders (`JSlider`)
- **Definition**: A `JSlider` represents a range of values through a draggable knob. The user can select a value by moving this knob along the range.
- **Usage**: Often used for adjusting settings that have a range, like volume or brightness controls.

## Note
All these components provide mechanisms to add listeners, which allow developers to respond to user choices and selections programmatically.

# Check Boxes (`JCheckBox`) in Swing

## Definition
A `JCheckBox` is a graphical user interface component in Java Swing that represents an on/off or true/false choice. It offers a box that can be either checked (selected) or unchecked (deselected). Multiple check boxes can be selected simultaneously, making them suitable for scenarios where multiple options can be chosen at once.

## Example

The following is a basic Java Swing program that demonstrates the use of `JCheckBox`:

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class JCheckBoxExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("JCheckBox Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new FlowLayout());

        JCheckBox checkBox1 = new JCheckBox("Option 1");
        JCheckBox checkBox2 = new JCheckBox("Option 2");
        JCheckBox checkBox3 = new JCheckBox("Option 3");

        JButton button = new JButton("Submit");
        button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                StringBuilder result = new StringBuilder("Selected Options: ");
                if (checkBox1.isSelected()) {
                    result.append("Option 1, ");
                }
                if (checkBox2.isSelected()) {
                    result.append("Option 2, ");
                }
                if (checkBox3.isSelected()) {
                    result.append("Option 3");
                }
                JOptionPane.showMessageDialog(frame, result.toString());
            }
        });

        frame.add(checkBox1);
        frame.add(checkBox2);
        frame.add(checkBox3);
        frame.add(button);

        frame.setVisible(true);
    }
}
```

# Radio Buttons (`JRadioButton`) in Swing

## Definition
A `JRadioButton` is a graphical user interface component in Java Swing that allows a user to choose one option from a set of options. Radio buttons are typically grouped together using the `ButtonGroup` class, ensuring that only one can be selected at a time. This exclusivity makes them suitable for scenarios where only one option should be chosen from a group.

## Example

Here's a basic Java Swing program demonstrating the use of `JRadioButton`:

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class JRadioButtonExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("JRadioButton Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new FlowLayout());

        JRadioButton option1 = new JRadioButton("Option 1");
        JRadioButton option2 = new JRadioButton("Option 2");
        JRadioButton option3 = new JRadioButton("Option 3");

        // Grouping the radio buttons to ensure only one can be selected
        ButtonGroup group = new ButtonGroup();
        group.add(option1);
        group.add(option2);
        group.add(option3);

        JButton submitButton = new JButton("Submit");
        submitButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String selectedOption = "";
                if (option1.isSelected()) {
                    selectedOption = "Option 1";
                } else if (option2.isSelected()) {
                    selectedOption = "Option 2";
                } else if (option3.isSelected()) {
                    selectedOption = "Option 3";
                }
                JOptionPane.showMessageDialog(frame, "Selected: " + selectedOption);
            }
        });

        frame.add(option1);
        frame.add(option2);
        frame.add(option3);
        frame.add(submitButton);

        frame.setVisible(true);
    }
}
```
# Borders in Swing

## Definition
In Java Swing, a border is an aesthetic and functional decoration around a Swing component. The `javax.swing.border` package provides a range of border styles that can be applied to Swing components, adding visual cues and separation between elements. Borders can encapsulate just about any Swing component, from simple labels to more complex panels.

## Common Types of Borders:

1. **LineBorder**: A simple line border around a component.
2. **EtchedBorder**: Gives the effect of the component being either lowered or raised depending on the type specified.
3. **BevelBorder**: Similar to `EtchedBorder`, but with thicker lines giving a stronger 3D effect.
4. **TitledBorder**: Wraps another border and adds a title to it.
5. **CompoundBorder**: A combination of two borders.

## Example:

Below is a simple example showcasing different border types:

```java
import javax.swing.*;
import javax.swing.border.*;

public class BordersExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("Borders Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 400);
        frame.setLayout(new GridLayout(5, 1));

        JButton btn1 = new JButton("LineBorder");
        btn1.setBorder(new LineBorder(Color.BLUE, 3));

        JButton btn2 = new JButton("EtchedBorder");
        btn2.setBorder(new EtchedBorder(EtchedBorder.RAISED));

        JButton btn3 = new JButton("BevelBorder");
        btn3.setBorder(new BevelBorder(BevelBorder.LOWERED));

        JButton btn4 = new JButton("TitledBorder");
        btn4.setBorder(new TitledBorder(new LineBorder(Color.RED, 2), "Title"));

        JButton btn5 = new JButton("CompoundBorder");
        btn5.setBorder(new CompoundBorder(new LineBorder(Color.GREEN, 3), new BevelBorder(BevelBorder.RAISED)));

        frame.add(btn1);
        frame.add(btn2);
        frame.add(btn3);
        frame.add(btn4);
        frame.add(btn5);

        frame.setVisible(true);
    }
}
```

# Combo Boxes (`JComboBox`) in Swing

## Definition
A `JComboBox` is a component in Java Swing that provides a drop-down list of items from which users can select. It allows users to select an item from a predefined list of options. The combo box can be both non-editable (select only) and editable (permitting user to input custom text in addition to selecting a predefined option).

## Characteristics

- **Drop-down List**: Displays a list of items when clicked.
- **Single Selection**: Allows only one item to be selected at a time.
- **Editable Option**: Can be configured to let users enter their own value.
- **Listeners**: Supports action listeners to detect when an item has been selected or the value has changed.

## Example

Here's a basic Java Swing program demonstrating the use of `JComboBox`:

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class JComboBoxExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("JComboBox Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 150);
        frame.setLayout(new FlowLayout());

        // Create a JComboBox with a few items
        String[] items = {"Option 1", "Option 2", "Option 3"};
        JComboBox<String> comboBox = new JComboBox<>(items);
        
        JButton submitButton = new JButton("Submit");
        submitButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String selectedItem = (String) comboBox.getSelectedItem();
                JOptionPane.showMessageDialog(frame, "Selected: " + selectedItem);
            }
        });

        frame.add(comboBox);
        frame.add(submitButton);
        
        frame.setVisible(true);
    }
}
```

# Sliders (`JSlider`) in Swing

## Definition
A `JSlider` is a component in Java Swing that lets users select a value from a range by sliding a knob within a bounded interval. Sliders can be oriented both horizontally and vertically, providing a visual and intuitive way for users to set values within a specified range.

## Characteristics

- **Range**: The slider has a minimum, maximum, and a current value.
- **Orientation**: Can be displayed either horizontally or vertically.
- **Ticks**: Can be configured to display major and minor tick marks.
- **Labels**: Supports labeling at major tick marks.
- **Listeners**: Supports change listeners to detect when the value of the slider has changed.

## Example

Here's a simple Java Swing program demonstrating the use of `JSlider`:

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.event.*;

public class JSliderExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("JSlider Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);
        frame.setLayout(new FlowLayout());

        // Create a JSlider with range from 0 to 100, initial value set to 50
        JSlider slider = new JSlider(JSlider.HORIZONTAL, 0, 100, 50);
        
        // Add major and minor ticks to the slider
        slider.setMajorTickSpacing(20);
        slider.setMinorTickSpacing(5);
        slider.setPaintTicks(true);
        slider.setPaintLabels(true);

        JLabel label = new JLabel("Selected Value: 50");
        
        slider.addChangeListener(new ChangeListener() {
            public void stateChanged(ChangeEvent e) {
                int value = ((JSlider) e.getSource()).getValue();
                label.setText("Selected Value: " + value);
            }
        });

        frame.add(slider);
        frame.add(label);
        
        frame.setVisible(true);
    }
}
```
# Menus in Swing

## Introduction
Menus in Java Swing provide a structured way to organize commands, options, and actions in a user interface. They are crucial for reducing clutter, especially in applications with numerous functions. Menus often reside at the top of a window (in a menu bar) but can also be used in other contexts, such as context (right-click) menus.

## Types of Menus

# Menu Building in Java Swing

## Introduction
Building menus in Java Swing applications is a systematic process that involves creating menu items, adding them to menus, and then adding those menus to a menu bar. Menus are essential for organizing the features and functionalities of an application, providing an intuitive navigation system.


1. **Create a Menu Bar (`JMenuBar`)**: This acts as the container for all your menus.
2. **Define Menus (`JMenu`)**: Create main categories like "File", "Edit", "Help", etc.
3. **Add Menu Items (`JMenuItem`)**: These are the individual commands or options within a `JMenu`.
4. **Add Optional Submenus**: Menus can be nested to provide a hierarchical structure.
5. **Add Action Listeners**: To make menus interactive, you'll often attach action listeners to individual menu items.
6. **Add the Menu Bar to a Frame**: Finally, the `JMenuBar` is added to the `JFrame` to display it in your application.

## Example

Here's a basic menu structure for a hypothetical text editor:

```java
import javax.swing.*;
import java.awt.event.*;

public class MenuExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("Menu Building Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        // Create a menu bar
        JMenuBar menuBar = new JMenuBar();
        
        // Create menus
        JMenu fileMenu = new JMenu("File");
        JMenu editMenu = new JMenu("Edit");
        
        // Create and add menu items to the "File" menu
        JMenuItem newItem = new JMenuItem("New");
        JMenuItem openItem = new JMenuItem("Open");
        fileMenu.add(newItem);
        fileMenu.add(openItem);
        
        // Create and add menu items to the "Edit" menu
        JMenuItem cutItem = new JMenuItem("Cut");
        JMenuItem copyItem = new JMenuItem("Copy");
        editMenu.add(cutItem);
        editMenu.add(copyItem);
        
        // Add menus to the menu bar
        menuBar.add(fileMenu);
        menuBar.add(editMenu);
        
        // Set the menu bar for the frame
        frame.setJMenuBar(menuBar);
        
        frame.setVisible(true);
    }
}
```
# Adding Icons to Menu Items in Java Swing

## Introduction

In Java Swing, you can enhance `JMenuItem`s with icons for a more visually descriptive and interactive user experience. This is often seen in applications where icons alongside text provide a quick visual reference for functionalities.

## Steps to Add Icons to Menu Items

1. **Prepare the Icon**: Ensure you have an icon image file (e.g., `.png`, `.jpg`, `.gif`) available and added to your project resources.
2. **Create an ImageIcon**: Use the `ImageIcon` class to load your icon.
3. **Add the ImageIcon to JMenuItem**: When creating a `JMenuItem`, you can provide the `ImageIcon` as an argument or set it later using the `setIcon` method.

## Example

Here's a basic example to demonstrate adding icons to menu items:

```java
import javax.swing.*;

public class IconMenuExample {

    public static void main(String[] args) {
        JFrame frame = new JFrame("Icon on Menu Items Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        // Create a menu bar
        JMenuBar menuBar = new JMenuBar();
        
        // Create a menu
        JMenu fileMenu = new JMenu("File");
        
        // Load icons
        ImageIcon newIcon = new ImageIcon("path/to/new_icon.png");
        ImageIcon openIcon = new ImageIcon("path/to/open_icon.png");
        
        // Create menu items with icons
        JMenuItem newItem = new JMenuItem("New", newIcon);
        JMenuItem openItem = new JMenuItem("Open", openIcon);
        
        // Add menu items to the menu
        fileMenu.add(newItem);
        fileMenu.add(openItem);
        
        // Add menu to the menu bar
        menuBar.add(fileMenu);
        
        // Set the menu bar for the frame
        frame.setJMenuBar(menuBar);
        
        frame.setVisible(true);
    }
}
```

# CheckBox and Radio Buttons in Menu Items

## Introduction

Menus in Java Swing applications aren't limited to just simple actionable items. They can also contain checkboxes and radio buttons to offer more interactive options. This allows users to select one or multiple choices directly from the menus.

## CheckBox Menu Items (`JCheckBoxMenuItem`)

A `JCheckBoxMenuItem` acts just like a regular checkbox but is situated within a menu. Users can select or deselect it.

### Example:

```java
import javax.swing.*;

public class CheckBoxMenuItemExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("CheckBox in Menu Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        JMenuBar menuBar = new JMenuBar();
        JMenu optionsMenu = new JMenu("Options");

        JCheckBoxMenuItem showGridItem = new JCheckBoxMenuItem("Show Grid");
        optionsMenu.add(showGridItem);

        menuBar.add(optionsMenu);
        frame.setJMenuBar(menuBar);

        frame.setVisible(true);
    }
}
```

## Radio Button Menu Items (`JRadioButtonMenuItem`)
A `JRadioButtonMenuItem` behaves like a regular radio button, which allows users to select one option from a group.

### Example

```
import javax.swing.*;

public class RadioButtonMenuItemExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Radio Button in Menu Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        JMenuBar menuBar = new JMenuBar();
        JMenu themeMenu = new JMenu("Theme");

        JRadioButtonMenuItem lightThemeItem = new JRadioButtonMenuItem("Light");
        JRadioButtonMenuItem darkThemeItem = new JRadioButtonMenuItem("Dark");

        ButtonGroup themeGroup = new ButtonGroup();
        themeGroup.add(lightThemeItem);
        themeGroup.add(darkThemeItem);

        themeMenu.add(lightThemeItem);
        themeMenu.add(darkThemeItem);

        menuBar.add(themeMenu);
        frame.setJMenuBar(menuBar);

        frame.setVisible(true);
    }
}
```

# Pop-up Menus in Java Swing

## Introduction

A pop-up menu, or context menu, appears when a user right-clicks on a component. This menu provides a list of commands that are relevant in the current context. It's a way to offer users additional actions without cluttering the main UI.

## Creating a Pop-up Menu

1. **Initialize a `JPopupMenu`**: Create an instance of the `JPopupMenu` class.
2. **Add Menu Items**: You can add `JMenuItem`, `JCheckBoxMenuItem`, or `JRadioButtonMenuItem` to the `JPopupMenu`.
3. **Add a Mouse Listener**: To detect a right-click and display the menu, you'll need to add a mouse listener to the component.

## Example

Here's an example demonstrating how to create a basic pop-up menu in Java Swing:

```java
import javax.swing.*;
import java.awt.event.*;

public class PopupMenuExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Pop-up Menu Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 300);

        // Create a popup menu
        JPopupMenu popupMenu = new JPopupMenu();

        // Add menu items
        JMenuItem cutItem = new JMenuItem("Cut");
        JMenuItem copyItem = new JMenuItem("Copy");
        JMenuItem pasteItem = new JMenuItem("Paste");

        popupMenu.add(cutItem);
        popupMenu.add(copyItem);
        popupMenu.add(pasteItem);

        // Add mouse listener to frame
        frame.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                // If right-click is detected
                if (SwingUtilities.isRightMouseButton(e)) {
                    popupMenu.show(frame, e.getX(), e.getY());
                }
            }
        });

        frame.setVisible(true);
    }
}
```

# Keyboard Mnemonics and Accelerators in Java Swing

## Introduction

Mnemonics and accelerators in Java Swing allow users to interact with GUI components using keyboard shortcuts. While both provide keyboard accessibility, they're utilized differently:

- **Mnemonic**: A mnemonic is a keyboard shortcut for a GUI control (like a button or menu item). Pressing the 'Alt' key (or 'Cmd' on macOS) in conjunction with the mnemonic character sets focus to that control.
  
- **Accelerator**: An accelerator is a keyboard shortcut that directly triggers a component's action without navigating to it (e.g., Ctrl+C for copy).

## Mnemonics

Mnemonics usually appear as underlined letters in a component's text. They guide the user in pressing the right key in combination with the 'Alt' key.

### Example:

```java
import javax.swing.*;

public class MnemonicExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Mnemonic Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 200);

        JMenuBar menuBar = new JMenuBar();
        JMenu fileMenu = new JMenu("File");
        fileMenu.setMnemonic('F');  // Set mnemonic to 'F'

        JMenuItem exitItem = new JMenuItem("Exit");
        exitItem.setMnemonic('E');  // Set mnemonic to 'E'
        fileMenu.add(exitItem);

        menuBar.add(fileMenu);
        frame.setJMenuBar(menuBar);
        
        frame.setVisible(true);
    }
}
```

## Accelerators


Accelerators are key combinations that, when pressed, directly perform the associated action of a component.

### Example:


```
import javax.swing.*;
import java.awt.event.KeyEvent;
import java.awt.event.InputEvent;

public class AcceleratorExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Accelerator Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 200);

        JMenuBar menuBar = new JMenuBar();
        JMenu fileMenu = new JMenu("File");

        JMenuItem newItem = new JMenuItem("New");
        newItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_N, InputEvent.CTRL_MASK));
        fileMenu.add(newItem);

        menuBar.add(fileMenu);
        frame.setJMenuBar(menuBar);
        
        frame.setVisible(true);
    }
}

```

# Enabling and Designing Menu Items in Java Swing

## Introduction

In GUI applications, menu items can be enabled or disabled based on certain conditions or the state of the application. For instance, a "Paste" option might only be enabled when there's data on the clipboard. In addition to enabling/disabling, Swing allows you to design and style your menu items to make them visually appealing and more intuitive.

## Enabling and Disabling Menu Items

Swing provides a straightforward method to enable or disable menu items using the `setEnabled` method.

### Example:

```
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class MenuExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Menu Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 300);

        // Create a menu bar
        JMenuBar menuBar = new JMenuBar();

        // Create a "File" menu
        JMenu fileMenu = new JMenu("File");
        JMenuItem newItem = new JMenuItem("New");
        JMenuItem openItem = new JMenuItem("Open");
        JMenuItem saveItem = new JMenuItem("Save");
        JMenuItem exitItem = new JMenuItem("Exit");

        // Add menu items to the "File" menu
        fileMenu.add(newItem);
        fileMenu.add(openItem);
        fileMenu.add(saveItem);
        fileMenu.addSeparator(); // Add a separator line
        fileMenu.add(exitItem);

        // Add an accelerator (keyboard shortcut) to the "New" menu item
        newItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_N, InputEvent.CTRL_MASK));

        // Disable the "Save" menu item initially
        saveItem.setEnabled(false);

        // Create a "Edit" menu
        JMenu editMenu = new JMenu("Edit");
        JMenuItem cutItem = new JMenuItem("Cut");
        JMenuItem copyItem = new JMenuItem("Copy");
        JMenuItem pasteItem = new JMenuItem("Paste");

        // Add menu items to the "Edit" menu
        editMenu.add(cutItem);
        editMenu.add(copyItem);
        editMenu.add(pasteItem);

        // Create icons for menu items
        ImageIcon saveIcon = new ImageIcon("save.png");
        saveItem.setIcon(saveIcon);

        // Add menus to the menu bar
        menuBar.add(fileMenu);
        menuBar.add(editMenu);

        // Set the menu bar for the frame
        frame.setJMenuBar(menuBar);

        // ActionListener for the "Exit" menu item
        exitItem.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });

        // ActionListener for the "New" menu item (Accelerator)
        newItem.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                JOptionPane.showMessageDialog(frame, "New File Created.");
            }
        });

        // ActionListener for the "Paste" menu item
        pasteItem.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                JOptionPane.showMessageDialog(frame, "Paste functionality not implemented.");
            }
        });

        frame.setVisible(true);
    }
}
```

# Toolbars in Java Swing

## Introduction

A toolbar in Java Swing is a graphical user interface element that provides quick access to commonly used actions or functions within an application. Toolbars typically contain buttons, icons, or other interactive components, making it easy for users to perform tasks without navigating through menus.

## Creating a Toolbar

Creating a toolbar in Swing involves several steps:

1. **Create a `JToolBar`**: Instantiate a `JToolBar` object to serve as the container for your toolbar components.

2. **Add Components**: Add buttons, icons, or other components to the `JToolBar`. These components represent the actions or functions users can trigger.

3. **Add the Toolbar to the Frame**: Add the `JToolBar` to the frame or panel where you want it to appear.

## Example

Here's a simple Java Swing program that demonstrates the creation of a toolbar with buttons:

```java
import javax.swing.*;
import java.awt.*;

public class ToolbarExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Toolbar Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        // Create a toolbar
        JToolBar toolbar = new JToolBar("Toolbar");

        Dimension buttonSize = new Dimension(100, 80);  // Preferred button size

        // Create toolbar buttons
        JButton newButton = new JButton("New");
        newButton.setToolTipText("New");
        newButton.setPreferredSize(buttonSize);

        JButton openButton = new JButton("Open");
        openButton.setToolTipText("Open");
        openButton.setPreferredSize(buttonSize);

        JButton saveButton = new JButton("Save");
        saveButton.setToolTipText("Save");
        saveButton.setPreferredSize(buttonSize);

        // Add buttons to the toolbar
        toolbar.add(newButton);
        toolbar.add(openButton);
        toolbar.add(saveButton);

        // Add the toolbar to the frame
        frame.add(toolbar, BorderLayout.NORTH);

        frame.setVisible(true);
    }
}
```

# Tooltips in Java Swing

## Introduction

Tooltips are small, informational pop-up windows that appear when a user hovers the mouse pointer over a graphical component. In Java Swing, tooltips are a valuable feature for providing users with additional context, explanations, or descriptions of UI elements. They make the user interface more user-friendly and informative.

## Adding Tooltips to Components

Adding tooltips to Swing components is straightforward:

1. **Create the Component**: First, create the graphical component (e.g., JButton, JMenuItem) to which you want to add a tooltip.

2. **Set the Tooltip Text**: Use the `setToolTipText` method to specify the tooltip text for the component. This text will be displayed when the user hovers over the component.

## Example

Here's a Java Swing program that demonstrates the use of tooltips with buttons:

```java
import javax.swing.*;
import java.awt.*;

public class TooltipExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Tooltip Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        JPanel panel = new JPanel();

        // Create buttons with tooltips
        JButton button1 = new JButton("Button 1");
        button1.setToolTipText("Click this button to perform action 1");

        JButton button2 = new JButton("Button 2");
        button2.setToolTipText("Click this button to perform action 2");

        JButton button3 = new JButton("Button 3");
        button3.setToolTipText("Click this button to perform action 3");

        // Add buttons to the panel
        panel.add(button1);
        panel.add(button2);
        panel.add(button3);

        // Add the panel to the frame
        frame.add(panel);

        frame.setVisible(true);
    }
}
```

## Dialog Boxes 

# Option Dialogs in Java Swing

## Introduction

Option dialogs in Java Swing provide a way to interact with users by presenting them with a set of options, buttons, or choices. These dialogs are used for various purposes, such as confirming an action, getting user input, or allowing users to make a selection from a list of options. Swing provides different types of option dialogs, including message dialogs, input dialogs, and confirmation dialogs.

## Creating and Displaying an Option Dialog

To create and display an option dialog in Swing:

1. **Choose the Type of Option Dialog**: Determine whether you need a message dialog, an input dialog, or a confirmation dialog, depending on your application's requirements.

2. **Create the Option Dialog**: Use one of the Swing classes like `JOptionPane` to create the dialog. You can set the message, title, and option buttons accordingly.

3. **Display the Dialog**: Use the `showXXXDialog` method of `JOptionPane` (e.g., `showMessageDialog`, `showInputDialog`, `showConfirmDialog`) to display the dialog.

4. **Retrieve User's Choice**: Depending on the type of dialog, you can retrieve the user's choice or input.

## Example

Here's a Java Swing program that demonstrates how to create and display a simple confirmation dialog using `JOptionPane`:

```java
import javax.swing.*;

public class OptionDialogExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Option Dialog Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        // Display a confirmation dialog
        int choice = JOptionPane.showConfirmDialog(
            frame,
            "Do you want to save the changes?",
            "Save Confirmation",
            JOptionPane.YES_NO_CANCEL_OPTION
        );

        // Process the user's choice
        if (choice == JOptionPane.YES_OPTION) {
            System.out.println("Changes saved.");
        } else if (choice == JOptionPane.NO_OPTION) {
            System.out.println("Changes not saved.");
        } else if (choice == JOptionPane.CANCEL_OPTION) {
            System.out.println("Operation canceled.");
        }

        frame.setVisible(true);
    }
}
```
# Creating Dialogs in Java Swing

## Introduction

Dialogs in Java Swing are graphical user interface elements used to display pop-up windows with specific purposes, such as getting user input, presenting information, or confirming actions. Creating and customizing dialogs in Swing involves several steps and classes to achieve desired functionality.

## Creating a Basic Dialog

To create a basic dialog in Swing:

1. **Choose a Dialog Type**: Determine the type of dialog you want to create. Options include message dialogs, input dialogs, and custom dialogs.

2. **Create the Dialog**: Instantiate a `JDialog` or a subclass (e.g., `JOptionPane`) based on the chosen dialog type.

3. **Add Components**: Add components such as labels, buttons, and input fields to the dialog to convey information or obtain user input.

4. **Set Dialog Properties**: Configure properties of the dialog, such as title, size, and behavior (e.g., modal or non-modal).

5. **Display the Dialog**: Call the `setVisible(true)` method to display the dialog to the user.

## Example

Here's a Java Swing program that demonstrates how to create and display a custom dialog:

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class CustomDialogExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Custom Dialog Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        JButton openDialogButton = new JButton("Open Custom Dialog");

        openDialogButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Create a custom dialog
                JDialog customDialog = new JDialog(frame, "Custom Dialog", true);
                customDialog.setSize(300, 150);
                customDialog.setLayout(new FlowLayout());

                // Add components to the dialog
                JLabel messageLabel = new JLabel("This is a custom dialog.");
                JButton closeButton = new JButton("Close");

                customDialog.add(messageLabel);
                customDialog.add(closeButton);

                // Configure close button action
                closeButton.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        customDialog.dispose();
                    }
                });

                // Display the custom dialog
                customDialog.setVisible(true);
            }
        });

        frame.add(openDialogButton, BorderLayout.CENTER);

        frame.setVisible(true);
    }
}
```

# Data Exchange in Java Swing

## Introduction

DataExchange in Java Swing involves the transfer of data between Swing components (such as text fields, tables, or lists) and other parts of your application, including databases, models, or other UI components. It is crucial for keeping the user interface synchronized with the underlying data and for handling user input effectively.

## Key Concepts

1. **Model-View-Controller (MVC) Architecture**: Swing applications often follow the MVC design pattern, where data (the model) is separated from the user interface (the view) and the controller handles user input. This separation allows for efficient data exchange.

2. **Listeners and Events**: Swing components use event listeners to detect user interactions (e.g., button clicks, text input changes). When an event occurs, it triggers an event handler, allowing you to update or retrieve data as needed.

## Example

Here's a simple Java Swing program that demonstrates data exchange between a text field and a label:

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class DataExchangeExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Data Exchange Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        JPanel panel = new JPanel();
        panel.setLayout(new FlowLayout());

        JLabel label = new JLabel("Enter text:");
        JTextField textField = new JTextField(15);
        JButton submitButton = new JButton("Submit");

        panel.add(label);
        panel.add(textField);
        panel.add(submitButton);

        // Add an ActionListener to the button
        submitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String text = textField.getText(); // Get text from the text field
                label.setText("You entered: " + text); // Update the label with the entered text
            }
        });

        frame.add(panel);

        frame.setVisible(true);
    }
}
```

# File Chooser in Java Swing

## Introduction

A File Chooser in Java Swing is a user interface component that provides a dialog for users to browse and select files or directories from their local file system. It's a crucial feature for applications that deal with file input and output, such as opening or saving files.

## Using a File Chooser

To use a File Chooser in Swing:

1. **Create an Instance**: Instantiate a `JFileChooser` object, which represents the file chooser dialog.

2. **Configure Options (Optional)**: You can configure the file chooser's behavior, such as setting the initial directory, specifying file filters, and more.

3. **Display the Dialog**: Use one of the `showOpenDialog` or `showSaveDialog` methods to display the file chooser dialog to the user.

4. **Handle User's Selection**: Retrieve the user's selected file or directory using the `getSelectedFile` or `getSelectedFiles` methods.

## Example

Here's a Java Swing program that demonstrates how to use a File Chooser to open a file:

```java
import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;

public class FileChooserExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("File Chooser Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        JPanel panel = new JPanel();
        JButton openButton = new JButton("Open File");

        panel.add(openButton);

        // Create a file chooser
        JFileChooser fileChooser = new JFileChooser();

        openButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Show the file chooser dialog and capture the user's choice
                int result = fileChooser.showOpenDialog(frame);

                if (result == JFileChooser.APPROVE_OPTION) {
                    // Get the selected file
                    File selectedFile = fileChooser.getSelectedFile();
                    JOptionPane.showMessageDialog(
                        frame,
                        "You selected: " + selectedFile.getAbsolutePath(),
                        "File Selected",
                        JOptionPane.INFORMATION_MESSAGE
                    );
                }
            }
        });

        frame.add(panel);
        frame.setVisible(true);
    }
}
```
# Color Chooser in Java Swing

## Introduction

A Color Chooser in Java Swing is a user interface component that provides a dialog for users to choose colors interactively. It's commonly used in applications where users need to select colors for various purposes, such as drawing, text formatting, or setting background colors.

## Using a Color Chooser

To use a Color Chooser in Swing:

1. **Create an Instance**: Instantiate a `JColorChooser` object, which represents the color chooser dialog.

2. **Display the Dialog**: Use the `showDialog` method to display the color chooser dialog to the user. This method returns the selected color or null if the user cancels the dialog.

3. **Handle User's Selection**: Retrieve the user's selected color and use it in your application.

## Example

Here's a Java Swing program that demonstrates how to use a Color Chooser to select and display a chosen color:

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ColorChooserExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Color Chooser Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 200);

        JPanel panel = new JPanel();
        JButton chooseColorButton = new JButton("Choose Color");
        JLabel colorLabel = new JLabel("Selected Color: ");

        panel.add(chooseColorButton);
        panel.add(colorLabel);

        chooseColorButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Create a color chooser dialog
                Color selectedColor = JColorChooser.showDialog(frame, "Choose a Color", Color.BLACK);

                if (selectedColor != null) {
                    // Set the background color of the label to the selected color
                    colorLabel.setBackground(selectedColor);
                    colorLabel.setOpaque(true);
                    colorLabel.setText("Selected Color: ");
                }
            }
        });

        frame.add(panel);
        frame.setVisible(true);
    }
}
```

# Components Organizers in Java Swing

Components organizers in Java Swing are essential elements for structuring and managing the layout of user interfaces. They provide flexibility and user-friendly interaction in Swing applications. Let's explore each of these organizers:

## Split Panes

# Split Panes in Java Swing

Split Panes in Java Swing are user interface components that allow you to divide a container, such as a `JFrame` or `JPanel`, into two or more resizable sections, each of which can hold other Swing components. Users can interactively adjust the sizes of these sections by dragging the divider between them. Split Panes are commonly used to create flexible and adjustable layouts within Swing applications.

## Example

```java
import javax.swing.*;

public class SplitPaneExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Split Pane Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 300);

        JSplitPane splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT);

        // Left component
        JPanel leftPanel = new JPanel();
        leftPanel.add(new JButton("Button 1"));
        leftPanel.add(new JButton("Button 2"));
        splitPane.setLeftComponent(leftPanel);

        // Right component
        JPanel rightPanel = new JPanel();
        rightPanel.add(new JButton("Button 3"));
        rightPanel.add(new JButton("Button 4"));
        splitPane.setRightComponent(rightPanel);

        frame.add(splitPane);

        frame.setVisible(true);
    }
}
```

# Tabbed Panes in Java Swing

Tabbed Panes in Java Swing are user interface components that organize multiple components or panels as tabs. Each tab represents a different view or content, and users can switch between them by clicking on the tabs. This allows for effective space management in Swing applications, especially when dealing with multiple sections of content.

## Example

```java
import javax.swing.*;

public class TabbedPaneExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Tabbed Pane Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 300);

        JTabbedPane tabbedPane = new JTabbedPane();
        
        // Tab 1
        JPanel tab1Panel = new JPanel();
        tab1Panel.add(new JLabel("Content for Tab 1"));
        tabbedPane.addTab("Tab 1", tab1Panel);
        
        // Tab 2
        JPanel tab2Panel = new JPanel();
        tab2Panel.add(new JLabel("Content for Tab 2"));
        tabbedPane.addTab("Tab 2", tab2Panel);
        
        // Tab 3
        JPanel tab3Panel = new JPanel();
        tab3Panel.add(new JLabel("Content for Tab 3"));
        tabbedPane.addTab("Tab 3", tab3Panel);

        frame.add(tabbedPane);

        frame.setVisible(true);
    }
}
```

# Desktop Panes and Internal Frames in Java Swing

Desktop Panes and Internal Frames in Java Swing are components that enable the creation of Multiple Document Interface (MDI) applications. They provide a workspace for managing multiple internal frames independently. Each internal frame represents a distinct document, window, or view within the application. This design is commonly used for applications that need to handle multiple documents or views simultaneously.

## Example

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class DesktopPaneExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Desktop Pane Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);

        JDesktopPane desktopPane = new JDesktopPane();

        JInternalFrame internalFrame = new JInternalFrame("Internal Frame", true, true, true, true);
        internalFrame.setSize(200, 150);
        internalFrame.setLocation(50, 50);

        JButton closeButton = new JButton("Close Internal Frame");
        closeButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                internalFrame.dispose();
            }
        });

        internalFrame.add(closeButton);
        internalFrame.setVisible(true);

        desktopPane.add(internalFrame);

        frame.add(desktopPane, BorderLayout.CENTER);

        frame.setVisible(true);
    }
}
```
# Cascading and Tiling in MDI Applications

Cascading and Tiling are window management techniques used in Multiple Document Interface (MDI) applications. MDI applications allow users to work with multiple documents or views within a single parent window. These techniques help organize and manage open windows effectively.

## Cascading

**Definition:** Cascading is a window management technique that arranges open internal frames (windows) in a cascading manner, where each new window appears slightly offset from the previous one. This allows users to see the titles of all open windows and easily select the one they want to work with. Cascading is helpful when dealing with many open windows.

**Example:** In an MDI text editor, when you open multiple documents, the windows cascade diagonally, making it easy to identify and select the document you want to work on.

## Tiling

**Definition:** Tiling is a window management technique that arranges open internal frames (windows) in a non-overlapping, grid-like pattern within the parent window. It maximizes the use of available screen space by evenly dividing it among open windows. Tiling is useful when you want to see and work with multiple documents simultaneously.

**Example:** In an MDI image editor, when you open multiple images, the windows are arranged in a tiled grid, allowing you to compare and edit images side by side.

Both Cascading and Tiling provide flexibility in managing and working with multiple documents or views in MDI applications. The choice between these techniques depends on user preferences and the nature of the application.

```

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Random;

public class CascadingWindowsExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Cascading Windows Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);
        frame.setLayout(null);

        JButton openWindowButton = new JButton("Open Window");
        openWindowButton.setBounds(10, 10, 120, 30);
        frame.add(openWindowButton);

        openWindowButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JInternalFrame internalFrame = new JInternalFrame("Internal Frame", true, true, true, true);
                internalFrame.setSize(200, 150);

                // Generate random position for cascading
                Random random = new Random();
                int xOffset = random.nextInt(100);
                int yOffset = random.nextInt(100);

                internalFrame.setLocation(xOffset, yOffset);
                frame.add(internalFrame);
                internalFrame.setVisible(true);
            }
        });

        frame.setVisible(true);
    }
}

```
```
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class TilingWindowsExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Tiling Windows Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);

        JDesktopPane desktopPane = new JDesktopPane();
        frame.setContentPane(desktopPane);

        JButton openWindowButton = new JButton("Open Window");
        openWindowButton.setBounds(10, 10, 120, 30);
        frame.add(openWindowButton);

        AtomicInteger xOffset = new AtomicInteger(0);
        AtomicInteger yOffset = new AtomicInteger(0);

        openWindowButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JInternalFrame internalFrame = new JInternalFrame("Internal Frame", true, true, true, true);
                internalFrame.setSize(200, 150);
                internalFrame.setLocation(xOffset.get(), yOffset.get());

                // Calculate next position for tiling
                xOffset.addAndGet(20);
                yOffset.addAndGet(20);

                desktopPane.add(internalFrame);
                internalFrame.setVisible(true);
            }
        });

        frame.setVisible(true);
    }
}

```
# List Component in Java Swing

The List component in Java Swing is used to display a list of items to the user. Users can typically select one or more items from the list, making it a useful tool for presenting choices, options, or data sets in a user-friendly manner.

## Example

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ListExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("List Component Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 200);
        frame.setLayout(new FlowLayout());

        // Create a list with items
        String[] items = {"Item 1", "Item 2", "Item 3", "Item 4", "Item 5"};
        JList<String> list = new JList<>(items);
        list.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);

        // Create a button to get selected items
        JButton getSelectionButton = new JButton("Get Selection");
        JLabel selectionLabel = new JLabel();

        getSelectionButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Get selected items from the list
                String[] selectedItems = list.getSelectedValuesList().toArray(new String[0]);
                String selectedItemsText = "Selected Items: " + String.join(", ", selectedItems);
                selectionLabel.setText(selectedItemsText);
            }
        });

        frame.add(list);
        frame.add(getSelectionButton);
        frame.add(selectionLabel);

        frame.setVisible(true);
    }
}
```

# Tree Component in Java Swing

The Tree component in Java Swing is used to display hierarchical data in a tree-like structure. It allows users to navigate through the data by expanding and collapsing nodes. Trees are commonly used to represent file systems, organizational charts, and any data with a hierarchical structure.

## Example

```java
import javax.swing.*;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import java.awt.*;

public class TreeExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Tree Component Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 200);

        // Create a root node
        DefaultMutableTreeNode root = new DefaultMutableTreeNode("Root");

        // Create child nodes
        DefaultMutableTreeNode node1 = new DefaultMutableTreeNode("Node 1");
        DefaultMutableTreeNode node2 = new DefaultMutableTreeNode("Node 2");
        DefaultMutableTreeNode node3 = new DefaultMutableTreeNode("Node 3");

        // Add child nodes to the root
        root.add(node1);
        root.add(node2);
        root.add(node3);

        // Create a tree with the root node
        JTree tree = new JTree(root);

        // Create a scroll pane for the tree (in case the tree gets too large)
        JScrollPane scrollPane = new JScrollPane(tree);

        frame.add(scrollPane, BorderLayout.CENTER);
        frame.setVisible(true);
    }
}
```

# Table Component in Java Swing

The Table component in Java Swing is used to display tabular data in a grid format. It is a powerful tool for presenting structured data in rows and columns. Swing tables support features such as sorting, filtering, and custom cell rendering, making them suitable for a wide range of applications that involve displaying and manipulating data.

## Example

```java
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;

public class TableExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Table Component Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 300);

        // Create table data
        Object[][] data = {
            {"John", "Doe", 30},
            {"Jane", "Smith", 25},
            {"Bob", "Johnson", 35},
            {"Alice", "Williams", 28}
        };

        // Create column names
        String[] columnNames = {"First Name", "Last Name", "Age"};

        // Create a table model with data and column names
        DefaultTableModel tableModel = new DefaultTableModel(data, columnNames);

        // Create a table with the table model
        JTable table = new JTable(tableModel);

        // Create a scroll pane for the table (in case the table gets too large)
        JScrollPane scrollPane = new JScrollPane(table);

        frame.add(scrollPane, BorderLayout.CENTER);
        frame.setVisible(true);
    }
}
```

# Progress Bar Component in Java Swing

The Progress Bar component in Java Swing is used to visually indicate the progress of a task or operation. It provides users with feedback about the status and completion percentage of a task, such as file downloads, installations, or any long-running process.

## Example

```java
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ProgressBarExample {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Progress Bar Example");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 150);
        frame.setLayout(new FlowLayout());

        // Create a progress bar
        JProgressBar progressBar = new JProgressBar();
        progressBar.setStringPainted(true); // Display percentage text

        // Create a button to start a task
        JButton startButton = new JButton("Start Task");

        startButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Simulate a task that takes time to complete
                int taskDuration = 5000; // 5 seconds
                int interval = 100; // Update interval in milliseconds
                int maxProgress = taskDuration / interval;

                Timer timer = new Timer(interval, new ActionListener() {
                    int progress = 0;

                    @Override
                    public void actionPerformed(ActionEvent e) {
                        if (progress < maxProgress) {
                            progress++;
                            progressBar.setValue((int) ((double) progress / maxProgress * 100));
                        } else {
                            ((Timer) e.getSource()).stop();
                            JOptionPane.showMessageDialog(null, "Task completed!");
                        }
                    }
                });

                timer.start();
            }
        });

        frame.add(progressBar);
        frame.add(startButton);

        frame.setVisible(true);
    }
}
```