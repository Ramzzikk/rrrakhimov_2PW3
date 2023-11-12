## FAQ/Code Explanation

### Q: What issues prevent us from using storyboards in real projects?

**A:** Some issues include:
- **Merge Conflicts**: In teams, when multiple developers work on the same storyboard file, resolving merge conflicts can be challenging.
- **Compilation Time**: Large storyboards can increase compilation times.
- **Limited Customization**: Some UI customizations might be code-driven and cannot be represented in the storyboard.
- **Navigation Complexity**: For complex navigations, code-driven solutions might provide clearer oversight than segues in a storyboard.

### Q: What does the code on lines 25 and 29 do?

**A:**
- **Line 25**: `title.translatesAutoresizingMaskIntoConstraints = false` disables the automatic conversion of autoresizing masks into constraints, which means you’ll be using Auto Layout to place and size views.
- **Line 29**: `view.addSubview(title)` adds the title UILabel as a subview to the main view of the view controller.

### Q: What is a safe area layout guide?

**A:** A safe area layout guide represents the portion of the view that is not obscured by navigation bars, tab bars, toolbars, and other ancestors. Utilizing the safe area guide allows developers to layout UI elements in a way that they are not hidden by these bars or the sensor housing/notch on devices like the iPhone X.

### Q: What is `[weak self]` on line 23 and why is it important?

**A:** `[weak self]` is used to prevent a strong reference cycle (retain cycle) between the closure and the class instance (`self`). Making `self` weak means that it becomes optional and does not keep a strong hold on the instance it refers to, preventing memory leaks.

### Q: What does `clipsToBounds` mean?

**A:** `clipsToBounds` is a property that determines whether subviews are confined to the bounds of their superview. If `clipsToBounds` is set to true, any content of a view that is drawn outside the view’s bounds is clipped to those bounds.

### Q: What is the `valueChanged` type? What is `Void` and what is `Double`?

**A:** 
- `valueChanged` in the provided context is a closure property in the CustomSlider class that gets triggered when the slider’s value changes. It accepts a parameter of type `Double` (a 64-bit floating-point number) and returns `Void` (meaning it does not return any value).
- **Double**: A 64-bit floating-point number, used to hold decimal values.
- **Void**: It's a type that represents the absence of a value.
