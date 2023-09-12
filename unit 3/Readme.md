# Event Handling in Swing

Swing is a robust GUI toolkit for Java, and one of its core functionalities is the ability to handle events, such as button clicks, mouse movements, and key presses. Event handling in Swing is primarily achieved through the use of event listeners.

## Basic Concept of Event Handling

In Swing, when a user interacts with a GUI component (e.g., clicking a button), an event is generated. This event is then passed to any registered listeners for processing.

```java
// Sample code to add an action listener to a JButton
JButton myButton = new JButton("Click Me!");

myButton.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
        System.out.println("Button was clicked!");
    }
});
```

# Listener Interfaces in Swing

Listener interfaces are pivotal in the Java Swing framework. They provide methods that respond to specific types of events. When a particular event occurs on a Swing component, the corresponding method in the listener interface is invoked.

## Commonly Used Listener Interfaces

Below are some commonly used listener interfaces in Swing:

# ActionListener in Swing

In the Swing framework, the `ActionListener` interface plays a central role in handling action events, typically arising from components like buttons, text fields, and menus. By implementing this interface, developers can capture and respond to user-initiated actions.

## Overview

The `ActionListener` interface contains a single method:
- `actionPerformed(ActionEvent e)`: This method is invoked when an action event occurs. The passed `ActionEvent` object contains information about the source of the event, allowing developers to determine which component triggered the action.

## Example Usage

Let's look at a common use case: adding an `ActionListener` to a `JButton` to capture and handle button clicks.

```java
import javax.swing.JButton;
import javax.swing.JFrame;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ButtonClickListener {

    public static void main(String[] args) {
        // Create a new JFrame
        JFrame frame = new JFrame("ActionListener Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(null);

        // Create a JButton
        JButton button = new JButton("Click Me!");
        button.setBounds(90, 70, 120, 30);

        // Add ActionListener to JButton
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.out.println("Button was clicked!");
            }
        });

        // Add button to the JFrame
        frame.add(button);
        frame.setVisible(true);
    }
}
```

# `ComponentListener` in Swing

The Swing framework's `ComponentListener` interface is designed to handle events associated with a component's changes, such as its resizing, movement, showing, or hiding. By implementing this interface, developers can respond to modifications in a component's state or positioning.

## Overview

The `ComponentListener` interface provides four methods to handle component-related events:

1. `componentResized(ComponentEvent e)`: Invoked when the component's size changes.
2. `componentMoved(ComponentEvent e)`: Called when the component's position changes.
3. `componentShown(ComponentEvent e)`: Invoked when the component becomes visible.
4. `componentHidden(ComponentEvent e)`: Called when the component is no longer visible.

## Example Usage

Below is an example demonstrating the use of the `ComponentListener` interface with a `JFrame`. The program will print messages to the console when the JFrame is resized, moved, shown, or hidden:

```java
import javax.swing.JFrame;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;

public class ComponentListenerExample {

    public static void main(String[] args) {
        // Create a new JFrame
        JFrame frame = new JFrame("ComponentListener Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Add ComponentListener to JFrame
        frame.addComponentListener(new ComponentListener() {
            @Override
            public void componentResized(ComponentEvent e) {
                System.out.println("Frame was resized!");
            }

            @Override
            public void componentMoved(ComponentEvent e) {
                System.out.println("Frame was moved!");
            }

            @Override
            public void componentShown(ComponentEvent e) {
                System.out.println("Frame is now visible!");
            }

            @Override
            public void componentHidden(ComponentEvent e) {
                System.out.println("Frame is no longer visible!");
            }
        });

        frame.setVisible(true);
    }
}
```

# `ItemListener` in Swing

In Swing, the `ItemListener` interface is designed to capture and respond to item state change events. Components such as `JCheckBox`, `JRadioButton`, and `JComboBox` often utilize `ItemListener` to detect when the user selects or deselects an item.

## Overview

The `ItemListener` interface provides a single method:
- `itemStateChanged(ItemEvent e)`: This method is invoked when the state of an item changes. The passed `ItemEvent` object contains information about the change, including the source of the event and the new state (selected or deselected).

## Example Usage

Let's consider a scenario using the `ItemListener` with a `JCheckBox`:

```java
import javax.swing.JFrame;
import javax.swing.JCheckBox;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

public class ItemListenerExample {

    public static void main(String[] args) {
        // Create a new JFrame
        JFrame frame = new JFrame("ItemListener Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(null);

        // Create a JCheckBox
        JCheckBox checkBox = new JCheckBox("Click me!");
        checkBox.setBounds(90, 80, 120, 30);

        // Add ItemListener to JCheckBox
        checkBox.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                if (e.getStateChange() == ItemEvent.SELECTED) {
                    System.out.println("Checkbox is selected.");
                } else {
                    System.out.println("Checkbox is deselected.");
                }
            }
        });

        // Add checkbox to the JFrame
        frame.add(checkBox);
        frame.setVisible(true);
    }
}
```

# `KeyListener` in Swing

Swing provides the `KeyListener` interface to detect and respond to keyboard events. It's particularly useful for components that need to process key presses, key releases, or key types.

## Overview

The `KeyListener` interface offers three methods to manage keyboard events:

1. `keyTyped(KeyEvent e)`: Invoked when a key is typed (pressed and then released).
2. `keyPressed(KeyEvent e)`: Called when a key is pressed.
3. `keyReleased(KeyEvent e)`: Invoked when a key is released.

## Example Usage

Below is an example demonstrating the use of the `KeyListener` interface with a `JTextField`:

```java
import javax.swing.JFrame;
import javax.swing.JTextField;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

public class KeyListenerExample {

    public static void main(String[] args) {
        // Create a new JFrame
        JFrame frame = new JFrame("KeyListener Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(null);

        // Create a JTextField
        JTextField textField = new JTextField();
        textField.setBounds(50, 80, 200, 30);

        // Add KeyListener to JTextField
        textField.addKeyListener(new KeyListener() {
            @Override
            public void keyTyped(KeyEvent e) {
                System.out.println("Key typed: " + e.getKeyChar());
            }

            @Override
            public void keyPressed(KeyEvent e) {
                System.out.println("Key pressed: " + KeyEvent.getKeyText(e.getKeyCode()));
            }

            @Override
            public void keyReleased(KeyEvent e) {
                System.out.println("Key released: " + KeyEvent.getKeyText(e.getKeyCode()));
            }
        });

        // Add textField to the JFrame
        frame.add(textField);
        frame.setVisible(true);
    }
}
```

# `MouseListener` in Swing

In the Java Swing toolkit, the `MouseListener` interface is crucial for detecting and handling mouse interactions on components. It provides methods to capture various mouse actions, including clicks, presses, releases, entries, and exits.

## Overview

The `MouseListener` contains five core methods to manage mouse events:

1. `mouseClicked(MouseEvent e)`: Triggered when a mouse button is clicked (pressed and then released).
2. `mousePressed(MouseEvent e)`: Invoked when a mouse button is pressed.
3. `mouseReleased(MouseEvent e)`: Triggered when a mouse button is released.
4. `mouseEntered(MouseEvent e)`: Called when the mouse enters a component's boundary.
5. `mouseExited(MouseEvent e)`: Invoked when the mouse exits a component's boundary.

## Example Usage

Let's walk through an example using the `MouseListener` interface with a `JPanel`:

```java
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Color;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

public class MouseListenerExample {

    public static void main(String[] args) {
        // Create a new JFrame
        JFrame frame = new JFrame("MouseListener Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(null);

        // Create a JPanel
        JPanel panel = new JPanel();
        panel.setBounds(50, 50, 200, 100);
        panel.setBackground(Color.LIGHT_GRAY);

        // Add MouseListener to JPanel
        panel.addMouseListener(new MouseListener() {
            @Override
            public void mouseClicked(MouseEvent e) {
                System.out.println("Panel clicked at: " + e.getX() + ", " + e.getY());
            }

            @Override
            public void mousePressed(MouseEvent e) {
                panel.setBackground(Color.DARK_GRAY);
            }

            @Override
            public void mouseReleased(MouseEvent e) {
                panel.setBackground(Color.LIGHT_GRAY);
            }

            @Override
            public void mouseEntered(MouseEvent e) {
                System.out.println("Mouse entered the panel.");
            }

            @Override
            public void mouseExited(MouseEvent e) {
                System.out.println("Mouse exited the panel.");
            }
        });

        // Add panel to the JFrame
        frame.add(panel);
        frame.setVisible(true);
    }
}
```

# `WindowListener` in Swing

Swing's `WindowListener` interface is designed to handle window state changes and lifecycle events. This listener provides methods to capture various window-related actions, such as opening, closing, activation, and deactivation.

## Overview

The `WindowListener` interface provides the following methods:

1. `windowOpened(WindowEvent e)`: Invoked when a window is opened for the first time.
2. `windowClosing(WindowEvent e)`: Triggered when a window is in the process of being closed (e.g., the close button is clicked).
3. `windowClosed(WindowEvent e)`: Called after a window has been closed.
4. `windowIconified(WindowEvent e)`: Triggered when a window is minimized.
5. `windowDeiconified(WindowEvent e)`: Invoked when a window is restored from a minimized state.
6. `windowActivated(WindowEvent e)`: Triggered when a window is set to be the active window.
7. `windowDeactivated(WindowEvent e)`: Called when a window is no longer the active window.

## Example Usage

Here's an example demonstrating the use of the `WindowListener` with a `JFrame`:

```java
import javax.swing.JFrame;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

public class WindowListenerExample {

    public static void main(String[] args) {
        // Create a new JFrame
        JFrame frame = new JFrame("WindowListener Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE); // Custom handling for window close

        // Add WindowListener to JFrame
        frame.addWindowListener(new WindowListener() {
            @Override
            public void windowOpened(WindowEvent e) {
                System.out.println("Window opened!");
            }

            @Override
            public void windowClosing(WindowEvent e) {
                System.out.println("Window is closing...");
                frame.dispose();  // Close and dispose of the window
            }

            @Override
            public void windowClosed(WindowEvent e) {
                System.out.println("Window has closed.");
            }

            @Override
            public void windowIconified(WindowEvent e) {
                System.out.println("Window minimized.");
            }

            @Override
            public void windowDeiconified(WindowEvent e) {
                System.out.println("Window restored.");
            }

            @Override
            public void windowActivated(WindowEvent e) {
                System.out.println("Window activated!");
            }

            @Override
            public void windowDeactivated(WindowEvent e) {
                System.out.println("Window deactivated.");
            }
        });

        frame.setVisible(true);
    }
}
```

# `AdjustmentListener` in Swing

In Java's Swing toolkit, the `AdjustmentListener` interface is designated to manage adjustment events. These events are commonly triggered by components such as `JScrollBar` when the user modifies its value.

## Overview

The `AdjustmentListener` interface has a single method to deal with adjustment events:

- `adjustmentValueChanged(AdjustmentEvent e)`: This method is invoked when the value of an adjustable component changes.

## Example Usage

Here's a hands-on example demonstrating the application of the `AdjustmentListener` with a `JScrollBar`:

```java
import javax.swing.JFrame;
import javax.swing.JScrollBar;
import javax.swing.JLabel;
import java.awt.BorderLayout;
import java.awt.event.AdjustmentEvent;
import java.awt.event.AdjustmentListener;

public class AdjustmentListenerExample {

    public static void main(String[] args) {
        // Create a new JFrame
        JFrame frame = new JFrame("AdjustmentListener Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Create a vertical JScrollBar
        JScrollBar scrollBar = new JScrollBar(JScrollBar.VERTICAL);
        JLabel label = new JLabel("Value: 0");

        // Add AdjustmentListener to JScrollBar
        scrollBar.addAdjustmentListener(new AdjustmentListener() {
            @Override
            public void adjustmentValueChanged(AdjustmentEvent e) {
                int value = e.getValue();
                label.setText("Value: " + value);
            }
        });

        frame.add(scrollBar, BorderLayout.EAST);
        frame.add(label, BorderLayout.CENTER);

        frame.setVisible(true);
    }
}
```

# `ContainerListener` in Swing

In the Swing framework, the `ContainerListener` interface provides methods to listen for and respond to events related to the addition or removal of components from a container, like a `JPanel` or `JFrame`.

## Overview

The `ContainerListener` interface comes with two primary methods:

1. `componentAdded(ContainerEvent e)`: Called when a component is added to the container.
2. `componentRemoved(ContainerEvent e)`: Invoked when a component is removed from the container.

## Example Usage

Below is an example showcasing the use of the `ContainerListener` with a `JFrame` and a couple of buttons:

```java
import javax.swing.JFrame;
import javax.swing.JButton;
import javax.swing.JPanel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ContainerEvent;
import java.awt.event.ContainerListener;

public class ContainerListenerExample {

    public static void main(String[] args) {
        // Create a new JFrame
        JFrame frame = new JFrame("ContainerListener Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // JPanel as container
        JPanel panel = new JPanel();
        
        // Buttons for adding and removing a sample component
        JButton addButton = new JButton("Add Component");
        JButton removeButton = new JButton("Remove Component");

        JLabel label = new JLabel("Sample Component");
        
        addButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                panel.add(label);
                panel.revalidate();
                panel.repaint();
            }
        });

        removeButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                panel.remove(label);
                panel.revalidate();
                panel.repaint();
            }
        });

        // Add ContainerListener to JPanel
        panel.addContainerListener(new ContainerListener() {
            @Override
            public void componentAdded(ContainerEvent e) {
                System.out.println("Component added to the container!");
            }

            @Override
            public void componentRemoved(ContainerEvent e) {
                System.out.println("Component removed from the container!");
            }
        });

        panel.add(addButton);
        panel.add(removeButton);
        frame.add(panel);

        frame.setVisible(true);
    }
}
```

# `MouseMotionListener` in Swing

The `MouseMotionListener` interface in Java's Swing framework is responsible for monitoring mouse movements within a component. Unlike the `MouseListener` which focuses on click-based events, the `MouseMotionListener` captures actions like dragging and moving.

## Overview

The `MouseMotionListener` interface comprises two core methods:

1. `mouseDragged(MouseEvent e)`: Invoked when a mouse button is pressed and the cursor is dragged.
2. `mouseMoved(MouseEvent e)`: Called when the mouse cursor is moved within a component but no buttons are pressed.

## Example Usage

Here's an example illustrating the use of the `MouseMotionListener` with a `JPanel`:

```java
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Color;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionListener;

public class MouseMotionListenerExample {

    public static void main(String[] args) {
        // Create a new JFrame
        JFrame frame = new JFrame("MouseMotionListener Example");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(null);

        // Create a JPanel
        JPanel panel = new JPanel();
        panel.setBounds(50, 50, 200, 100);
        panel.setBackground(Color.LIGHT_GRAY);

        // Add MouseMotionListener to JPanel
        panel.addMouseMotionListener(new MouseMotionListener() {
            @Override
            public void mouseDragged(MouseEvent e) {
                System.out.println("Mouse dragged at: " + e.getX() + ", " + e.getY());
            }

            @Override
            public void mouseMoved(MouseEvent e) {
                System.out.println("Mouse moved at: " + e.getX() + ", " + e.getY());
            }
        });

        // Add panel to the JFrame
        frame.add(panel);
        frame.setVisible(true);
    }
}
```